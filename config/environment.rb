# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Burndown::Application.initialize!

#from railscasts
Time::DATE_FORMATS[:due_time] = "due on %B %d at %I:%M %p"
