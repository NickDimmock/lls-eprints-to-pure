# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    journalData =
        "#{config.importPrefix}title": eprint.publication

    if eprint.issn?
        journalData["#{config.importPrefix}printIssns"] =
            "#{config.importPrefix}issn": eprint.issn

    return
        "#{config.importPrefix}journal": journalData