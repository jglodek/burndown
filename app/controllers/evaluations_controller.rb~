class EvaluationsController < ApplicationController
  before_filter :only_if_logged_in
	before_filter :get_evaluation, :only => [:edit, :update, :destroy]

	def new
		@evaluation = Evaluation.new
		@evaluation.evaluation_type = Evaluation::COST_EVALUATION
		@evaluation.backlog_item_id = params[:backlog_item_id]
		if !@evaluation.authorized_owner? @current_user
			respond_no_access_to_project
			return
		end
		@value = @evaluation.backlog_item.recent_cost
	end
	
	def create
		@evaluation = Evaluation.new(params[:evaluation])
		@evaluation.evaluation_type = Evaluation::COST_EVALUATION
		@backlog_item= BacklogItem.find_by_id(params[:evaluation][:backlog_item_id])
		if @backlog_item==nil
			respond_no_access_to_project
			return
		end
		@evaluation.backlog_item = @backlog_item
		if !@evaluation.authorized_owner? @current_user
			respond_no_access_to_project
			return
		end
		if @evaluation.save
			redirect_to backlog_item_path(@evaluation.backlog_item), :notice => "Evaluation created successfuly"
		else
			render action: "new"
		end
	end

  def edit
		@value = @evaluation.value
	end

	def update
		if !@evaluation.update_attributes(params[:evaluation])
			render action: "edit"
 		else
			redirect_to backlog_item_path(@evaluation.backlog_item.id), :notice => "Evaluation updated successfuly!"
		end
  end

	def destroy
		@evaluation.destroy
		redirect_to backlog_item_path(@evaluation.backlog_item.id), :notice => "Evaluation deleted"
	end
	
private
	def get_evaluation
		@evaluation = Evaluation.find_by_id(params[:id])
		if !@evaluation.authorized_owner? @current_user
			respond_no_access_to_project
			return
		end
	end

end
