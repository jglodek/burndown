Feature:
	In order to keep my projects index clear, and readable
	As an user 
	I want to CRUD my projects

	Scenario: Link to projects
		Given I am logged in
		And I am on the home page
		Then I should see "Projects"
		When I follow "Projects"
		Then I should be on my projects page
		And I should see project table headers
		And I should see new project link

	Scenario: Create project
		Given I am logged in
		And I am on my projects page
		When I follow "Create new project"
		Then I should see project form
		When I fill in "Title" with "some title"
		And I fill in "Description" with "some description"
		And I press "Create Project"
		When I go to my projects page
		Then I should see "some title"
		And I should see "some description"
		And I should have project with title "some title"
	
	Scenario: Index
		Given I am logged in
		And I have project "Project 1"
		And I have project "Project 2"	
		And I am on my projects page
		Then I should see "Project 1"
		Then I should see "Project 2"

	Scenario: Read project
		Given I am logged in
		And I have project "test-project"
		And I am on my projects page
		When I follow "Show"
		Then I should be on this project's page
		And I should see project info

	Scenario: Read project, access denied
		Given someone has project
		And I am logged in
		And I try to access this project
		Then I shouln't be able to access it

	Scenario: Update project
		Given I am logged in
		And I have project
		And I am on this project's page
		When I choose to edit project info
		And I fill in project form with other title and other description
		And I go back to this project's page
		Then I should see that project info has changed

	@javascript
	Scenario: Delete project, through project page
		Given I am logged in
		And I have project
		And I am on this project's page
		When I choose to delete this project
		Then I should be on my projects page
		And I should see project deletion notification
		And project should be deleted
	
	@javascript
	Scenario: Delete project, through projects index page
		Given I am logged in
		And I have project "Test project 1"
		And I have project "Test project 2"
		And I am on my projects page
		When I choose to delete second project
		Then I should be on my projects page
		And I should see project deletion notification
		And project "Test project 2" should be deleted
		And project "Test project 1" should be intact

