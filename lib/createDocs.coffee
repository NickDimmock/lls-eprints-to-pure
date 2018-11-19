mapVersion = require './mapVersion'
getCCLink = require './getCCLink'
moment = require 'moment'

# Map eprints version to hoa version:
hoaVersions =
    'accepted': 'AV'
    'published': 'VoR'

module.exports = (config, eprint, docs) ->

    pureVersions = {}

    ## Get DOI links out of the way first...
    if eprint.doi?
        # Make sure it's a DOI and not a DOI link...
        doi = eprint.doi.replace /^http.*org\//, ''
        pureVersions["#{config.importPrefix}electronicVersionDOI"] =
            "#{config.importPrefix}publicAccess": 'unknown',
            "#{config.importPrefix}doi": doi

    # Files are more complicated.
    if docs
        files = []
        docs.forEach (doc) ->
            ###
                File method for depositDate / accessDate
                hoa_version_fcd (AM, VoR) - version to match for hoa fcd data
                hoa_date_fcd = deposit date of matching file
                hoa_date_foa = date of first open access

                If file is accepted / published, check hoa_version_fcd for match
                    AM = accepted, VoR = published
                If matched, add hoa_date_fcd to this file
                If hoa_date_foa exists, also add that to the same file
            ###
                    
            # We need to confirm a doc.content value to translate to version in Pure,
            # or the import will fail.
            # if (doc.content) {
                fileContent = {
                        ["#{config.importPrefix}version"]: mapVersion(doc.content)
                }
                # Licences need a licence and a URL - needs a lookup from the cc.js module
                if doc.license? and getCCLink doc.license
                    fileContent["#{config.importPrefix}licence"] = doc.license
                    fileContent["#{config.importPrefix}otherLicenceUrl"] = getCCLink doc.license

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
                fileContent["#{config.importPrefix}publicAccess"] = pubacc
                if pureEmbargoEnd?
                    fileContent["#{config.importPrefix}embargoEndDate"] = pureEmbargoEnd
                fileContent["#{config.importPrefix}title"] = doc.filename
                # Add eprintid/docid as file id (e.g. <v1:file id="173778/224584">)
                # TODO: add following (after filesize?):
                # <v1:externalRepositoryState>STORED</v1:externalRepositoryState>
                # <!-- Storage name defined in Pure -->
                # <v1:source>eprints name</v1:source>
                fileContent["#{config.importPrefix}file"] =
                    "_attributes": {
                        id: "#{doc.eprintid}/#{doc.docid}"
                    }
                    "#{config.importPrefix}filename": doc.main
                    "#{config.importPrefix}fileLocation": doc.uri
                    "#{config.importPrefix}mimetype": doc.mime_type
                    "#{config.importPrefix}filesize": doc.files[0].filesize
                    "#{config.importPrefix}externalRepositoryState": "STORED"
                    "#{config.importPrefix}source": config.eprintsStore
                if eprint.hoa_version_fcd? and Object.keys(hoaVersions).includes(doc.content)
                #if false
                    if eprint.hoa_version_fcd is hoaVersions[doc.content]
                        fileContent["#{config.importPrefix}file"] = {
                            ...fileContent["#{config.importPrefix}file"]
                            ...{
                                "#{config.importPrefix}depositDate": eprint.hoa_date_fcd
                            }
                        }
                        if eprint.hoa_date_foa?
                            fileContent["#{config.importPrefix}file"] = {
                                ...fileContent["#{config.importPrefix}file"]
                                ...{
                                  "#{config.importPrefix}accessDate": eprint.hoa_date_foa
                                }
                           }
                #fileContent["#{config.importPrefix}link"] = doc.uri
                files.push fileContent

        if files.length
            pureVersions["#{config.importPrefix}electronicVersionFile"] = files

    return
        "#{config.importPrefix}electronicVersions": pureVersions