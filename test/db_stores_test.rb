require 'test_helper'
require 'controller_test'
require 'support/active_record'
require 'support/mongoid'
require 'support/mongo_mapper'

class ActiveRecordControllerTest < ActionController::TestCase
  include Autosuggest::TestCase::ActiveRecord
  include Autosuggest::TestCase
end

class MongoidControllerTest < ActionController::TestCase
  include Autosuggest::TestCase::Mongoid
  include Autosuggest::TestCase
end

class MongoMapperControllerTest < ActionController::TestCase
  include Autosuggest::TestCase::MongoMapper
  include Autosuggest::TestCase
end
