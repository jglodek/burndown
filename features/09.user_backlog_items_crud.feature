Feature:
	In order to keep track of all task and changes in my project
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
		Then this backlog item should be presented

	Scenario: Update backlog item
		Given I have project with backlog item
		And I look at this backlog item's page 
		When I choose to edit this backlog item
		And I fill in update backlog item form
		Then this item should be updated
		
	Scenario: Delete backlog item
		Given I am logged in
		And I have project
		And there is a backlog item in backlog
		And I look at this projects page
		When I choose to delete this backlog item
		Then this item should be deleted

	Scenario: Looking at evaluations
		And I have project with backlog item
		And I look at this backlog item's page
		Then evaluations should be listed

	Scenario: Evaluate item through update form
		Given I have item that is not evaluated
		And I look at this backlog item's page
		When I choose to update this item
		And I set evaluation cost in the form
		Then this item should be evaluated with proper date

	Scenario: Marking item as finished, via backlog item page
		Given I have item that is not evaluated
		And I look at this backlog item's page
		Then I should be able to mark items as finished
		When I choose to mark item as finished
		Then this item should be marked as finished

	Scenario: Removing evaluation
		Given I have project with backlog item
		And I look at this backlog item's page
		And this item has some evaluations
		Then I should be able to delete those evaluations
		When I choose to delete some evaluation
		Then The evaluation should be deleted

	Scenario: Updating evaluation
		Given I have project with backlog item
		And I look at some backlog item's page
		And this item has some evaluations
		Then I should be able to edit those evaluations
		When I choose to edit one of this evaluations
		Then I should see this evaluation's edit form
		When I fill in this evaluation's edit form
		Then this evaluation should be updated with new data
		
