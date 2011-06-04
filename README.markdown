# autosuggest-rb

## Summary

This gem wraps the jQuery autoSuggest plugin and provides helpers to make it easy to use in rails. It supports ActiveRecord, Mongoid, and MongoMapper. This was influenced by crowdint's rails3-jquery-autocomplete gem.

## Installing

Include the gem on your Gemfile

    gem 'autosuggest-rb'

Install it

    bundle install

Run the generator

    rails generate autosuggest

And include jquery.autoSuggest.js and autoSuggest.css on your layouts

    javascript_include_tag "jquery.autoSuggest.js"
    stylesheet_link_tag "autoSuggest.css"

## Usage

### Model Example

Assuming you have a Tag model:

    class Tag < ActiveRecord::Base
    end

    create_table :tags do |t|
      t.string :name
    end

### Controller

Your conotroller will need an action to respond to the autosuggest textfield. To add it to your controller call the autosuggest method and pass it the name of the model and column name as in the following example:

    class RecipesController < ApplicationController
      autosuggest :tag, :name
    end

This will create a autosuggest_tag_name action. You then need to add a route for that action

    resources :recipes do
      get :autosuggest_tag_name, :on => :collection
    end

From the view you can create the autosuggest field like this:

    form_for @recipe do |f|
      f.autosuggest_field :tags, autosuggest_tag_name_recipes_path
    end

By default, autosuggest only queries the db for existing tags, but if you want to be able to create new ones, just pass these options:

    f.autosuggest_field :tags, autosuggest_tag_name_recipes_path, :autosuggest_options => { "newValuesInputName" => recipes[new_tags]" }

Then you can do whatever you want from the controller using params[:recipes][:new_tags]


These are the default options:

    "queryParam" => "query",
    "selectedItemProp" => "name",
    "searchObjProps" => "name",
    "neverSubmit" => "true",
    "asHtmlName" => "#{object_name}[set_#{method}]" # recipes[set_tags] in our example

But you can pass options in by using the autosuggest_options param

    f.autosuggest_field :tags, autosuggest_tag_name_recipes_path, :autosuggest_options => {"neverSubmit" => "true"}

Here are the other options you can pass in - pasted from http://code.drewwilson.com/entry/autosuggest-jquery-plugin

**asHtmlName:** string (false by default) - Enables you to specify your own custom name that will be attributed to the text field

**newValuesInputName:** string (false by default) - Enables you to define a name for a hidden field that will catch new names that don't match any in the db

**asHtmlID:** string (false by default) - Enables you to specify your own custom ID that will be appended to the top level AutoSuggest UL element's ID name. Otherwise it will default to using a random ID. Example: id="CUSTOM_ID". This is also applies to the hidden input filed that holds all of the selected values. Example: id="as-values-CUSTOM_ID"

**startText:** string ("Enter Name Here" by default) - Text to display when the AutoSuggest input field is empty.

**emptyText:** string ("No Results" by default) - Text to display when their are no search results.

**preFill:** object or string (empty object by default) - Enables you to pre-fill the AutoSuggest box with selections when the page is first loaded. You can pass in a comma separated list of values (a string), or an object. When using a string, each value is used as both the display text on the selected item and for it's value. When using an object, the options selectedItemProp will define the object property to use for the display text and selectedValuesProp will define the object property to use for the value for the selected item. Note: you must setup your preFill object in that format. A preFill object can look just like the example objects laid out above.

**limitText:** string ("No More Selections Are Allowed" by default) - Text to display when the number of selections has reached it's limit.

**selectedItemProp:** string ("value" by default) - Name of object property to use as the display text for each chosen item.

**selectedValuesProp:** string ("value" by default) - Name of object property to use as the value for each chosen item. This value will be stored into the hidden input field.

**searchObjProps:** string ("value" by default) - Comma separated list of object property names. The values in these objects properties will be used as the text to perform the search on.

**queryParam:** string ("q" by default) - The name of the param that will hold the search string value in the AJAX request.

**retrieveLimit:** number (false by default) - If set to a number, it will add a '&limit=' param to the AJAX request. It also limits the number of search results allowed to be displayed in the results dropdown box.

**extraParams:** string ("" by default) - This will be added onto the end of the AJAX request URL. Make sure you add an '&' before each param.

**matchCase:** true or false (false by default) - Make the search case sensitive when set to true.

**minChars:** number (1 by default) - Minimum number of characters that must be entered into the AutoSuggest input field before the search begins.

**keyDelay:** number (400 by default) - Number of milliseconds to delay after a keydown on the AutoSuggest input field and before search is started.

**resultsHighlight:** true or false (true by default) - Option to choose whether or not to highlight the matched text in each result item.

**neverSubmit:** true or false (false by default) - If set to true this option will never allow the 'return' key to submit the form that AutoSuggest is a part of.

**selectionLimit:** number (false by default) - Limits the number of selections that are allowed to be made to the number specified.

**showResultList:** true or false (true by default) - If set to false, the Results Dropdown List will never be shown at any time.

**start:** callback function - Custom function that is run only once on each AutoSuggest field when the code is first applied.

**selectionClick:** callback function - Custom function that is run when a previously chosen item is clicked. The item that is clicked is passed into this callback function as 'elem'.

Example: selectionClick: function(elem){ elem.fadeTo("slow", 0.33); }

**selectionAdded:** callback function - Custom function that is run when a selection is made by choosing one from the Results dropdown, or by using the tab/comma keys to add one. The selection item is passed into this callback function as 'elem'.

Example: selectionAdded: function(elem){ elem.fadeTo("slow", 0.33); }

**selectionRemoved:** callback function - Custom function that is run when a selection removed from the AutoSuggest by using the delete key or by clicking the "x" inside the selection. The selection item is passed into this callback function as 'elem'.

Example: selectionRemoved: function(elem){ elem.fadeTo("fast", 0, function(){ elem.remove(); }); }

**formatList:** callback function - Custom function that is run after all the data has been retrieved and before the results are put into the suggestion results list. This is here so you can modify what & how things show up in the suggestion results list.

**beforeRetrieve:** callback function - Custom function that is run right before the AJAX request is made, or before the local objected is searched. This is used to modify the search string before it is processed. So if a user entered "jim" into the AutoSuggest box, you can call this function to prepend their query with "guy_". Making the final query = "guy_jim". The search query is passed into this function. Example: beforeRetrieve: function(string){ return string; }

**retrieveComplete:** callback function - Custom function that is run after the ajax request has completed. The data object MUST be returned if this is used. Example: retrieveComplete: function(data){ return data; }

**resultClick:** callback function - Custom function that is run when a search result item is clicked. The data from the item that is clicked is passed into this callback function as 'data'.

Example: resultClick: function(data){ console.log(data); }

**resultsComplete:** callback function - Custom function that is run when the suggestion results dropdown list is made visible. Will run after every search query.


## Author

Derrick Camerino http://programifications.com

## Contributing

Pull requests are very welcome! Make sure your patches are unit tested. Please do not change the version in your pull-request.

## Copyright

Copyright (c) 2009 Derrick Camerino. See LICENSE for details.


