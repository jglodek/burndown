source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'execjs'
gem 'therubyracer'

gem 'sqlite3'

# for errors
gem 'rack' , '1.3.5'

group :assets do
    # Asset template engin
    gem 'sass-rails', "~> 3.1.1"
    gem 'coffee-script'
    gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# mongrel web server
gem "mongrel", "~> 1.2.0.pre2"

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "bcrypt-ruby", "~> 3.0.1"


group :test do
  # Pretty printed test output
  # gem 'turn', :require => false
end

group :test, :development do
  gem 'rspec', '>=1.2.2'
  gem 'rspec-rails', '>=1.2.2'
  gem "nifty-generators", "~> 0.4.6"
  gem "simplecov"
end

group :cucumber do
  gem 'capybara', '~> 1.1.1'
  gem 'database_cleaner'
  gem "cucumber-rails", "~> 1.1.1"
  gem "cucumber", "~> 1.1.0"
  gem 'rspec-rails', '>=1.2.2'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'ZenTest', '~> 4.5.0'
	gem 'Selenium'
	gem 'selenium-client'
	gem "autotest-rails"
end  

