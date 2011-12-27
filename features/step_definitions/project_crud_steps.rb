Then /^I should see project table headers$/ do
	step %{I should see "Title"}
	step %{I should see "Description"}
	step %{I should see "Created at"}
	step %{I should see "Members"}
	step %{I should see "Finished at"}	
	step %{I should see "Your role"}
end


Then /^I should see project info$/ do
	step %{I should see "Title"}
	step %{I should see "#{@project.title}"}
	step %{I should see "Description"}
	step %{I should see "#{@project.description}"}
	step %{I should see "Created at"}
	step %{I should see "#{@project.created_at.to_s(:short)}"}
	step %{I should see "Members"}
	step %{I should see "#{@project.project_memberships.size}"}
	step %{I should see "Finished at"}
	if @project.finished_at
		step %{I should see "#{@project.finished_at.to_s(:short)}"}	
	else
		step %{I should see "Unfinished"}	
	end
	step %{I should see "Your role"}
	if ProjectMembership.where(:project_id => @project.id, :user_id => @user.id).first.role == 0
		step %{I should see "Owner"}
	else
		step %{I should see "Visitor"}
	end
end


Then /^I should see new project link/ do
	step %{I should see "Create new project"}
end

Then /^I should see project form$/ do
	step %{I should see "Title"}
	step %{I should see "Description"}
	step %{I should see button "Create Project"}
end

Given /^I fill project form with title "([^"]*)"$/ do |pn|
	step %{I fill in "Title" with "#{pn}"}
	step %{I fill in "Description" with "Some description of project"}
	step %{I press "Create Project"}
end

Given /^I have project "([^"]*)"$/ do |pn|
	step %{I am on my projects page}
	step %{I follow "Create new project"}
	step %{I fill project form with title "#{pn}"}
	@project =  Project.all.last
	@old_id = @project.id
	@old_title = @project.title
	@old_description = @project.description
end

Then /^I should have project with title "([^"]*)"$/ do |pn|
	k = false
	@user.projects.each do |p|
		if p.title == pn
			k = true
		end
	end
	k.should == true
end

Given /^I'm on project's page$/ do
		visit '/projects/' + @project.id.to_s
end


Given /^I have project$/ do
	step %{I have project "Some test project1"}
end

When /^I choose to edit project info$/ do
  step %{I follow "Edit project info"}
end

When /^I fill in project form with other title and other description$/ do
	step %{I fill in "Title" with "other title"}
	step %{I fill in "Description" with "other description"}
	step %{I press "Update Project"}
end

When /^I go back to this project page$/ do
	visit path_to('this projects page')
end

Then /^I should see that project info has changed$/ do
	@project = Project.all.last
	@project.title.should_not == @old_title
	@project.description.should_not == @old_description
	step %{I should see "#{@project.title}"}
	step %{I should see "#{@project.description}"}
end

When /^I choose to delete this project$/ do
	@project_to_delete = @project
	step %{I follow "Delete project"}
end

Then /^project should be deleted$/ do
  Project.find_by_id(@old_id).should == nil
end

When /^I choose to delete second project$/ do
	@project_to_delete = @project
	click_link "delete_project_#{@project_to_delete.id}"
end

Then /^project "([^"]*)" should be deleted$/ do |arg1|
  Project.find_by_id(@project_to_delete.id).should == nil
end

Then /^project "([^"]*)" should be intact$/ do |arg1|
	Project.find_by_title(arg1).should_not == nil
end

When /^I go back to this project's page$/ do
		visit path_to( "this project's page")
end

Then /^I should see project deletion notification$/ do
		step %{I should see "Project '#{@project_to_delete.title}' successfuly deleted"}
end

Given /^someone has project$/ do
	step %{I am logged in as user with email "email@email.com"}
	step %{I have project "Projekt1"}
	step %{I log out}
end

Given /^I try to access this project$/ do
	visit '/projects/'+ @project.id.to_s
end

Then /^I shouln't be able to access it$/ do
  step %{I should be on root page}
	step %{I should see "You don't have access to this project or project does not exist"}
end


When /^I choose to mark this project as finished$/ do
	click_link "finish-project-link"
end

Then /^this project should be marked as finished$/ do
	page.should have_link("unfinish-project-link")
	page.should_not have_link("finish-project-link")
	page.should_not have_content("Unfinished")
end

When /^I choose to mark this project as unfinished$/ do
	click_link "unfinish-project-link"
end

Then /^this project should be marked as unfinished$/ do
	page.should have_link ("finish-project-link")
	page.should_not have_link ("unfinish-project-link")
	page.should have_content ("Unfinished")
end

