require 'redmine'
require 'uri'
require File.expand_path('lib/plantuml', __dir__)

Redmine::Plugin.register :plantuml_macro do
  name 'PlantUML Macro plugin'
  author 'Denis Nelubin'
  description 'This is a plugin for Redmine to convert PlantUML text into link to the image on PlantUML server'
  version '0.0.1'
  url 'https://bitbucket.org/gelin/plantuml-redmine-macro'
  author_url 'http://google.com/+DenisNelubin'

  settings :default => { 'plantuml_url' => 'https://www.plantuml.com/plantuml' },
           :partial => 'settings/plantuml_macro_settings'

  Redmine::WikiFormatting::Macros.register do

    desc "Converts PlantUML text into link to the image on PlantUML server. Example:\n\n" +
         "  {{plantuml\n" +
           "  Bob -> Alice : hello\n" +
           "}}"
    macro :plantuml do |obj, args, text|
      url = URI.join(Setting.plugin_plantuml_macro['plantuml_url'] + '/', 'png/')
      encoded = Plantuml.encode(text)
      image_tag(URI.join(url, encoded).to_s)
    end

  end

end


