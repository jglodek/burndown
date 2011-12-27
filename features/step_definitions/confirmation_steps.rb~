
Given /^a confirmation box saying "([^"]*)" should pop up$/ do |message|
  @expected_message = message
end


Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end
