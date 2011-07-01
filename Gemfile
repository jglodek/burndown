source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'execjs'
gem 'therubyracer'

gem 'sqlite3'

# Asset template engin
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :test, :development do
  gem 'rspec', '>=1.2.2'
  gem 'rspec-rails', '>=1.2.2'
end

group :cucumber do
  gem 'capybara', '1.0.0'
  gem 'database_cleaner'
  gem "cucumber-rails", "~> 1.0.2"
  gem 'cucumber', '1.0.0'
  gem 'rspec-rails', '>=1.2.2'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end  

