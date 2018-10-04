module.exports = (licence) ->
    ver = '4.0'
    url = false
    if licence is 'cc_public_domain'
        url = 'https://creativecommons.org/publicdomain/zero/1.0/legalcode'
    else if licence.startsWith 'cc_'
        licence = licence.replace /^cc_/, ''
        url = "https://creativecommons.org/licenses/#{licence}/#{ver}/legalcode"
    return url