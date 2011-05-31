require 'yajl'

module Autosuggest
  module ControllerMacros
    # when called, you must add a custom route for action like this:
    # resources :products do
    #   get :autosuggest_brand_name, :on => :collection
    # end
    def autosuggest(object, name, options={})
      display_name = options[:display] || name
      order = options[:order] || "#{name} ASC"
      limit = options[:limit] || 10

      define_method "autosuggest_#{object}_#{name}" do
        # assuming an ActiveRecord mysql backed model for right now
        results = objectify(object).where("#{name} LIKE ?", "%#{params[:query]}%").order(order).limit(limit)
        render :json => Yajl::Encoder.encode(results.map{|r| {:name => r.send(display_name), :value => r.id}})
      end
    end
  end
end
