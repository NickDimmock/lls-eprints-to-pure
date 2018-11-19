# Shared config

module.exports = () ->
    # Org ID whitelist:
    orgs_file = require "./src/org_list.json"
    orgWhitelist = []
    for key, val of orgs_file
        #orgs_file.organisations.organisation.forEach (org) ->
        orgWhitelist.push(key)

    # Email to ID lookup:
    emailToID = require './src/email_lookup.json'

    return {
        orgWhitelist: orgWhitelist
        emailToID: emailToID
        eprintsStore: "nectar"
    }