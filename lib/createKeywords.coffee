module.exports = (config, eprint) ->

    # Array to store actual keyword entries
    pureKws = []

    # Split data by comma, trim trailing whitespace and push to array:
    eprint.keywords.split(',').forEach (kw) ->
        kw = kw.trim()
        pureKws.push
            "#{config.commonsPrefix}text": kw

    # Return array inside required structure:
    return
        "#{config.importPrefix}keywords":
            "#{config.commonsPrefix}logicalGroup":
                '_attributes':
                    'logicalName': 'keywordContainers'
                "#{config.commonsPrefix}structuredKeywords":
                    "#{config.commonsPrefix}structuredKeyword":
                        "#{config.commonsPrefix}freeKeywords":
                            "#{config.commonsPrefix}freeKeyword": pureKws