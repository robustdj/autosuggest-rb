require 'test_helper'

module Autosuggest
  module TestCase
    include Shoulda::InstanceMethods
    extend Shoulda::ClassMethods
    include Shoulda::Assertions
    extend Shoulda::Macros
    include Shoulda::Helpers

    context "GET autosuggest action" do
      should "respond succesfully" do
        get :autosuggest_tag_name
        assert_response :success

        get :autosuggest_tag_name, :query => ''
        assert_response :success

        get :autosuggest_tag_name, :query => nil
        assert_response :success

        get :autosuggest_tag_name, :query => 'Ch'
        assert_response :success
      end

      should "respond with expexted JSON" do
        get :autosuggest_tag_name, :query => 'Ca'
        json_response = JSON.parse(@response.body)
        assert_equal json_response.first["name"], "Cajun"
      end

      should "return results in alphabetical order by default" do
        get :autosuggest_tag_name, :query => 'Ch'
        json_response = JSON.parse(@response.body)
        assert_equal json_response.first["name"], "Chicken"
        assert_equal json_response.last["name"], "Chinese"
      end

      should "be able to sort in other ways" do
        @controller.class_eval do
          autosuggest :tag, :name, :order => "name DESC"
        end

        get :autosuggest_tag_name, :query => 'Ch'
        json_response = JSON.parse(@response.body)
        assert_equal json_response.first["name"], "Chinese"
        assert_equal json_response.last["name"], "Chicken"
      end

      should "be able to limit the results" do
        @controller.class_eval do
          autosuggest :tag, :name, :limit => 1
        end

        get :autosuggest_tag_name, :query => 'Ch'
        json_response = JSON.parse(@response.body)
        assert_equal json_response.count, 1
        assert_equal json_response.first["name"], "Chicken"
      end

      should "be able to customize what is displayed" do
        @controller.class_eval do
          autosuggest :tag, :name, :display => :display_name
        end

        get :autosuggest_tag_name, :query => 'Ch'
        json_response = JSON.parse(@response.body)
        assert_equal json_response.first["name"], "Tag: Chicken"
        assert_equal json_response.last["name"], "Tag: Chinese"
      end
    end
  end
end
