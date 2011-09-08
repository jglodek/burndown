Feature:
	In order to 
	As an user
	I want to edit items in my projects
	
	Scenario: Create backlog item
		Given I am logged in
		And I have project
		And I am on this project's page
		When I choose to add backlog item
		Then I should see new backlog item form
		When I fill in new backlog item form
		Then I should have new item in backlog

	Scenario: Read backlog item
		Given I am logged in
		And I have project
		And I am on this project's page
		And there is a backlog item in backlog
		Then all this backlog item should be presented

	Scenario: Update backlog item
		Given I am logged in
		And I have project
		And I am on this project's page
		And there is a backlog item in backlog
		When I choose to edit this backlog item
		And I fill in update backlog item form
		Then this item should be updated
		
	Scenario: Delete backlog item
		Given I am logged in
		And I have project
		And I am on this project's page
		And there is a backlog item in backlog
		When I choose to delete this backlog item
		Then this item should be deleted