require 'spec_helper'

describe Autosuggest::ControllerMacros do

  it "should respond to autosuggest_ingredients_name" do
    IngredientsController.new.should respond_to :autosuggest_ingredient_name
  end

end
