require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase	
	test "project role to string" do
		assert project_role_to_string(0) == 'owner'
		assert project_role_to_string(1) == 'visitor'
	end
	
	test "flash messages and activerrecord error list" do
		flash[:notice] = "notice"
		a = display_standard_flashes
		assert a != nil
		flash[:notice] = nil
		flash[:warning]= "warning"
		a = display_standard_flashes
		assert a != nil
		flash[:warning]= nil
		flash[:error] = "error"
		a = display_standard_flashes
		assert a != nil
		u = User.new
		u.save
		flash[:error] = u.errors
		a = display_standard_flashes
		assert a != nil
	end

end
