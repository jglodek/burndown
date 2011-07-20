Feature:
	As an user
	I want to edit my projects

	Scenario: Link to projects
		Given I am logged in
		And I am on the home page
		Then I should see "Projects"
		When I follow "Projects"
		Then I should be on my projects page
		And I should see project table headers
		And I should see new project link
	
	Scenario: Index
		Given I am logged in
		And I have project "Projekt 1 "
		And I am on my projects page
		Then I should see
	
	Scenario: Create project
		Then fail
		
	Scenario: Read project
		Then fail
		
	Scenario: Update project
		Then fail
		
	Scenario: Delete project
		Then fail
		
