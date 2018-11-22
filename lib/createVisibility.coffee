module.exports = (config, eprint) ->
    if eprint.eprint_status == "archive"
        status = "Public"
    else
        status = "Restricted"
    return
        "#{config.importPrefix}visibility": status

