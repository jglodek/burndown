When /^I choose to add backlog item$/ do
	step %{I follow "New Backlog item"}
end

Then /^I should see new backlog item form$/ do
	step %{I should see "Title"}
	step %{I should see "Description"}
	step %{I should see "Cost"}
	step %{I should see "Priority"}
end

When /^I fill in new backlog item form$/ do
	step %{I fill in "Title" with "Backlog item 1"}
	step %{I fill in "Priority" with "100"}
	step %{I press "Create Backlog item"}
end

Then /^I should have new item in backlog$/ do
	BacklogItem.where(:title => "Backlog item 1").should_not == nil
end

Given /^there is a backlog item in backlog$/ do
	@item = BacklogItem.new
	@item.title = "Backlog item test"
	@item.priority = 100
	@item.project = @project
	@item.save.should == true
	@item_id = @item.id
end

Then /^this backlog item should be presented$/ do
	step %{I should see "Backlog"}
	step %{I should see "Title"}
	step %{I should see "Description"}
	step %{I should see "Priority"}
	step %{I should see "Cost"}
	step %{I should see "Created at"}
end

When /^I choose to edit this backlog item$/ do
	step %{I follow "edit-item-link"}
end

When /^I fill in update backlog item form$/ do
	step %{I fill in "Title" with "Other title"}
	step %{I fill in "Description" with "Some text"}
	step %{I fill in "Cost" with "3"}
	step %{I fill in "Priority" with "12"}
	step %{I press "Update Backlog item"}
end


Then /^this item should be updated$/ do
	newitem = BacklogItem.find_by_id(@item_id)
	newitem.should_not == nil
	newitem.title.should_not == @item.description
	newitem.priority.should_not == @item.priority
end

When /^I choose to delete this backlog item$/ do
	step %{I follow "delete-item-link-#{@item_id}"}
end

Given /^I look at this backlog item's page$/ do
	page.visit("/backlog_items/#{@item_id}")
end

Then /^I look at some backlog item's page$/ do
	step %{I look at this backlog item's page}
end


Given /^I look at this projects page$/ do
	page.visit("/projects/#{@project.id}")
end


Then /^this item should be deleted$/ do
	BacklogItem.find_by_id(@item_id).should == nil
end

Given /^I have project with backlog item$/ do
	step %{I am logged in}
	step %{I have project}
	step %{there is a backlog item in backlog}
end

Then /^evaluations should be listed$/ do
	step %{I should see "Type"}
	step %{I should see "Effective date"}
end

Given /^I have item that is not evaluated$/ do
	step %{I have project with backlog item}
end

When /^I choose to update this item$/ do
	step %{I follow "edit-item-link"}
end

When /^I set evaluation cost in the form$/ do
	@time_eval = Time.now
	bc = BacklogItem.all.count
	ec = Evaluation.all.count
	step %{I fill in "Cost" with "101"}
	step %{I press "Update Backlog item"}
	bcn = BacklogItem.all.count
	ecn = Evaluation.all.count
	bc.should == bcn
	ec.should < ecn
	e = Evaluation.last
end

Then /^this item should be evaluated with proper date$/ do
	bc = BacklogItem.last
	e = bc.evaluations.last
	(@time_eval.to_i <= e.effective_date.to_i).should == true
end

Given /^I have backlog item in the backlog$/ do
	step %{I have project with backlog item}
end


Given /^there is backlog item in the backlog$/ do
	step %{I have project with backlog item}
end

Then /^I should be able to mark items as finished$/ do
	page.find_link("finish-item-link").should_not == nil
end

When /^I choose to mark item as finished$/ do
	page.click_link "finish-item-link"
end

Then /^this item should be marked as finished$/ do
	BacklogItem.find_by_id(@item_id).finished?.should == true
end

Given /^this item has some evaluations$/ do
	step %{I follow "edit-item-link"}
	step %{I fill in "Cost" with "123"}
	step %{I press "Update Backlog item"}
	step %{I follow "edit-item-link"}
	step %{I fill in "Cost" with "321"}
	step %{I press "Update Backlog item"}
	step %{I follow "edit-item-link"}
	step %{I fill in "Cost" with "555"}
	step %{I press "Update Backlog item"}
end

Then /^I should be able to delete those evaluations$/ do
	page.find_link("delete-evaluation-link-1").should_not == nil
	page.find_link("delete-evaluation-link-2").should_not == nil
	page.find_link("delete-evaluation-link-3").should_not == nil
end

When /^I choose to delete some evaluation$/ do
	@last_eval_id = Evaluation.last.id
	page.click_link "delete-evaluation-link-#{Evaluation.last.id}"
end

Then /^The evaluation should be deleted$/ do
	Evaluation.find_by_id(@last_eval_id).should == nil
end

Then /^I should be able to edit those evaluations$/ do
	page.find_link("edit-evaluation-link-1").should_not == nil
	page.find_link("edit-evaluation-link-2").should_not == nil
	page.find_link("edit-evaluation-link-3").should_not == nil
end

When /^I choose to edit one of this evaluations$/ do
	step %{I follow "edit-evaluation-link-#{Evaluation.last.id}"}
end

Then /^I should see this evaluation's edit form$/ do
	page.should have_content("Value")
	page.should have_content("Effective date")
	find_button("Update Evaluation").should_not == nil
end

When /^I fill in this evaluation's edit form$/ do
	step %{I fill in "Value" with "11111"}
	step %{I press "Update Evaluation"}
end

Then /^this evaluation should be updated with new data$/ do
	Evaluation.last.value.should == 11111
end

When /^I choose to create new evaluation$/ do
	page.click_link "New evaluation"
end

When /^I fill in new evaluation from$/ do
	step 'I fill in "Value" with "222"'
	page.click_button "Create Evaluation"
end

When /^I fill in new backlog item form with evaluation$/ do
	step %{I fill in "Title" with "Backlog item 1"}
	step %{I fill in "Priority" with "100"}
	step %{I fill in "Cost" with "12321"}
	step %{I press "Create Backlog item"}
end

Then /^I should have new evaluated item in backlog$/ do
	page.should have_content "12321"
end

When /^I fill in update backlog item form and mark project finished$/ do
	step %{I fill in "Title" with "Other title"}
	step %{I fill in "Description" with "Some text"}
	step %{I fill in "Cost" with "3"}
	step %{I fill in "Priority" with "12"}
	page.check "Finished"
	step %{I press "Update Backlog item"}
end

Then /^this item should be updated and finished$/ do
	page.should have_content "Finished"
end




