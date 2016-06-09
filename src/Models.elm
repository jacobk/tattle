module Models exposing (..)


import Hop.Types exposing (Location, newLocation)
import Service.Models


type Route
    = HomeRoute
    | ServiceRoutes Service.Models.Route


type alias AppModel =
    { location : Location
    , route : Route
    , service : Service.Models.Service
    }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { location : location
    , route : route
    , service : Service.Models.init
    }


