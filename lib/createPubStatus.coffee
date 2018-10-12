moment = require 'moment'
mapDateType = require  './mapDateType'

module.exports = (config, eprint) ->

    statuses = []

    eprint.dates.forEach (date) ->
        # Need to cast to string because eprints exports single year dates as ints:
        epDate = moment date.date.toString()
        statusType = mapDateType date.date_type
        if epDate.isValid() and statusType
            ps =
                "#{config.importPrefix}statusType": mapDateType date.date_type
                "#{config.importPrefix}date":
                    "#{config.commonsPrefix}day": epDate.format 'DD'
                    "#{config.commonsPrefix}month": epDate.format 'MM'
                    "#{config.commonsPrefix}year": epDate.year()
            statuses.push(ps)

    if statuses.length
        return
            "#{config.importPrefix}publicationStatuses":
                "#{config.importPrefix}publicationStatus": statuses