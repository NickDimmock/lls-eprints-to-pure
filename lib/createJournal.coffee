# TODO: may need to sanitise input?
module.exports = (config, eprint) ->
    journalData =
        "#{config.importPrefix}title": eprint.publication

    if eprint.issn?
        #  Grab the first nine characters to solve combined ISSN / eISSN text:
        issn = eprint.issn.trim().substring(0, 9)
        # Simple ISSN regex test...
        if issn.match(/^[\S]{4}\-[\S]{4}$/)
            journalData["#{config.importPrefix}printIssns"] =
                "#{config.importPrefix}issn": issn
        else
            console.log "Invalid ISSN (#{issn}) for #{eprint.eprintid}."

    return
        "#{config.importPrefix}journal": journalData