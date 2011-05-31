require 'test_helper'
require 'controller_test'
require 'support/active_record'

class ActiveRecordControllerTest < ActionController::TestCase
  include Autosuggest::TestCase::ActiveRecord
  include Autosuggest::TestCase
end
