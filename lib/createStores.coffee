module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}existingStores":
            "#{config.importPrefix}existingStore":
                "#{config.importPrefix}storeName": config.eprintsStore
                "#{config.importPrefix}storeContentId": eprint.eprintid
        "#{config.importPrefix}transferToRepository": "true"
                