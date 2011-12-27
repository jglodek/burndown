class InvitationsController < ApplicationController

	def join
		sl = InvitationLink.find_by_key(params[:id])
		if !sl 
			redirect_to root_path(), :notice => "Invitation link is invalid"
			return
		end
		if !@current_user
			render "signup"
		else
			if sl.project.project_memberships.where(:user_id => @current_user.id).first != nil
				redirect_to project_path(sl.project)
				return
			end
			pm = ProjectMembership.new
			pm.project = sl.project
			pm.user = @current_user
			pm.role = ProjectMembership::VISITOR
			if !pm.save
				redirect_to root_path(), :notice => "Invitation link doesn't work"
			else
				redirect_to project_path(sl.project), :notice => "Welcome to project '#{sl.project.title}'!"
			end
		end
	end
	
	def destroy
		il = InvitationLink.find_by_id(params[:id])
		if !il
			redirect_to root_path(), :notice => "Could not find invitation link"
			return
		end
		p = il.project
		if p.authorized_owner? @current_user
			il.destroy
			redirect_to project_path(p)
		else
			respond_no_access_to_project
		end
	end
end
