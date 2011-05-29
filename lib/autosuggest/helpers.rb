module Autosuggest
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
