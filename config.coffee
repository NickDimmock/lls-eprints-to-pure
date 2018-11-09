# Shared config

module.exports = () ->
    # Org ID whitelist:
    orgs_file = require "./src/depts.json"
    orgWhitelist = []
    orgs_file.organisations.organisation.forEach (org) ->
        orgWhitelist.push(org.organisationId)

    # Email to ID lookup:
    emailToID = require './src/email-lookup.json'

    return {
        orgWhitelist: orgWhitelist
        emailToID: emailToID
    }