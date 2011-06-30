class ApplicationController < ActionController::Base	
	protect_from_forgery
	
	helper_method :logged_in	
	before_filter :current_user 

	def logged_in?
		return @current_user != nil
	end
	
	def only_if_logged_in
		if not logged_in?
			flash[:notice] = "You must be logged in to access this site."
			redirect_to root_url
		end	
	end
	
 	def current_user
 		if session[:user_id]
 			 @current_user = User.find_by_id(session[:user_id])
 			 if @current_user == nil
 			 		reset_session
 			 end
 		end
 	end 		
end
