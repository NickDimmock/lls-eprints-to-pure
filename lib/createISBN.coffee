# Uses simple-isbn module to parse and validate isbn before sending data back

ISBN = require('simple-isbn').isbn

module.exports = (config, eprint) ->
    # Eprint ISBNs may be string or number, depending on content.
    # Cast to string and trim, just in case
    myISBN = eprint.isbn.toString().trim()
    if ISBN.isValidIsbn myISBN
        return
            "#{config.importPrefix}printIsbns":
                "#{config.importPrefix}isbn": myISBN
    else
        console.log "Non-parsing ISBN (#{myISBN}) in item #{eprint.eprintid}."
        return false