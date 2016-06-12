module Route exposing (..)

import Hop exposing (..)
import Hop.Types exposing (Config, PathMatcher)
import Hop.Matchers exposing (..)
import Service.Route


-- MODEL


type Route
    = HomeRoute
    | ServiceRoutes Service.Route.Route
    | NotFoundRoute


-- MATCHERS


matcherHome : PathMatcher Route
matcherHome =
    match1 HomeRoute ""


matcherService : PathMatcher Route
matcherService =
    nested1 ServiceRoutes "" Service.Route.matchers


matchers : List (PathMatcher Route)
matchers =
    [matcherHome, matcherService]


-- REVERSE


reverse : Route -> String
reverse route =
    case route of
        HomeRoute ->
            matcherToPath matcherHome []

        ServiceRoutes subRoute ->
            let
                parentPath = matcherToPath matcherService []
                subPath = Service.Route.reverse subRoute
            in
                parentPath ++ subPath

        NotFoundRoute ->
            ""
