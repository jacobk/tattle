module Models exposing (..)


import Hop.Types exposing (Location)
import Route exposing (Route)
import Services.Models


type alias AppModel =
    { location : Location
    , route : Route
    , services : List Services.Models.Service
    , servicesMeta : Services.Models.ServicesMeta
    , newService : Services.Models.Service
    }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { location = location
    , route = route
    , services = mock
    , servicesMeta = Services.Models.newServicesMeta
    , newService = Services.Models.new
    }


mock : List Services.Models.Service
mock =
    [ Services.Models.Service "foobar" "lol" Services.Models.Valid
    , Services.Models.Service "yolo" "lol" Services.Models.Valid
    , Services.Models.Service "jacobtest111" "lol" Services.Models.Valid
    ]
