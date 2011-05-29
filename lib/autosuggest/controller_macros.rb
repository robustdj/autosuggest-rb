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
end
