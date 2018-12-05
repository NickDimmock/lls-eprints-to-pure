
fs = require 'fs'
convert = require 'xml-js'
createXMLAttributes = require './createXMLAttributes'

module.exports = (config, outputs) ->

    total = outputs.length

    # Output file setup
    outputRoot = 'out/' + process.argv[3]
    outputXML = outputRoot + '.xml'
    outputJSON = outputRoot + '.json'

    # Generate required XML attributes:
    attributes = createXMLAttributes config

    # Construct JSON object:
    jsonOut = JSON.stringify
        [config.root]:
            '_attributes': attributes
            "#{config.importPrefix}#{config.type}": outputs
        null
        4

    # And now the XML output:
    xmlOut = convert.json2xml(jsonOut, {compact: true, spaces: 4})

    # Write to files:
    fs.writeFile outputJSON, jsonOut, (err) ->
        if err?
            throw err
        # Success:
        console.log 'JSON file saved.'

    fs.writeFile outputXML, xmlOut, (err) ->
        if err?
            throw err
        # Success:
        console.log "XML file saved: #{total} items."