# Load individual import modules:
lib = require('require-dir')('./lib')
emailToID = require './src/email-lookup.json'

# Input file
jsonIn = require './' + process.argv[2]

# Item specific variables (no import namespace for chapters):
config =
    emailToID: emailToID
    type: 'chapterInBook'
    subType: 'chapter'
    root: 'publications'
    importNamespace: 'v1.publication-import.base-uk.pure.atira.dk'
    importPrefix: ''
    commonsNamespace: 'v3.commons.pure.atira.dk'
    commonsPrefix: 'ns2:'

# Array to store all outputs for this item type:
outputs = []

# Iterate through eprint items:
jsonIn.forEach (eprint) ->

    # Main body of details:
    item =
        '_attributes':
            'id': eprint.eprintid
            'subType': config.subType
    
    # Add required modules:
    item = {...item, ...lib.createRefereed(config, eprint)}
    item = {...item, ...lib.createPubStatus(config, eprint)}
    item = {...item, ...lib.createTitle(config, eprint)}
    if eprint.abstract?
        item = {...item, ...lib.createAbstract(config, eprint)}
    item = {...item, ...lib.createPersons(config, eprint)}
    item = {...item, ...lib.createOwner(config, eprint)}
    if eprint.keywords? and eprint.keywords.includes ','
        item = {...item, ...lib.createKeywords(config, eprint)}
    docs = lib.getDocs eprint
    if docs.length
        item = {...item, ...lib.createDocs(config, eprint, docs)}
    item = {...item, ...lib.createVisibility(config, eprint)}
    if eprint.pagerange?
        item = {...item, ...lib.createPageRange(config, eprint)}
    if eprint.pages?
        item = {...item, ...lib.createPages(config, eprint)}
    if eprint.place_of_pub?
        item = {...item, ...lib.createPlaceOfPublication(config, eprint)}
    if eprint.volume?
        item = {...item, ...lib.createVolume(config, eprint)}
    if eprint.isbn?
        item = {...item, ...lib.createISBN(config, eprint)}
    if eprint.book_title?
        item = {...item, ...lib.createHostPublicationTitle(config, eprint)}
    if eprint.publisher?
        item = {...item, ...lib.createPublisher(config, eprint)}
    if eprint.series?
        item = {...item, ...lib.createSeries(config, eprint)}
    
    # Shove this item into the outputs array:
    outputs.push item

lib.writeFiles config, outputs
