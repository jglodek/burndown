Feature:
	In order to change password, update name and email
	As an logged user
	I want to edit my account details
	
	Scenario: looking at my account page
		Given I am logged in
		And I am on my account page
		Then I should see "Change name"
		And I should see "Change email"
		And I should see "Change password"
	
	Scenario: not logged in
		Given I am not logged in
		When I go to my account page
		Then I should be on root page
	
	Scenario: access account, through account link
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on the home page
		Then I should see "Account"
		When I follow "Account"
		Then I should be on my account page
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com"
		
	Scenario: access account, through login box
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on the home page
		Then I should see "Wacław Testowski"
		When I follow "Wacław Testowski"
		Then I should be on my account page
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com" 
		
	Scenario: looking at change email page
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		And I am on my account page 
		When I follow "Change email"
		Then I should be on change email page
		And I should see field "Email" with value "waclaw@testers.com"
		And I should see button "Change email"
		
	Scenario: looking at change name page
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		And I am on my account page 
		When I follow "Change name"
		Then I should be on change name page
		And I should see field "Name" with value "Wacław Testowski"
		And I should see button "Change name"
		
	Scenario: looking at change password page
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		And I am on my account page
		When I follow "Change password"
		Then I should be on change password page
		And I should see field "Old password"
		And I should see field "New password"
		And I should see field "New password confirmation"
		And I should see button "Change password"
		
	Scenario: change name
		Given I am logged in as user with name "Wacław Teztowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on my account page
		When I follow "Change name"
		And I should see "Wacław Teztowski"
		When I fill in "Name" with "Wacław Testowski"
		And I press "Change name"
		And I should be on my account page
		And I should see "Wacław Testowski"
	
	Scenario: change email
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		When I am on my account page
		When I follow "Change email"
		When I fill in "Email" with "waclaw@testers.com"
		When I fill in "Email confirmation" with "waclaw@testers.com"
		And I press "Change email"
		Then I should be on my account page
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com"
	
	Scenario: change email, wrong confirmation
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		When I am on my account page
		When I follow "Change email"
		When I fill in "Email" with "waclaw@testers.com"
		When I fill in "Email confirmation" with "waclaw@tasadasesters.com"
		And I press "Change email"
		Then I should be on change email page
		And I should see "Email doesn't match confirmation"
	
	Scenario: change email, already taken
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		And user with email "waclaw@testers.com" exists
		When I am on my account page
		When I follow "Change email"
		When I fill in "Email" with "waclaw@testers.com"
		When I fill in "Email confirmation" with "waclaw@testers.com"
		And I press "Change email"
		Then I should be on change email page
		And I should see "Email has already been taken"
	
	Scenario: change email, wrong format
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		When I am on my account page
		And I follow "Change email"
		And I fill in "Email" with "waclawtesters.com"
		When I fill in "Email confirmation" with "waclaw@testers.com"
		And I press "Change email"
		Then I should see "invalid format"
		And I should be on change email page
		
	Scenario: change password
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		When I follow "Change password"
		When I fill in "Old password" with "old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "new_password"
		And I press "Change password!"
		Then I should be on my account page
		And I should see "Password changed"
		When I log out
		And I go to login page
		And I fill in "Email" with "waclaw@testers.com"
		And I fill in "Password" with "old_password"
		And I press "Log in"
		Then I should see "Invalid email or password"
		When I fill in "Email" with "waclaw@testers.com"
		And I fill in "Password" with "new_password"
		And I press "Log in"
		Then I should be logged in
			
	Scenario: change password, wrong new password confirmation
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		When I follow "Change password"
		When I fill in "Old password" with "old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "obviously_not_new_password"
		When I press "Change password!"
		Then I should be on change password page
		And I should see "Password doesn't match confirmation"
		
	Scenario: change password, wrong new password
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		When I follow "Change password"
		When I fill in "Old password" with "old_password"
		And I fill in "New password" with "bad"
		And I fill in "New password confirmation" with "bad"
		And I press "Change password!"
		Then I should be on change password page
		And I should see "Password length should be within"
		
		
	Scenario: change password, wrong old password
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		When I follow "Change password"
		When I fill in "Old password" with "obviously_not_old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "new_password"
		And I press "Change password!"
		Then I should be on change password page
		And I should see "incorrect"

