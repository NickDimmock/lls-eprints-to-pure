# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    journalNumberTag = config.importPrefix + 'journalNumber'
    return
        "#{config.importPrefix}journalNumber": eprint.number