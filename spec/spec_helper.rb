require 'simplecov'
require 'simplecov-console'
require 'capybara/rspec'
require 'sinatra'
require 'rspec'
require 'timecop'
require_relative './../app.rb'
Capybara.app = Chitter

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|

  config.include Rack::Test::Methods
  config.before(:each) do
    DataMapper.setup(:default, 'postgres://localhost/chitter_test')
    DataMapper.finalize
    DataMapper.auto_migrate!
    Pony.override_options = { :via => :test }
  end

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
