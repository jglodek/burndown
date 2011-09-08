Then /^fail$/ do
	true.should == true
end

Then /^I should see field "([^"]*)"$/ do |field|
	page.has_field?(field).should == true
end

Then /^I should see field "([^"]*)" with value "([^"]*)"$/ do |field, value|
	page.has_field?(field, :with => value).should == true
end

Then /^I should see button "([^"]*)"$/ do |button|
	page.has_button?(button).should == true
end

