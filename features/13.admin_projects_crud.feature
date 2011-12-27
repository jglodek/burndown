Feature:
	In order to maintain app, support users and fight abuse
	As an admin
	I want to be able to manage all projects
	
	Scenario: Index all projects, and read one
		Given users have projects
		And I am admin
		And I am looking at admin project's page
		Then I should see projects

	Scenario: Create project for user
		Given there are some users
		And I am admin
		And I am looking at admin project's page
		Then I should be able to add new project
		
	Scenario: Delete users project
		Given users have projects
		And I am admin
		And I am looking at admin project's page
		Then I should see projects
		And I should be able to delete them
		When I delete one of them
		Then the project should be deleted

	Scenario: Change users project info
		Given users have projects
		And I am admin
		And I am looking at admin project's page
		Then I should be able to edit project data
		
		
