Feature:
	In order to hide my project data from other user ow my computer
	As a logged user
	I want to logout
	
	Scenario: logout
		Given I am logged in
		When I am on my projects page
		And I follow "Logout"
		Then I should see "Logged out"
		And I should see "You're not logged in"
		
