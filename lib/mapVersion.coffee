# Map a version type defintion from eprints to Pure
# Defaults to 'other' for anything other than published / accepted
# Available Pure versions: publishersversion, authorsversion, preprint, other
# (as per dk_atira_pure_core_document_versiontypes.xls)
# Pure has no equivalent to 'submitted'

module.exports = (t) ->
    versionTable =
        'published': 'publishersversion'
        'accepted': 'authorsversion'

    if versionTable[t]?
        return versionTable[t]
    else
        return 'other'