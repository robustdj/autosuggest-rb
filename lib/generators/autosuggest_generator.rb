require 'rails/generators'

class AutosuggestGenerator < Rails::Generators::Base

  def install
    # Copy the unobtrusive JS file and CSS file
    copy_file('jquery.autoSuggest.js', 'public/javascripts/jquery.autoSuggest.js')
    copy_file('autoSuggest.css', 'public/stylesheets/autoSuggest.css')
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'assets')
  end
end

