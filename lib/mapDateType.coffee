# Map a date type defintion from eprints to Pure
# Currently mapping legacy 'presentation' date type to 'published'
# as best fit for default Pure system

module.exports = (t) ->
    eprintsToPureDateTypeMap =
        published: 'published'
        presentation: 'published'
        accepted: 'inpress'
        published_online: 'epub'
        submitted: 'submitted'
        completed: 'published'
    if eprintsToPureDateTypeMap[t]
        return eprintsToPureDateTypeMap[t]
    else
        return false
