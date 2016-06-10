module Models exposing (..)


import Hop.Types exposing (Location)
import Service.Models


type Route
    = HomeRoute
    | ServiceRoutes Service.Models.Route
    | NotFoundRoute


type alias AppModel =
    { location : Location
    , route : Route
    , services : List Service.Models.Service
    , newService : Service.Models.Service
    }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { location = location
    , route = route
    , services = []
    , newService = Service.Models.new
    }
