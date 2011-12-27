
When /^I am fill sign up form properly$/ do
	step %{I fill in "Name" with "Joe the tester"}
	step %{I fill in "Email" with "Joe@testers.com"}
	step %{I fill in "Email confirmation" with "Joe@testers.com"}
	step %{I fill in "Password" with "Some password"}
	step %{I fill in "Password confirmation" with "Some password"}
	step %{I press "Sign up!"}
end


When /^I am fill sign up form with wrong password confirmation$/ do
	step %{I fill in "Name" with "Joe the tester"}
	step %{I fill in "Email" with "Joe@testers.com"}
	step %{I fill in "Email confirmation" with "Joe@testers.com"}
	step %{I fill in "Password" with "Some password"}
	step %{I fill in "Password confirmation" with "Some passworadsad"}
	step %{I press "Sign up!"}
end


When /^I am fill sign up form with wrong email confirmation$/ do
	step %{I fill in "Name" with "Joe the tester"}
	step %{I fill in "Email" with "Joe@testers.com"}
	step %{I fill in "Email confirmation" with "Joeasddsa@testaaers.com"}
	step %{I fill in "Password" with "Some password"}
	step %{I fill in "Password confirmation" with "Some password"}
	step %{I press "Sign up!"}
end

