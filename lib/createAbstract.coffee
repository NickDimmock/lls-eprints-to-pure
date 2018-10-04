###
Example output:
    <v1:abstract>
      <v3:text lang="en" country="GB">Abstract text here!</v3:text>
    </v1:abstract>

TODO: Using defaults for lang & country at the moment...
###

xmlescape = require('xml-escape')

module.exports = (config, eprint) ->
    lang = 'en'
    country = 'GB'

    # Escape content to pass through <, >, & and so on.
    abstract = xmlescape eprint.abstract

    # TODO: Verify if / how Pure handles line breaks in abstracts
    #  Methods below result in readable abstracts, but lose heading structure etc.
    # Replacing with a space for now, pending advice.

    # NECTAR abstracts sometimes have two line breaks around a space to force
    # a spaced paragraph.
    # Replacing with a space for now, pending advice.
    abstract = abstract.replace /\r\n \r\n/g, ' '

    # Single line breaks need to be replaced or Pure will just chop them out
    # and run words together.
    abstract = abstract.replace /\r\n/g, ' '

    return
        "#{config.importPrefix}abstract":
            "#{config.commonsPrefix}text":
                '_attributes':
                    'lang': lang
                    'country': country
                "_cdata": abstract