###

Example output:

    <v1:owner id="organisation2"/>

TODO:   Need to map departmental owner id to relevant Pure field.
TODO:   Leaving id blank seems to use first-named dept from createDocs
        (organisaitonal affiliation). Checking with Pure whether this
        is OK (tag is still required, even if left blank).

###

module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}owner":
            '_attributes':
                'id': ""