require 'autosuggest/form_helper'
require 'autosuggest/controller_macros'
require 'autosuggest/helpers'

class ActionController::Base
  extend Autosuggest::ControllerMacros
  include Autosuggest::Helpers
end
