class ProjectsController < ApplicationController
	before_filter :only_if_logged_in
	before_filter :get_project_from_params, :only => [:show, :edit, :update, :destroy]
	def index
		@project_memberships = ProjectMembership.where(:user_id => @current_user.id).includes(:project)
	end
	
	def show
		@backlog_items = @project.backlog_items
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
			@project_membership.role = 0;
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

	def destroy	
		if request.delete?
			@project.destroy
			flash[:notice] = "Project '#{@project.title}' successfuly deleted"
			redirect_to projects_path
		end
	end
	
	
private 
	def get_project_from_params
		@project_membership = ProjectMembership.where(:user_id => @current_user.id, :project_id => params[:id] ).includes(:project).first
		if @project_membership
			@project = @project_membership.project
		else
			respond_no_access_to_project
		end
	end
end
