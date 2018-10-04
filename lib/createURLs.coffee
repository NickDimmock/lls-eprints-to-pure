# TODO: Map link type fields in NECTAR to some kind of description value?
module.exports = (config, eprint) ->
    urlsTag = config.importPrefix + 'urls'
    urlTag = config.importPrefix + 'url'
    urls = []
    eprint.related_url.forEach (urlObj) ->
        urls.push
            "#{config.importPrefix}url":
                "#{config.importPrefix}url": urlObj.url
    return
        "#{config.importPrefix}urls": urls