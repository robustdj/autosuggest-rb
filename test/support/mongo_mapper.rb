module Autosuggest
  module TestCase
    module MongoMapper
      def setup
        ::MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
        ::MongoMapper.database = "autosuggest-rb"

        create_models

        @controller = RecipesController.new
      end

      def teardown
        destroy_models
        ::MongoMapper.database.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end

      private
      def create_models
        @tag_class = Object.const_set(:Tag, Class.new)
        @tag_class.send(:include, ::MongoMapper::Document)
        @tag_class.key(:name, :class => String)
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
