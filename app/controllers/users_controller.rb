class UsersController < ApplicationController
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
	
	def destroy
		user = User.find(params[:id])
		user.destroy
		redirect_to root_url, :notice => "User account deleted!"
	end
	
end
