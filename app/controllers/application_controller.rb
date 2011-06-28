class ApplicationController < ActionController::Base	
	protect_from_forgery
	before_filter :current_user 

 	def current_user
 		if session[:user_id]
 			 @current_user = User.find_by_id(session[:user_id])
 			 if @current_user == nil
 			 		reset_session
 			 end
 		end
 	end
 		
end
