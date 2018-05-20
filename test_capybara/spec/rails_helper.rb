require 'spec_helper'
require 'capybara/rspec'

Capybara.register_driver :selenium do |app|
  Selenium::WebDriver::Chrome.driver_path = "/Users/hansel.tritama/Downloads/chromedriver_238"
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Capybara::DSL
end
