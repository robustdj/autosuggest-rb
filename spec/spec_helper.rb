ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'
require 'rspec/rails'
require 'autosuggest'
require 'ruby-debug'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end

Ingredient = Class.new
IngredientsController = Class.new(ActionController::Base)
IngredientsController.autosuggest(:ingredients, :name)

