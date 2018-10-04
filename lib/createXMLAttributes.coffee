# Generate top-level publications tag, with appropriate namespace info
# Some namespaces have no prefix, but this doesn't seem to be consistent
module.exports = (config) ->
    # Use the prefix value from the config, but move the : to the start for the namespace
    if config.importPrefix.length
        importPrefix = ':' + config.importPrefix.replace ':', ''
    else
        importPrefix = ''
    if config.commonsPrefix.length
        commonsPrefix = ':' + config.commonsPrefix.replace ':', ''
    else
        commonsPrefix = ''
    return
        "xmlns#{importPrefix}": config.importNamespace,
        "xmlns#{commonsPrefix}": config.commonsNamespace