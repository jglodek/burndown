Feature: 
	In order to be able to use application, with my data being accesible only to who i trust.
	As an unsigned user
	I want to sign in

	Scenario: user signs up, success
	Given I am not logged in
	When I am on the home page
	Then I should see "Sign up!"
	When I follow "Sign up"
	And I fill in "Name" with "Joe the tester"
	And I fill in "Email" with "Joe@testers.com"
	And I fill in "Password" with "Some password"
	And I fill in "Password confirmation" with "Some password"
	And I press "Sign up!"
	Then I should see "Signed up!"
	And user with email "Joe@testers.com" should exist
	
	Scenario: user signs up, but email is taken
	Given I am not logged in
	And user with email "Joe@testers.com" exists
	When I am on the home page
	Then I should see "Sign up!"
	When I follow "Sign up"
	And I fill in "Name" with "Joe the tester"
	And I fill in "Email" with "Joe@testers.com"
	And I fill in "Password" with "Some password"
	And I fill in "Password confirmation" with "Some password"
	And I press "Sign up!"
	Then I should see "Email has already been taken"
	
	Scenario: user signs up, but enters wrong password confirmation
	Given I am not logged in
	When I am on the home page
	Then I should see "Sign up!"
	When I follow "Sign up"
	And I fill in "Name" with "Joe the tester"
	And I fill in "Email" with "Joe@testers.com"
	And I fill in "Password" with "Some password"
	And I fill in "Password confirmation" with "Some other password"
	And I press "Sign up!"
	Then I should see "Password doesn't match confirmation"
	
