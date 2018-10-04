# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}series":
            "#{config.importPrefix}serie":
                "#{config.importPrefix}name": eprint.series
