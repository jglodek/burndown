Feature: 
	In order to access data of my projects
	As an user
	I want to log in

	Scenario: not logged in
		Given I am not logged in
		When I am on the home page
		Then I should see "You're not logged in"

	Scenario: login, account does not exist
		Given I am not logged in
		When I am on the home page
		And I follow "Login"
		And I fill in "Email" with "testowy@mail.pl"
		And I fill in "Password" with "testowe_hasło123"
		And I press "Log in"
		Then I should see "Invalid email or password"
		And I should be on login page
	
	Scenario: login, wrong password
		Given I am not logged in
		And user with email "testowy@mail.pl" and password "testowe_hasło333" exists
		When I am on the login page
		And I fill in "Email" with "testowy@email.pl"
		And I fill in "Password" with "inne_hasło"
		And I press "Log in"
		Then I should see "Invalid email or password"
		And I should be on login page
		
	Scenario: login, success
		Given I am not logged in
		And user with name "Ryszard Ochucki" email "webtest@mail.pl" and password "testowe_haslo999" exists
		When I am on the login page
		And I fill in "Email" with "webtest@mail.pl"
		And I fill in "Password" with "testowe_haslo999"
		And I press "Log in"
		Then I should see "Logged in!"
		And I should see "You're logged in as Ryszard Ochucki"
		And I should see "Logout"
		Then I should be on my projects page
		
