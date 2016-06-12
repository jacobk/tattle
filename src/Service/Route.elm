module Service.Route exposing (..)


import Hop exposing (matcherToPath)
import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Service.Models exposing (..)


-- MODEL


type Route
    = ServiceIndexRoute Username
    | SendRoute Username
    | NotFoundRoute


-- MATCHERS


matcherServiceIndex : PathMatcher Route
matcherServiceIndex =
    match2 ServiceIndexRoute "/" str


matcherSend : PathMatcher Route
matcherSend =
    match3 SendRoute "/" str "/send"


matchers : List (PathMatcher Route)
matchers =
    [matcherServiceIndex, matcherSend]


-- REVERSE ROUTING


reverse : Route -> String
reverse route =
    case route of
        ServiceIndexRoute username ->
            matcherToPath matcherServiceIndex [ username ]

        SendRoute username ->
            matcherToPath matcherSend [ username ]

        NotFoundRoute ->
            ""
