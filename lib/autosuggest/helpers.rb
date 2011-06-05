module Autosuggest
  module ActiveRecord
    def self.query(options)
      options[:object].where("#{options[:name]} #{options[:like_clause]} ?", "%#{options[:query]}%").order(options[:order]).limit(options[:limit])
    end
  end

  module Mongoid
    def self.query(options)
      options[:object].where(options[:name].to_sym => /.*#{options[:query]}.*/i).limit(options[:limit]).order_by(resolve_order_syntax(options[:order]))
    end

    def self.resolve_order_syntax(order)
      fields = order.split
      [fields[0], fields[1].downcase.to_sym]
    end
  end

  module MongoMapper
    def self.query(options)
      options[:object].where(options[:name].to_sym => /#{options[:query]}/i).limit(options[:limit]).sort(resolve_order_syntax(options[:order]))
    end

    def self.resolve_order_syntax(order)
      fields = order.split
      [fields[0], fields[1].downcase.to_sym]
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

    # Decipher what database implementation the model is using
    #   db_store(:ingredient)
    #   # returns ActiveRecord assuming Ingredient is an AR model
    #
    def db_store(object)
      ancestors = objectify(object).ancestors.map(&:to_s)
      if ancestors.include?('ActiveRecord::Base')
        ActiveRecord
      elsif ancestors.include?('Mongoid::Document')
        Mongoid
      elsif ancestors.include?('MongoMapper::Document')
        MongoMapper
      else
        raise 'Database Store not supported'
      end
    end

    def resolve_like_clause
      defined?(PGconn) ? 'ILIKE' : 'LIKE'
    end
  end
end
