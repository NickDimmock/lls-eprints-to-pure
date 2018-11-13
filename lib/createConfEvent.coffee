###
<v1:event id="event1">
    <v1:type>conference</v1:type>
    <v1:title>
        <v3:text>British Society for Immunology (BSI) annual congress</v3:text>
    </v1:title>
    <v1:description>
        <v3:text lang="en" country="GB">Congress description</v3:text>
    </v1:description>
    <v1:city>Brighton</v1:city>
    <v1:location>UK</v1:location>
    <v1:country>gb</v1:country>
    <v1:startDate>10-04-1980</v1:startDate>
    <v1:endDate>11-04-1980</v1:endDate>
    <v1:degreeOfRecognition>national</v1:degreeOfRecognition>
    <v1:webAddress>http://elsevier.com/theconference</v1:webAddress>
    <v1:workflow>approved</v1:workflow>
</v1:event>

v1:event:
    _attributes:
        id: "event1"
    v1:title:
        v3:text: "Title text"
    v1:city: "Bristol"

    Date is a hard field to crack:
    Pure requires separate start / end dates
    NECTAR provides one of the following:
        01 April 2018
        01-03 April 2018
        30 April - 02 May 2018
        30 December 2018 - 03 Jan 2019

    eprint.related_url entry with type 'conf' can be used for conference URL
###

getEventURL = (eprint) ->
    url = false
    if eprint.related_url
        eprint.related_url.forEach (obj) ->
            if not url and obj.type is "conf"
                url = obj.url
    return url


module.exports = (config, eprint) ->
    eventURL = getEventURL(eprint)
    eventData =
            "_attributes":
                id: "event-#{eprint.eprintid}"
    if eprint.event_type
        eventData["#{config.importPrefix}type"] = eprint.event_type
    if eprint.event_title
        eventData["#{config.importPrefix}title"] =
            "#{config.commonsPrefix}text": eprint.event_title
    if eprint.event_location
        eventData["#{config.importPrefix}location"] = eprint.event_location
    if eventURL
        eventData["#{config.importPrefix}webAddress"] = eventURL

    return
        "#{config.importPrefix}event": eventData
    