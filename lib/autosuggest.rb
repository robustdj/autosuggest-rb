require 'autosuggest/form_helper'

module Autosuggest
  module ControllerMacros
    # when called, you must add a custom route for action like this:
    # resources :products do
    #   get :autosuggest_brand_name, :on => :collection
    # end
    def autosuggest(object, name)
      define_method "autosuggest_#{object}_#{name}" do
        # assuming an ActiveRecord mysql backed model for right now
        results = objectify(object).where("#{name} LIKE ?", "%#{params[:q]}%")
        render :json => results.map{|r| {:name => r.send(:name), :value => r.id}}
      end
    end
  end

  module Helpers
    # Returns parameter object_sym as a constant
    #
    #   objectify(:ingredient)
    #   # returns a Ingredient constant supposing it is already defined
    #
    def objectify(object_sym)
      object_sym.to_s.camelize.constantize
    end
  end
end

class ActionController::Base
  extend Autosuggest::ControllerMacros
  include Autosuggest::Helpers
end
