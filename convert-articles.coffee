fs = require 'fs'
convert = require 'xml-js'

# Load individual import modules:
lib = require('require-dir')('./lib')

# Input file
jsonIn = require './' + process.argv[2]

# Output file setup
outputRoot = 'out/' + process.argv[3]
outputXML = outputRoot + '.xml'
outputJSON = outputRoot + '.json'

config =
    type: 'contributionToJournal'
    subType: 'article'
    root: 'v1:publications'
    importNamespace: 'v1.publication-import.base-uk.pure.atira.dk'
    importPrefix: 'v1:'
    commonsNamespace: 'v3.commons.pure.atira.dk'
    commonsPrefix: 'v3:'

outputs = []

jsonIn.forEach (eprint) ->
    
    item =
        '_attributes':
            id: eprint.eprintid
            subType: config.subType

    item = {...item, ...lib.createRefereed(config, eprint)}
    item = {...item, ...lib.createPubStatus(config, eprint)}
    item = {...item, ...lib.createTitle(config, eprint)}
    if eprint.abstract?
        item = {...item, ...lib.createAbstract(config, eprint)}
    item = {...item, ...lib.createPersons(config, eprint)}
    item = {...item, ...lib.createOwner(config, eprint)}
    if eprint.keywords? and eprint.keywords.includes ','
        item = {...item, ...lib.createKeywords(config, eprint)}
    if eprint.related_url?
        item = {...item, ...lib.createURLs(config, eprint)}
    docs = lib.getDocs(eprint)
    if docs.length
        item = {...item, ...lib.createDocs(config, eprint, docs)}
    item = {...item, ...lib.createVisibility(config, eprint)}
    if eprint.pages?
        item = {...item, ...lib.createPages(config, eprint)}
    if eprint.number?
        item = {...item, ...lib.createJournalNumber(config, eprint)}
    if eprint.volume?
        item = {...item, ...lib.createJournalVolume(config, eprint)}
    item = {...item, ...lib.createJournal(config, eprint)}
    
    outputs.push item

console.log JSON.stringify outputs, null, 4