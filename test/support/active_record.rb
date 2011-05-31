module Autosuggest
  module TestCase
    module ActiveRecord
      def setup
        ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        ::ActiveRecord::Schema.define(:version => 1) do
          create_table :tags do |t|
            t.string :name
          end
        end

        create_models

        @controller = RecipesController.new

        @tag1 = @tag_class.create(:name => 'Chinese')
        @tag2 = @tag_class.create(:name => 'Chicken')
        @tag3 = @tag_class.create(:name => 'Cajun')
      end

      def teardown
        destroy_models
        ::ActiveRecord::Base.connection.tables.each do |table|
          ::ActiveRecord::Base.connection.drop_table(table)
        end
      end

      private
      def create_models
        @tag_class = Object.const_set(:Tag, Class.new(::ActiveRecord::Base))
        @tag_class.class_eval do
          def display_name
            "Tag: #{name}"
          end
        end
      end

      def destroy_models
        Object.send(:remove_const, :Tag)
      end
    end
  end
end
