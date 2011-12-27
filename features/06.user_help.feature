Feature:
	In order to know how to and on what terms do I use burndown web app 
	As an user
	I want to have access to help page and know the terms of use
	
	Scenario: looking at links
		Given I am on the home page
		And I should see "Home"
		And I should see "Help"
		And I should see "Terms of use"
		
	Scenario: Help
		Given I am on the home page
		When I follow "Help"
		Then I should see "List of contents"
		And I should see "Creating an account"
		And I should see "Editing account info"
		And I should see "Removing account"
		And I should see "Managing projects"
		And I should see "Creating a project"
		And I should see "Adding items to backlog"
		And I should see "Managing backlog items"
		And I should see "Removing items from backlog"
		And I should see "Creating burn-down chart"
		And I should see "Saving burn-down chart to disc"
		And I should see "Sharing project"
		And I should see "Removing project"
		
	Scenario: Terms of use signup info
		Given I am not logged in
		And I am on sign up page
		And I should see "terms of use"
		
	Scenario: looking at terms of use
		Given I am on the home page
		When I follow "Terms of use"
		Then I should be on terms of use page
		
