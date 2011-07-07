Feature:
	In order to stop using web appliaction
	As an signed in user
	I want to be able to remove my account
	
	Scenario: looking at account
		Given I am logged in
		When I am on my account page
		Then I should see "Delete account"
		When I follow "Delete account"
		Then I should see "Notice"
		And I should see field "Email"
		And I should see field "Password"
		
	Scenario: removing account, accidentaly clicked
		Given I am logged in as user with email "tom@bombadil" and password "arpirates"
		When I am on delete account page		
		
	Scenario: remove account
		Given I am logged in as user with email "tom@bombadil.com"
		


	
