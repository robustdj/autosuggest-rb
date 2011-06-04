module Autosuggest
  module TestCase
    module Mongoid
      def setup
        ::Mongoid.configure do |config|
          name = "autosuggest-rb"
          host = "localhost"
          config.master = Mongo::Connection.new.db(name)
          config.logger = nil
        end

        create_models

        @controller = RecipesController.new
      end

      def teardown
        destroy_models
        ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end

      private
      def create_models
        @tag_class = Object.const_set(:Tag, Class.new)
        @tag_class.send(:include, ::Mongoid::Document)
        @tag_class.field(:name, :class => String)
        @tag_class.class_eval do
          def display_name
            "Tag: #{name}"
          end
        end

        @tag1 = @tag_class.create(:name => 'Chinese')
        @tag2 = @tag_class.create(:name => 'Chicken')
        @tag3 = @tag_class.create(:name => 'Cajun')
      end

      def destroy_models
        Object.send(:remove_const, :Tag)
      end
    end
  end
end
