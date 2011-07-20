
Then /^I should be logged out$/ do
	Then %{ I should see "You're not logged in." }
end


Then /^user with email "([^"]*)" should exist$/ do |email|
	User.find_by_email( email ).should_not == nil
end

Then /^user with email "([^"]*)" exists$/ do |email|
	user = User.new
	user.email = email 
	user.name = "Name"
	user.password = "bleble"
	user.password_confirmation = "bleble"
	user.save!
end


Then /^user with email "([^"]*)" should not exist$/ do |email|
	user = User.find_by_email(email)
	user.should == nil
end


Given /^user with email "([^"]*)" and password "([^"]*)" exists$/ do |email, password|
	user = User.new
	user.email = email 
	user.name = "Name"
	user.password = password
	user.password_confirmation = password
	user.save!
end

Given /^user with name "([^"]*)" email "([^"]*)" and password "([^"]*)" exists$/ do |name,email, password|
	user = User.new
	user.email = email 
	user.name = name
	user.password = password
	user.password_confirmation = password
	user.save!
end

Given /^I am logged in$/ do
	name = "Test Testowski"
	email = "test@testers.com"
	password = "haslo_maslo"
	Given %{user with name "#{name}" email "#{email}" and password "#{password}" exists}
	And %{I am on the login page}
	And %{I fill in "Email" with "#{email}"}
	And %{I fill in "Password" with "#{password}"}
	And %{I press "Log in"}
	@user = User.find_by_email("test@testers.com").first
end

Given /^I am logged in as user with name "([^"]*)" email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
	Given %{user with name "#{name}" email "#{email}" and password "#{password}" exists}
	And %{I am on the login page}
	And %{I fill in "Email" with "#{email}"}
	And %{I fill in "Password" with "#{password}"}
	And %{I press "Log in"}
	@user = User.find_by_email(email).first
end

Given /^I am logged in as user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
	Given %{user with name "Adolf" email "#{email}" and password "#{password}" exists}
	And %{I am on the login page}
	And %{I fill in "Email" with "#{email}"}
	And %{I fill in "Password" with "#{password}"}
	And %{I press "Log in"}
	@user = User.find_by_email(email).first
end

Given /^I am logged in as user with email "([^"]*)"$/ do |name|
	Given %{user with name "Est Testowski" email "#{email}" and password "password" exists}
	And %{I am on the login page}
	And %{I fill in "Email" with "#{email}"}
	And %{I fill in "Password" with "password"}
	And %{I press "Log in"}
	@user = User.find_by_email("email").first
end

Then /^I should be logged in$/ do
	Then %{I should see "You're logged in as"}
end

When /^I log out$/ do
	When %{I follow "Logout"}
end


Given /^I am not logged in$/ do
end

