# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    journalTag = config.importPrefix + 'journal'
    titleTag = config.importPrefix + 'title'
    printIssnsTag = config.importPrefix + 'printIssns'
    issnTag = config.importPrefix + 'issn'

    journalData =
        "#{config.importPrefix}title": eprint.publication

    if eprint.issn?
        journalData["#{config.importPrefix}printIssns"] =
            "#{config.importPrefix}issn": eprint.issn

    return
        "#{config.importPrefix}journal": journalData