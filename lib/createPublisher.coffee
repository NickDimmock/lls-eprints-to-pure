# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}publisher":
            "#{config.importPrefix}name": eprint.publisher
