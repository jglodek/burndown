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
		Given I am logged in
		When I am on delete account page
		And I press "Cancel"
		Then I should be on my account page
		
	Scenario: remove account, success
		Given I am logged in as user with email "email@email.pl" and password "haslo"
		When I am on delete account page
		And I fill in "Email" with "email@email.pl"
		And I fill in "Password" with "haslo"
		And I press "Delete account"
		Then I should be on the home page
		And I should see "User account deleted"

	Scenario: remove account, bad email
		Given I am logged in as user with email "email@email.pl" and password "haslo"
		When I am on delete account page
		And I fill in "Email" with "email@emaial.pl"
		And I fill in "Password" with "haslo"
		And I press "Delete account"
		Then I should be on delete account page
		And I should see "Email incorrect"

	Scenario: remove account, bad password
		Given I am logged in as user with email "email@email.pl" and password "haslo"
		When I am on delete account page
		And I fill in "Email" with "email@email.pl"
		And I fill in "Password" with "haslomaslo"
		And I press "Delete account"
		Then I should be on delete account page
		And I should see "Password incorrect"