task :coverage do
	require 'simplecov'
	SimpleCov.start 'rails'
end

task :test_suite => [:coverage, :test, :cucumber]