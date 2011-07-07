class UsersController < ApplicationController
	before_filter :only_if_logged_in, :only => [:destroy, :show, :update, :edit_email, :edit_name, :edit_password]
	
	def new
			@user = User.new
	end
	
	def create
		@user = User.new(params[:user])
		if(@user && @user.save)
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end	
	end

	def edit_password
		if request.put?
			if params[:user][:password]
				if @current_user.authenticate(params[:user][:old_password])
					@current_user.password = params[:user][:password]
					@current_user.password_confirmation = params[:user][:password_confirmation]	
				else
					@current_user.errors.add(:password, "incorrect")
					render "edit_password"
					return
				end
			else
				redirect_to root_url
				return
			end
			if @current_user.save
				flash[:notice] = "Password changed"
				redirect_to account_path
			else
				render "edit_password"
			end
		end
	end
	
	def edit_name
		if request.put?
			if params[:user][:name]
				@current_user.name = params[:user][:name]
			else
				redirect_to root_url
			end
			if @current_user.save
				flash[:notice] = "Name changed"
				redirect_to account_path
			else
				render "edit_name"
			end
		end
	end
	
	def edit_email
		if request.put?
			if params[:user][:email]
				@current_user.email = params[:user][:email]
			else
				redirect_to root_url
			end
			if @current_user.save
				flash[:notice] = "Email changed"
				redirect_to account_path
			else
				render "edit_email"
			end
		end
	end
	
	def destroy
		if request.delete?
			if @current_user
				if @current_user.email == params[:email]
					if @current_user.authenticate(params[:password])
						@current_user.destroy
						reset_session
						redirect_to root_url, :notice => "User account deleted"
					else
						@current_user.errors.add(:password, "incorrect")
						render "destroy"
					end
				else
					@current_user.errors.add(:email, "incorrect")
					render "destroy"
				end
			else
				redirect_to root_url
			end
		end
	end
	def show
	end
	
end
