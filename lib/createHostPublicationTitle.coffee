module.exports = (config, eprint) ->
    title = if eprint.book_title then eprint.book_title else "[No title]"
    if not eprint.book_title
        console.log "No publication title for #{eprint.eprintid}."
    return
        "#{config.importPrefix}hostPublicationTitle": title