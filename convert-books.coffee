# Load individual import modules:
lib = require('require-dir')('./lib')
sharedConfig = require "./config"

# Input file
jsonIn = require './' + process.argv[2]

# Item specific variables (no import namespace for chapters):
localConfig =
    type: 'book'
    subType: 'book'
    root: 'v1:publications'
    importNamespace: 'v1.publication-import.base-uk.pure.atira.dk'
    importPrefix: 'v1:'
    commonsNamespace: 'v3.commons.pure.atira.dk'
    commonsPrefix: 'v3:'

config = {
    ...sharedConfig()
    ...localConfig
}

# Array to store all outputs for this item type:
outputs = []

# Iterate through eprint items:
jsonIn.forEach (eprint) ->

    console.log "Processing #{eprint.eprintid}..."

    # Main body of details:
    item =
        '_attributes':
            'id': eprint.eprintid
            'subType': config.subType
    
    # Add required modules:
    item = {...item, ...lib.createRefereed(config, eprint)}
    item = {...item, ...lib.createPubStatus(config, eprint)}
    # Hopefiully not required:
    # item = {...item, ...lib.createLanguage(config, eprint)}
    item = {...item, ...lib.createTitle(config, eprint)}
    # Subtitle here, not provided by Eprints
    #if eprint.abstract?
        #item = {...item, ...lib.createAbstract(config, eprint)}
    item = {...item, ...lib.createPersons(config, eprint)}
    item = {...item, ...lib.createOrganisations(config, eprint)}
    item = {...item, ...lib.createOwner(config, eprint)}
    if eprint.keywords? and eprint.keywords.includes ','
        item = {...item, ...lib.createKeywords(config, eprint)}
    # URLs here?
    docs = lib.getDocs eprint
    if docs.length
        item = {...item, ...lib.createDocs(config, eprint, docs)}
    item = {...item, ...lib.createVisibility(config, eprint)}
    item = {...item, ...lib.createISBN(config, eprint)}
    if eprint.publisher?
        item = {...item, ...lib.createPublisher(config, eprint)}
 
    # Shove this item into the outputs array:
    outputs.push item

lib.writeFiles config, outputs
