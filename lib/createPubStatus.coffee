moment = require 'moment'
mapDateType = require  './mapDateType'

module.exports = (config, eprint) ->

    statuses = []

    eprint.dates.forEach (date) ->
        epDate = moment date.date
        if epDate.isValid()
            ps =
                "#{config.importPrefix}statusType": mapDateType date.date_type
                "#{config.importPrefix}date":
                    "#{config.commonsPrefix}day": epDate.format 'DD'
                    "#{config.commonsPrefix}month": epDate.format 'MM'
                    "#{config.commonsPrefix}year": epDate.year()
            statuses.push(ps)

    return
        "#{config.importPrefix}publicationStatuses":
            "#{config.importPrefix}publicationStatus": statuses