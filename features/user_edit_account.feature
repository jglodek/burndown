Feature:
	In order to change password, update name and email
	As an logged user
	I want to edit my account details
	
	Scenario: access account, through account link
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on the home page
		Then I should see "Account"
		When I follow "Account"
		Then I should be on my account page
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com" 
		And I should see "Change name"
		And I should see "Change email"
		And I should see "Change password"
		
	Scenario: access account, through login box
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on the home page
		Then I should see "Wacław Testowski"
		When I follow "Wacław Testowski"
		Then I should be on my account page
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com" 
		And I should see "Change name"
		And I should see "Change email"
		And I should see "Change password"
		
	Scenario: change name
		Given I am logged in as user with name "Wacław Teztowski" email "waclaw@testers.com" and password "my_hidden_password" 
		When I am on my account page
		And I should see "Wacław Teztowski"
		When I follow "Change name"
		Then I should see "Old name"
		And I should see "Wacław Teztowski"
		And I should see "New name"
		When I fill in "New name" with "Wacław Testowski"
		And I press "Change name"
		Then I should see "Name changed"
		And I should be on my account page
		And I should see "Wacław Testowski"
	
	Scenario: change email
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		When I am on my account page
		Then I should see "Change email"
		And I should see "Wacław Testowski"
		And I should see "waclaw_old_email@testers.com"
		When I follow "Change email"
		Then I should see "Old email"
		And I should see "waclaw_bad_email@testers.com"
		And I should see "New email"
		When I fill in "New email" with "waclaw@testers.com"
		Then I should be on my account page
		And I should see "Email updated"
		And I should see "Wacław Testowski"
		And I should see "waclaw@testers.com"
	
	Scenario: change email, already taken
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		And user with email "waclaw@testers.com" exist
		When I am on my account page
		Then I should see "Change email"
		And I should see "Wacław Testowski"
		And I should see "waclaw_bad_email@testers.com"
		When I follow "Change email"
		Then I should see "Old email"
		And I should see "waclaw_old_email@testers.com@testers.com"
		And I should see "New email"
		When I fill in "New email" with "waclaw@testers.com"
		Then I should be on email change page
		And I should see "used by other user!"
		And I should see "waclaw_old_email@testers.com"
	
	Scenario: change email, wrong format
		Given I am logged in as user with name "Wacław Testowski" email "waclaw_old_email@testers.com" and password "my_hidden_password" 
		When I am on my account page
		Then I should see "Change email"
		And I should see "Wacław Testowski"
		And I should see "waclaw_bad_email@testers.com"
		When I follow "Change email"
		Then I should see "Old email"
		And I should see "waclaw_old_email@testers.com@testers.com"
		And I should see "New email"
		When I fill in "New email" with "waclawtesters.com"
		Then I should be on email change page
		And I should see "Wrong email format"
		And I should see "waclaw_old_email@testers.com"
		
	Scenario: change password
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		Then I should see "Change password"
		And I should see "Wacław Testowski"
		When I follow "Change password"
		Then I should see "Old password"
		And I should see "New password"
		When I fill in "Old password" with "old_password"
		When I fill in "Old password confirmation" with "old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "new_password"
		And I press "Change password"
		Then I should be on my account page
		And I should see "Password changed"
		When I log out
		And I go to login page
		And I fill in "Email" with "waclaw@testers.com"
		And I fill in "Password" with "old_password"
		Then I should see "Wrong email or password"
		When I fill in "Email" with "waclaw@testers.com"
		And I fill in "Password" with "new_password"
		Then I should be logged in
		
	
	Scenario: change password, wrong old password confirmation
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		Then I should see "Change password"
		And I should see "Wacław Testowski"
		When I follow "Change password"
		Then I should see "Old password"
		And I should see "New password"
		When I fill in "Old password" with "old_password"
		When I fill in "Old password confirmation" with "obviously_not_old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "new_password"
		And I press "Change password"
		Then I should be on my account page
		And I should see "doesn't match"
		
	Scenario: change password, wrong new password confirmation
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		Then I should see "Change password"
		And I should see "Wacław Testowski"
		When I follow "Change password"
		Then I should see "Old password"
		And I should see "New password"
		When I fill in "Old password" with "old_password"
		When I fill in "Old password confirmation" with "old_password"
		And I fill in "New password" with "new_password"
		And I fill in "New password confirmation" with "obviously_not_new_password"
		And I press "Change password"
		Then I should be on my account page
		And I should see "doesn't match"
		
	Scenario: change password, wrong new password
		Given I am logged in as user with name "Wacław Testowski" email "waclaw@testers.com" and password "old_password" 
		When I am on my account page
		Then I should see "Change password"
		And I should see "Wacław Testowski"
		When I follow "Change password"
		Then I should see "Old password"
		And I should see "New password"
		When I fill in "Old password" with "old_password"
		When I fill in "Old password confirmation" with "old_password"
		And I fill in "New password" with "bad"
		And I fill in "New password confirmation" with "bad"
		And I press "Change password"
		Then I should be on my account page
		And I should see "Wrong format of new password"
		
