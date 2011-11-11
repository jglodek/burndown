Feature:
	As an project owner
	I want to create unique link to my project.
	In order to share my data with project team, so they can see it
	
	Scenario: Create a link to project
		Given I have a project
		And I am on this project's page
		Then I should be able to share my projects with others via unique access link
		When I choose to share my project with others
		Then on this project's side, I should see link url that I can share with others.

	Scenario: Read project link if it is created
		Given I have a project
		And I've generated sharing link for my project
		Then I should see this link on this project's site

	Scenario: Removing projects link
		Given I have a project
		And I've generated sharing link for my project
		Then I should be able to deactivate this link
		When I deactivate this link
		Then sharing link should not longer work
		
	Scenario: Enter link of project, by someone not logged
		Given someone has a project
		And he shared with me a link to that project
		And I am not logged in
		When I follow this sharing link
		Then I should be asked to sign up to enter the link

	Scenario: Enter link of project, by someone logged
		Given someone has a project
		And he shared with me a link to that project
		And I am logged in as someone else	
		When I follow this sharing link
		Then I should be able to explore that project
		

	Scenario: As owner of project, i browse and modify access of users to project
		Given I have a project
		And I've generated sharing link for my project
		And couple of people already joined this project using sharing link
		When I am on this project's page
		Then I should see a list of all members of the project
		And if I choose to remove someone from project
		Then he should no longer be able to join project

