module Services.Service.Route exposing (..)


import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)


-- MODEL


type Route
    = IndexRoute
    | SendRoute


-- MATCHERS


matcherIndex : PathMatcher Route
matcherIndex =
    match1 IndexRoute ""


matcherSendRoute : PathMatcher Route
matcherSendRoute =
    match1 SendRoute "/send"


matchers : List (PathMatcher Route)
matchers =
    [ matcherIndex
    , matcherSendRoute
    ]


-- REVERSE ROUTING


reverse : Route -> String
reverse route =
    case route of
        IndexRoute ->
            ""

        SendRoute ->
            "sendroutereverse"
