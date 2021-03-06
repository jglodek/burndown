class ProjectsController < ApplicationController
	before_filter :only_if_logged_in
	before_filter :get_project_for_owner, :only => [:edit, :update, :destroy, :finish, :unfinish, :create_invitation_link, :block_user, :make_owner]
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
	
	def create_invitation_link
		il = InvitationLink.new
		il.project = @project
		il.generate_key
		if !il.save
			redirect_to project_path @project, :error => "Could not create link"
		else
			redirect_to project_path @project, :notice => "Invitation link successfuly created"
		end
	end
	
	def block_user
		pm = ProjectMembership.where(:project_id => params[:id], :user_id => params[:id2]).first
		if pm.role == ProjectMembership::OWNER
			redirect_to project_path(@project), :error => "Cannot remove owner from project"
		else
			pm.destroy
			redirect_to project_path(@project), :notice => "User blocked"
		end
	end
	
	def make_owner
		pm = ProjectMembership.where(:project_id => params[:id], :user_id => params[:id2]).first
		pm.role = ProjectMembership::OWNER
		if !pm.save
			redirect_to project_path(@project), :error => "Error sharing ownership"		
		else
			redirect_to project_path(@project), :notice => "Successfuly shared ownership with user"
		end
	end
	
private 
	def get_project_for_reader
		@project = Project.find_by_id(params[:id])
		if @project!= nil && @project.authorized_reader?(@current_user)
			@project_membership = @project.project_memberships.where(:user_id => @current_user.id).first
			if @project_membership.role == ProjectMembership::OWNER
				@owner = true
			end
		else
			respond_no_access_to_project
		end
	end
	
	def get_project_for_owner
		@project = Project.find_by_id(params[:id])
		if @project != nil && @project.authorized_owner?(@current_user)
			@owner = true
			@project_membership = @project.project_memberships(:user_id => @current_user.id).first
		else
			respond_no_access_to_project
		end
	end

end
