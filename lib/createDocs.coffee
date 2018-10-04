mapVersion = require './mapVersion'
getCCLink = require './getCCLink'
moment = require 'moment'

module.exports = (config, eprint, docs) ->

    pureVersions = {}

    if eprint.doi?
        # Make sure it's a DOI and not a DOI link...
        doi = eprint.doi.replace /^http.*org\//, ''
        pureVersions["#{config.importPrefix}electronicVersionDOI"] =
            "#{config.importPrefix}publicAccess": 'unknown',
            "#{config.importPrefix}doi": doi

    if docs
        links = []
        docs.forEach (doc) ->

            # We need to confirm a doc.content value to translate to version in Pure,
            # or the import will fail.
            # if (doc.content) {
                linkContent = {
                        ["#{config.importPrefix}version"]: mapVersion(doc.content)
                }
                # Licences need a licence and a URL - needs a lookup from the cc.js module
                if doc.license? and getCCLink doc.license
                    linkContent["#{config.importPrefix}licence"] = doc.license
                    linkContent["#{config.importPrefix}otherLicenceUrl"] = getCCLink doc.license

                ###
                Generate publicAccess value using doc.security
                The relevant publicAccess options seem to be open, embargoed and either closed
                or unknown.
                Ideally we'll only need open and embargoed.
                NECTAR will have public and staffonly (in the security value) - staffonly will
                apply to embargoed and restricted files, but embargoed files will also have embargo
                end dates (date_embargo).
                ###
                pubacc = "unknown"
                if doc.security is "public"
                    pubacc = "open"
                else if doc.security is "staffonly"
                    if doc.date_embargo?
                        pubacc = "embargoed"
                        # Embargo end date needs to be flipped from ymd to dmy
                        embargoEnd = moment doc.date_embargo
                        pureEmbargoEnd = embargoEnd.format 'DD-MM-YYYY'
                    else
                        pubacc = "closed"
                linkContent["#{config.importPrefix}publicAccess"] = pubacc
                if pureEmbargoEnd?
                    linkContent["#{config.importPrefix}embargoEndDate"] = pureEmbargoEnd
                linkContent["#{config.importPrefix}link"] = doc.uri
                links.push linkContent

        if links.length
            pureVersions["#{config.importPrefix}electronicVersionLink"] = links

    return
        "#{config.importPrefix}electronicVersions": pureVersions