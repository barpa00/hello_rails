source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.1"
gem "sprockets-rails"
gem 'pg', '~> 1.1'
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'i18n'
gem 'ransack'
gem 'aasm'
gem 'kaminari'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rails-controller-testing'
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "byebug", "~> 11.1"
  gem 'faker'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'database_cleaner-active_record'
end

gem "tailwindcss-rails", "~> 2.0"
