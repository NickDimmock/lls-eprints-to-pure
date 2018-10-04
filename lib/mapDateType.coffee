# Map a date type defintion from eprints to Pure

module.exports = (t) ->
    eprintsToPureDateTypeMap =
        published: 'published'
        accepted: 'inpress'
        published_online: 'epub'
        submitted: 'submitted'
        completed: 'published'
    return eprintsToPureDateTypeMap[t]
