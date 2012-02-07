source 'http://rubygems.org'

#zarzadzanie wydajnoscia
gem 'newrelic_rpm'

#Ruby on rails
gem 'rails', '3.2.1'

#Potrzebne do kompilacji assets
gem 'execjs'
gem 'therubyracer'

#adapter bazy danych sqlite
gem 'sqlite3'

#Biblioteka do paneli administracyjnych
gem 'activeadmin'
gem 'meta_search'


# SASS
gem 'sass-rails', "~> 3.2.3"

group :assets do
    # Asset template engin
    gem 'coffee-rails',  "~> 3.2.1"
    gem 'uglifier', '>=1.0.3'
end

gem 'jquery-rails'

# mongrel web server
gem "mongrel", "~> 1.2.0.pre2"

gem "bcrypt-ruby", "~> 3.0.1"

group :test, :development do
  gem 'rspec', '>=1.2.2'
  gem 'rspec-rails', '>=1.2.2'
  gem "nifty-generators", "~> 0.4.6"
  gem "simplecov"
end

group :cucumber do
  gem 'capybara', '~> 1.1.1'
  gem 'database_cleaner'
  gem "cucumber-rails", "~> 1.2.1"
  gem "cucumber", "~> 1.1.0"
  gem 'rspec-rails', '>=1.2.2'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'ZenTest', '~> 4.5.0'
	gem 'Selenium'
	gem 'selenium-client'
	gem "autotest-rails"
end  

