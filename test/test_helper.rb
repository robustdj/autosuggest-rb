ENV['RAILS_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'
require 'rails/all'
require 'mongoid'
require 'mongo_mapper'
require 'rails/test_help'
require 'autosuggest-rb'
require 'ruby-debug'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module Autosuggest
  class Application < Rails::Application
  end
end

Autosuggest::Application.routes.draw do
  match '/:controller(/:action(/:id))'
end

ActionController::Base.send :include, Autosuggest::Application.routes.url_helpers

RecipesController = Class.new(ActionController::Base)
RecipesController.autosuggest(:tag, :name)

