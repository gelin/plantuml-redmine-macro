PlantUML Macro Plugin
=====================

This is plugin for [Redmine](http://www.redmine.org/).

This plugin adds a `plantuml` macro to wiki pages or issue description.
The content of the macro in [PlantUML](http://plantuml.com/) language is converted into the URL to
PlantUML [server](http://plantuml.com/server.html) and this URL is inserted into wiki page
as an external image.

Installation
------------

1. Copy the content of this repository to `$REDMINE/plugins/plantuml_macro` folder.
2. Restart Redmine.

Configuration
-------------

You can configure the plugin on `Administration->Plugins` page.

You can define the URL of the PlantUML server. Default value is `http://plantuml.com/plantuml/`.

Usage
-----

Enter something like this on a wiki page:

    {{plantuml
        Bob -> Alice : hello
    }}

This will be rendered as the image located on the configured PlantUML server.

Other
-----

The plugin requires `redmine`, `uri` and `zlib` Ruby modules.

The code to encode PlantUML URL is converted from this Python code: https://github.com/dougn/python-plantuml/blob/master/plantuml.py