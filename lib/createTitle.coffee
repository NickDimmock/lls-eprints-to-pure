###
Example output:
    <v1:title>
      <v3:text lang="en" country="GB">The title</v3:text>
    </v1:title>

TODO: Using defaults for lang & country at the moment...
###

module.exports = (config, eprint) ->
    lang = 'en'
    country = 'GB'

    # Title may have line breaks, if it's been pasted in from a PDF etc.
    # Replace with a space to avoid words being concatenated.
    # This doesn't happen with the displayed title in Pure, but does in the
    # text shown in the editing form.

    title = eprint.title.replace /\r\n/g, ' '

    return
        "#{config.importPrefix}title":
             "#{config.commonsPrefix}text":
                '_attributes':
                    'lang': lang
                    'country': country
                '_text': title