###

Example output:

    <v1:owner id="organisation2"/>

TODO: Need to map departmental owner id to relevant Pure field.

###

module.exports = (config, eprint) ->
    return
        "#{config.importPrefix}owner":
            '_attributes':
                'id': 1