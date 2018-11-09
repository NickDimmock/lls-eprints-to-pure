moment = require 'moment'
mapDateType = require  './mapDateType'

module.exports = (config, eprint) ->
    statuses = []

    eprint.dates.forEach (date) ->
        # Cast date to string, because Eprints serves dates that are just years as ints.
        # Use js date initially, to cope better with anomalous dates (e.g. just a year).
        jsDate = new Date(date.date.toString())
        #epDate = jsDate.toISOString().substring(0,10);
        epDate = moment jsDate
        statusType = mapDateType date.date_type
        if epDate.isValid() and statusType
            ps =
                "#{config.importPrefix}statusType": statusType
                "#{config.importPrefix}date":
                    "#{config.commonsPrefix}day": epDate.format 'DD'
                    "#{config.commonsPrefix}month": epDate.format 'MM'
                    "#{config.commonsPrefix}year": epDate.year()
            statuses.push(ps)

    if statuses.length
        return
            "#{config.importPrefix}publicationStatuses":
                "#{config.importPrefix}publicationStatus": statuses