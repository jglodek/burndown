class BacklogItemsController < ApplicationController
	before_filter :only_if_logged_in
	before_filter :get_backlog_item_for_owner, :only => [:edit, :update, :destroy, :finish]
	before_filter :get_backlog_item_for_visitor, :only => [:show]
	
	# GET /backlog_items
	def index
		render_404
	end
	
  # GET /backlog_items/1
  def show
		@backlog_items
  end

  # GET /backlog_items/new
  def new
    @backlog_item = BacklogItem.new
		if !params[:project_id]
			redirect_to projects_path
		end
		@backlog_item.project_id = params[:project_id]
  end
		

  # GET /backlog_items/1/edit
  def edit
		@can_finish = true
  end

	# GET /backlog_items/:id/finish
	#evaluates backlog item as finished
	def finish
		p = Evaluation.new
		p.effective_date = Time.now
		p.evaluation_type = Evaluation::FINISHED
		p.backlog_item = @backlog_item
		if !p.save
			flash[:error]= 'Unable to save evaluation!'
		else
			flash[:notice]= 'Item marked as finished!'
		end
		redirect_to backlog_item_path(@backlog_item)
	end
	
  # POST /backlog_items
  def create		
		@backlog_item = BacklogItem.new(params[:backlog_item])
		project = Project.find_by_id(params[:backlog_item][:project_id])
		if project == nil
			respond_no_access_to_project
			return
		end
		@backlog_item.project = project
		if !@backlog_item.project.authorized_owner?(@current_user)
			respond_no_access_to_project
			return
		end
		if @backlog_item.save
			if @backlog_item.cost && @backlog_item.cost != ""
				e = Evaluation.new
				e.backlog_item = @backlog_item
				e.evaluation_type = Evaluation::COST_EVALUATION
				e.effective_date = Time.now
				e.value = @backlog_item.cost
				if !e.save
					@backlog_item.errors.add(:cost, "evaluation encountered error.")
					render "new"
					return
				end
			end
			redirect_to @backlog_item, :notice => 'Backlog item was successfully created.'
		else
			render "new"
		end	
  end

  # PUT /backlog_items/1
  def update
		if !@backlog_item.finished? && params[:finished] == 'finished'
			p = Evaluation.new
			p.effective_date = Time.now
			p.evaluation_type = Evaluation::FINISHED
			p.backlog_item = @backlog_item
			if !p.save
				flash[:error]= 'Unable to save finishing evaluation!'
				redirect_to backlog_item_path(@backlog_item)
				return
			end
		else
			if params[:finished]==nil
				to_delete = Evaluation.where :backlog_item_id => @backlog_item.id, :evaluation_type =>Evaluation::FINISHED
				to_delete.destroy_all
			end
		end
		
		if params[:backlog_item][:cost] && params[:backlog_item][:cost]!="" && params[:backlog_item][:cost].to_i!=@backlog_item.recent_cost
				e = Evaluation.new
				e.backlog_item = @backlog_item
				e.evaluation_type = Evaluation::COST_EVALUATION
				e.effective_date = Time.now
				e.value = params[:backlog_item][:cost]
				if !e.save
					@backlog_item.errors.add(:cost, "evaluation encountered error.")
					render "edit"
					return
				end
			end
			
			if @backlog_item.update_attributes(params[:backlog_item])
			redirect_to @backlog_item, notice: 'Backlog item was successfully updated.' 
		else
			render"edit" 
		end
  end

  # DELETE /backlog_items/1
  def destroy
    @backlog_item = BacklogItem.find(params[:id])
    @backlog_item.destroy
		redirect_to project_path(@backlog_item.project) 
  end

private

	def get_backlog_item_for_owner
		@backlog_item = BacklogItem.find(params[:id])
		if !(@backlog_item && @backlog_item.authorized_owner?(@current_user))
			respond_no_access_to_project
		else
			@owner = true
		end
	end
	
	def get_backlog_item_for_visitor
		@backlog_item = BacklogItem.find(params[:id])
		if !(@backlog_item && @backlog_item.authorized_reader?(@current_user))
			respond_no_access_to_project
		else
			if @backlog_item.authorized_owner?(@current_user)
				@owner = true
			end
		end
	end
end
