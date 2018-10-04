module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}numberOfPages": eprint.pages
