class ProjectsController < ApplicationController
	before_filter :only_if_logged_in

	def index
		@all_projects = @current_user.projects
	end
	
	def show
		@project = Project.find_by_id(params[:id])
		if @project
			if @project_membership = ProjectMembership.where(:user_id => @current_user.id, :project_id => @project.id).first
			else
				flash[:notice] = "You dont have access to this, project."
				redirect_to root_url
			end
		else
			flash[:notice] = "Project does not exist."
			redirect_to root_url
		end
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
			flash[:error] = "Failed to create project"
			redirect_to projects_path()
		end
	end
	
end
