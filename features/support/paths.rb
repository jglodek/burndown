module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/home'

    when /^root page$/
      '/'
			
    when /^my projects page$/
      '/projects'

		when /^login page$/
			'/login'
		
		when /^my account page$/
			'/account'
			
		when /^terms of use page$/
			'/terms_of_use'
			
		when /^sign up page$/
			'/signup'
		
		when /^change email page$/
			'/account/change_email'
			
		when /^change name page$/
			'/account/change_name'
			
		when /^change password page$/
			'/account/change_password'
			
		when /^delete account page$/
			'/account/delete'
		
		when /^terms of use page$/
			'/terms_of_use'
			
		when /^help page$/
			'/help'
			
		when /^this project's page$/
			'/projects/' + @project.id.to_s

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
