# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}printIsbns":
            "#{config.importPrefix}isbn": eprint.isbn
