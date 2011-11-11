class ProjectsController < ApplicationController
	before_filter :only_if_logged_in
	before_filter :get_project_for_owner, :only => [:edit, :update, :destroy, :finish, :unfinish]
	before_filter :get_project_for_reader, :only => [:show]
	def index
		@project_memberships = ProjectMembership.where(:user_id => @current_user.id).includes(:project)
	end
	
	def show
		@backlog_items = @project.backlog_items.order("-priority DESC")
	end
	
	def new
		@project = Project.new
	end
	
	def create
		@project = Project.new(params[:project])
		if @project && @project.save
			@project_membership = ProjectMembership.new
			@project_membership.user = @current_user
			@project_membership.project = @project
			@project_membership.role = ProjectMembership::OWNER
			if @project_membership.save
				redirect_to @project
			else
				flash[:error] = "Failed to create project membership"
				@project.destroy
				redirect_to projects_path()
			end
		else
			render "new"
		end
	end
	
	def edit
	end

	def update
		if request.put?
			if @project.update_attributes (params[:project])
				redirect_to @project
			else
				render "edit_email"
			end
		end
	end

	def finish
		if @project.finished_at == nil
			@project.finished_at = Time.now
			if !@project.save
				flash[:error] = "Error marking project as finished"
			else
				flash[:notice] = "Project '#{@project.title}, marked as finished"
			end
		end
		redirect_to project_path @project
	end
	
	def unfinish
		if @project.finished_at != nil
			@project.finished_at = nil
			if !@project.save
				flash[:error] = "Error marking project as unfinished"
			else
				flash[:notice] = "Project '#{@project.title}', marked as unfinished"
			end
		end
		redirect_to project_path @project
	end
	
	def destroy	
		if request.delete?
			@project.destroy
			flash[:notice] = "Project '#{@project.title}' successfuly deleted"
			redirect_to projects_path
		end
	end
	
	
private 
	def get_project_for_reader
		@project = Project.find_by_id(params[:id])
		if @project!= nil && @project.authorized_reader?(@current_user)
			@project_membership = @project.owners_membership
		else
			respond_no_access_to_project
		end
	end
	
	def get_project_for_owner
		@project = Project.find_by_id(params[:id])
		if @project != nil && @project.authorized_owner?(@current_user)
			@project_membership = @project.owners_membership
		else
			respond_no_access_to_project
		end
	end

end
