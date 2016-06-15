module Services.Route exposing (..)


import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Services.Models exposing (..)
import Services.Service.Route


-- MODEL


type Route
    = IndexRoute
    | ServiceRoutes Username Services.Service.Route.Route


-- MATCHERS


matcherIndex : PathMatcher Route
matcherIndex =
    match1 IndexRoute ""


matcherServicesRoutes : PathMatcher Route
matcherServicesRoutes =
    nested2 ServiceRoutes "/" str Services.Service.Route.matchers


matchers : List (PathMatcher Route)
matchers =
    [ matcherIndex
    , matcherServicesRoutes
    ]


-- REVERSE ROUTING


reverse : Route -> String
reverse route =
    case route of
        IndexRoute ->
            ""

        ServiceRoutes username subRoute ->
            -- matcherToPath matcherServicesRoutes [ username ]
            "pillesnoppvägen"
