require 'test_helper'

class Tag
  attr_accessor :name
end

class FormHelperTest < ActionView::TestCase
  context "autosuggest_field" do
    should "render properly" do
      output = autosuggest_field(:tag, :name, 'some/path')
      assert_match /class=\" autosuggest_tag_name\"/, output
      assert_match /\$\('.autosuggest_tag_name'\)/, output
    end
  end

  context "autosuggest_field_tag" do
    should "render properly" do
      #raise "test in browser"
      #raise "fix the params['tag'] issue"
      output = autosuggest_field_tag(:some_name, '', 'some/path')
      assert_match /class=\" autosuggest_some_name\"/, output
      assert_match /\$\('.autosuggest_some_name'\)/, output
    end

  end
end
