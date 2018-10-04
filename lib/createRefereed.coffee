module.exports = (config, eprint) ->
    if eprint.refereed? and eprint.refereed is 'TRUE'
        return
            "#{config.importPrefix}peerReviewed": true
    else
        return
            "#{config.importPrefix}peerReviewed": false