# Load individual import modules:
lib = require('require-dir')('./lib')
sharedConfig = require "./config"

# Input file
jsonIn = require './' + process.argv[2]

#emailToID = require './src/email-lookup.json'

localConfig =
        type: 'contributionToConference'
        #subType: 'article'
        root: 'v1:publications'
        importNamespace: 'v1.publication-import.base-uk.pure.atira.dk'
        importPrefix: 'v1:'
        commonsNamespace: 'v3.commons.pure.atira.dk'
        commonsPrefix: 'v3:'

config = {
    ...sharedConfig()
    ...localConfig
}

outputs = []

jsonIn.forEach (eprint) ->

    console.log "Processing #{eprint.eprintid}..."

    if not lib.validator(config, eprint)
        console.log "Problem with #{eprint.eprintid}!"
        return
    
    if eprint.pres_type
        subType = lib.mapPresType(eprint.pres_type)
        if not subType
            console.log "Skipping #{eprint.eprintid} - type #{eprint.pres_type} not supported."
            return
    else
        console.log "Skipping #{eprint.eprintid} - no pres_type value."
        return

    item =
        '_attributes':
            id: eprint.eprintid
            subType: subType

    item = {...item, ...lib.createRefereed(config, eprint)}
    item = {...item, ...lib.createPubStatus(config, eprint)}
    item = {...item, ...lib.createTitle(config, eprint)}
    if eprint.abstract?
        item = {...item, ...lib.createAbstract(config, eprint)}
    item = {...item, ...lib.createPersons(config, eprint)}
    item = {...item, ...lib.createOrganisations(config, eprint)}
    item = {...item, ...lib.createOwner(config, eprint)}
    if eprint.keywords? and eprint.keywords.includes ','
        item = {...item, ...lib.createKeywords(config, eprint)}
    if eprint.related_url?
        item = {...item, ...lib.createURLs(config, eprint)}
    docs = lib.getDocs(eprint)
    if docs.length
        item = {...item, ...lib.createDocs(config, eprint, docs)}
    item = {...item, ...lib.createVisibility(config, eprint)}
    item = {...item, ...lib.createConfEvent(config, eprint)}
    
    outputs.push item

lib.writeFiles config, outputs
