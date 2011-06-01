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
    end

  end
end
