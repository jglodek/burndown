Given /^I have a project$/ do
  step "I have project with backlog item"
end

Then /^I should be able to share my projects with others via unique access link$/ do
  page.find_link("create-invitation-link-link").should_not == nil
end

When /^I choose to share my project with others$/ do
	page.click_link "create-invitation-link-link"
end

Then /^on this project's side, I should see link url that I can share with others\.$/ do
  page.should have_content "Invitation Links"
	InvitationLink.find_by_project_id(@project.id).should_not == nil
end

Given /^I've generated sharing link for my project$/ do
	step "I am on this project's page"
	page.click_link "create-invitation-link-link"
	@sharelink1 = InvitationLink.last
end

Then /^I should see this link on this project's site$/ do
	page.should have_content @sharelink1.key
end

Then /^I should be able to deactivate this link$/ do
	page.find_link("remove-invitation-link-link-#{@sharelink1.id}").should_not == nil
end

When /^I deactivate this link$/ do
	page.click_link("remove-invitation-link-link-#{@sharelink1.id}")
end

Then /^sharing link should not longer work$/ do
	page.visit invitation_link_path(@sharelink1.key)
	current_path.should == path_to("root page")
end

Given /^someone has a project$/ do
	step "I have a project" 
end

Given /^he shared with me a link to that project$/ do
	step "I choose to share my project with others"
	step "I log out"
end

When /^I follow this sharing link$/ do
	page.visit invitation_link_path(InvitationLink.last.key)
end

Then /^I should be able to explore that project$/ do
	page.should have_content "Visitor"
	step "I should be on this project's page"
end

Given /^couple of people already joined this project using sharing link$/ do
  step "I have project"
	step "I choose to share my project with others"
	step "I log out"
	step 'I am logged in as user with email "jac@jac.pl"'
	step "I follow this sharing link"
	step "I log out"
	step 'I am logged in as user with email "jac1@jac.pl"'
	step "I follow this sharing link"
	step "I log out"
	step 'I am logged in as user with email "jac2@jac.pl"'
	step "I follow this sharing link"
	step "I log out"
	step 'I am logged in as user with email "jac3@jac.pl"'
	step "I follow this sharing link"
	@removed_user = @user
	step "I log out"
	step 'I am logged in as user with email "jac4@jac.pl"'
	step "I follow this sharing link"
	step "I log out"
	step 'I am logged in as user with email "jac5@jac.pl"'
	step "I follow this sharing link"
	step "I log out"
	step %{I am on the login page}
	step %{I fill in "Email" with "test@testers.com"}
	step %{I fill in "Password" with "haslo_maslo"}
	step %{I press "Log in"}
end

Then /^I should see a list of all members of the project$/ do
	step "I am on this project's page"
	page.should have_content "Members"
end

Then /^if I choose to block someone from the project$/ do
	page.click_link "block-user-membership-link-#{@removed_user.id}"
end

Then /^he should no longer be able to join project$/ do
	step "I log out"
	step %{I am on the login page}
	step %{I fill in "Email" with "#{@removed_user.email}"}
	step %{I fill in "Password" with "haslo_maslo"}
	step %{I press "Log in"}
	step %{I am on this project's page}
	step "I should be on root page"
end

Then /^if I choose to remove someone from project$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be asked to sign up to enter the link$/ do
	page.should have_content "sign up"
end

Then /^I shouldn't see invitation links nor actions not available to visitors$/ do
	page.should_not have_link "finish-project-link"
	page.should_not have_link "create-invitation-link-link"
	page.should_not have_content "Invitation Links"
	page.should_not have_content "Make owner"
	page.should_not have_content "Remove"
	page.should_not have_content "Edit"
	page.should_not have_content "Block"
	page.should_not have_link "new-backlog-item-link"
end

When /^I enter some backlog's item page$/ do
	page.click_link "Show"
end

Then /^I shouldn't see no unavailable actions either$/ do
	page.should_not have_content "Reevaluate"
	page.should_not have_content "Evaluate"
	page.should_not have_content "Edit"
	page.should_not have_content "Delete"
	page.should_not have_content "Mark as finished"
end

Then /^I shouldn't see those actions$/ do
	page.should_not have_content "Delete"
end
