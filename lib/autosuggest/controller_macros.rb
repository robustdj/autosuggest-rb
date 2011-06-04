require 'yajl'

module Autosuggest
  module ControllerMacros
    # when called, you must add a custom route for action like this:
    # resources :products do
    #   get :autosuggest_brand_name, :on => :collection
    # end
    def autosuggest(object, name, options={})
      display_name = options[:display] || name
      order        = options[:order] || "#{name} ASC"
      limit        = options[:limit] || 10
      like_clause  = defined?(PGconn) ? 'ILIKE' : 'LIKE'

      options[:display]     ||= name
      options[:order]       ||= "#{name} ASC"
      options[:limit]       ||= 10
      options[:like_clause]   = defined?(PGconn) ? 'ILIKE' : 'LIKE'
      options[:name]          = name

      define_method "autosuggest_#{object}_#{name}" do
        results = db_store(object).query(options.merge(:query => params[:query], :object => objectify(object)))
        render :json => Yajl::Encoder.encode(results.map{|r| {:name => r.send(display_name), :value => r.id}})
      end
    end
  end
end
