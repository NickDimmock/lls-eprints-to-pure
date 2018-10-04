###
Output example:
<v1:persons>
    <v1:author>
    <v1:role>editor</v1:role>
    <v1:person>
        <v1:firstName>Gerri</v1:firstName>
        <v1:lastName>Kimber</v1:lastName>
    </v1:person>
    <v1:organisations>
        <v1:organisation>
        <v1:name>
            <v3:text>University of Northampton</v3:text>
        </v1:name>
        </v1:organisation>
    </v1:organisations>
    </v1:author>
    <v1:author>
    <v1:role>author</v1:role>
    <v1:person>
        <v1:firstName>Janet M</v1:firstName>
        <v1:lastName>Wilson</v1:lastName>
    </v1:person>
    <v1:organisations>
        <v1:organisation>
        <v1:name>
            <v3:text>University of Northampton</v3:text>
        </v1:name>
        </v1:organisation>
    </v1:organisations>
    </v1:author>
</v1:persons>
###

module.exports = (config, eprint) ->
    # personsTag = config.importPrefix + 'persons'
    # authorTag = config.importPrefix + 'author'
    # roleTag = config.importPrefix + 'role'
    # personTag = config.importPrefix + 'person'
    # firstNameTag = config.importPrefix + 'firstName'
    # lastNameTag = config.importPrefix + 'lastName'
    # orgsTag = config.importPrefix + 'organisations'
    # orgTag = config.importPrefix + 'organisation'
    # nameTag = config.importPrefix + 'name'
    # textTag = config.commonsPrefix + 'text'
    authorsData = []

    # creators and editors are distinct in eprints but are both persons
    # entires in Pure. Easiest to just run through each in turn.

    if eprint.creators?
        eprint.creators.forEach (creator) ->
            author =
                "#{config.importPrefix}role": 'author'
                "#{config.importPrefix}person":
                    "#{config.importPrefix}firstName": creator.name.given
                    "#{config.importPrefix}lastName": creator.name.family
            if creator.id? and creator.id.includes 'northampton.ac.uk'
                author["#{config.importPrefix}organisations"] =
                    "#{config.importPrefix}organisation":
                        "#{config.importPrefix}name":
                            "#{config.commonsPrefix}text": 'University of Northampton'
                #author[roleTag] = 'author'
            authorsData.push author

    if eprint.editors
        eprint.editors.forEach (editor) ->
            author =
                "#{config.importPrefix}role": 'editor'
                "#{config.importPrefix}person":
                    "#{config.importPrefix}firstName": editor.name.given
                    "#{config.importPrefix}lastName": editor.name.family
            if editor.id? and editor.id.includes 'northampton.ac.uk'
                author["#{config.importPrefix}organisations"] =
                        "#{config.importPrefix}organisation":
                            "#{config.importPrefix}name":
                                "#{config.commonsPrefix}text": 'University of Northampton'
            authorsData.push author
        
    return
        "#{config.importPrefix}persons":
            "#{config.importPrefix}author":
                authorsData