# Map pres_type Eprints value to sub-type value for Pure

###
Eprints values:
    exhibition (goes in non-textual type in Pure)
    invited_keynote
    invited_presentation
    paper
    poster
    practical
    keynote
    panel_presentation
    workshop
    symposium
    lecture
    seminar
    other (maybe goes in other type in Pure?)
Pure values:
    paper
    poster
    abstract
###

module.exports = (t) ->
    typeMap =
        #exhibition
        invited_keynote: "paper"
        invited_presentation: "paper"
        paper: "paper"
        poster: "poster"
        #practical
        keynote: "paper"
        panel_presentation: "paper"
        workshop: "paper"
        symposium: "paper"
        #lecture
        #seminar
        #other
    if typeMap[t]
        return typeMap[t]
    else
        return false