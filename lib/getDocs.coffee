module.exports = (eprint) ->
    # Check through item docs and filter out any that don't meet requirements.
    # Return a new version of the docs object.
    
    validDocs = []

    if eprint.documents?
        eprint.documents.forEach (doc) ->
            # No acceptance evidence
            # No items with 'relation' value (thumbnails etc.)
            include = false
            # Only accept security: staffonly if there's an embargo date
            if doc.security is 'staffonly' and doc.date_embargo?
                include = true
            # Ignore acceptance evidence and items with a relation value
            # (e.g. thumbbnail files)
            else if doc.format isnt 'acceptance_evidence' and
            not doc.relation?
                include = true
            # Final check for content value (required for version field in Pure).
            # Check this last so we can log failures (likely to need attention).
            if include
                if doc.content?
                    validDocs.push doc
                else
                    console.log "File #{doc.docid} is valid but has no content value."

    return validDocs