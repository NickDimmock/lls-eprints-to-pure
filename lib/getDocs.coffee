module.exports = (eprint) ->
    # Check through item docs and filter out any that don't meet requirements.
    # Return a new version of the docs object.
    
    validDocs = []

    if eprint.documents?
        eprint.documents.forEach (doc) ->
            # No acceptance evidence
            # No items with 'relation' value (thumbnails etc.)
            # No items without a 'content' value (required by Pure)
            if doc.format isnt 'acceptance_evidence' and
                not doc.relation? and
                doc.content?
                    validDocs.push doc

    return validDocs