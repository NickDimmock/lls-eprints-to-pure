# TODO: Map link type fields in NECTAR to some kind of description value?
module.exports = (config, eprint) ->
    urlsTag = config.importPrefix + 'urls'
    urlTag = config.importPrefix + 'url'
    urlList = []
    eprint.related_url.forEach (urlObj) ->
        urlList.push
            "#{config.importPrefix}url": urlObj.url
    return
        "#{config.importPrefix}urls":
            "#{config.importPrefix}url": urlList