###
    Example XML:

    <v1:organisations>
        <v1:organisation id="ORG_ID"></v1:organisation>
    </v1:organisations>

    Only requires ID, but ID map to an org unit  in Pure.
###

module.exports = (config, eprint) ->
    orgs = []
    eprint.divisions.forEach (div) ->
        if div in config.orgWhitelist
            orgs.push {
                "_attributes": {
                    "id": div
                }
                "_text": ""
            }

    if orgs.length
        return {
            "#{config.importPrefix}organisations": {
                "#{config.importPrefix}organisation": orgs
            }
        }