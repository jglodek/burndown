module ApplicationHelper
	
 	def project_role_to_string(p)
 		case p
			when ProjectMembership::OWNER 
				'owner'
			when ProjectMembership::VISITOR 
				'visitor'
		end
 	end

	#by lukeredpath http://snippets.dzone.com/posts/show/2348
	def display_standard_flashes(message = 'There were some problems with your submission:')
		if flash[:notice]
		  flash_to_display, level = flash[:notice], 'notice'
		elsif flash[:warning]
		  flash_to_display, level = flash[:warning], 'warning'
		elsif flash[:error]
		  level = 'error'
		  if flash[:error].instance_of? ActiveModel::Errors
		    flash_to_display = message
		    flash_to_display << activerecord_error_list(flash[:error])
		  else
		    flash_to_display = flash[:error]
		  end
		else
		  return
		end
		content_tag 'div', flash_to_display, :class => "flash #{level}"
	end

	def activerecord_error_list(errors)
		if errors
			error_list = '<ul class="error_list">'
			errors.each do |e, m|
				error_list.concat ("<li>#{ e.to_s.humanize unless e == "base"} #{m}</li>")
			end
			error_list
		end
	end
end
