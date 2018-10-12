# Basic checks to see if an eprint is valid and should be processed at all.

mapDateType = require  './mapDateType'

module.exports = (config, eprint) ->

    valid = true
    problems = []

    # Pub status
    eprint.dates.forEach (date) ->
        unless mapDateType(date.date_type)
            valid = false
            console.log "Invalid status (#{date.date_type}) for #{eprint.eprintid}!"

    return valid