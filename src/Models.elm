module Models exposing (..)


import Hop.Types exposing (Location)
import Service.Models
--import Service.List


type Route
    = HomeRoute
    | ServiceRoutes Service.Models.Route
    | NotFoundRoute


type alias AppModel =
    { location : Location
    , route : Route
    , services : List Service.Models.Service
    , servicesMeta : Service.Models.ServicesMeta
    , newService : Service.Models.Service
    }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { location = location
    , route = route
    , services = mock
    , servicesMeta = Service.Models.newServicesMeta
    , newService = Service.Models.new
    }


mock : List Service.Models.Service
mock =
    [ Service.Models.Service "foobar" "lol" Service.Models.Valid
    , Service.Models.Service "yolo" "lol" Service.Models.Valid
    , Service.Models.Service "jacobtest111" "lol" Service.Models.Valid
    ]