module ApplicationHelper
	
 	def role_to_string(p)
 		case p[:role]
			when 0 
				'creator'
			when 1
				'admin'
			when 2 
				'moderator'
			when 3
				'member'
			else
				'none'
		end
 	end
 	
end
