# Map a date type defintion from eprints to Pure

eprintsToPureDateTypeMap =
    'published': 'published'
    'accepted': 'inpress'
    'published_online': 'epub'
    'submitted': 'submitted'
    'completed': 'published'

module.exports = (t) ->
    return eprintsToPureDateTypeMap.t
