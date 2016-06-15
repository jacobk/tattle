module Route exposing (..)

import Hop exposing (..)
import Hop.Types exposing (Config, PathMatcher)
import Hop.Matchers exposing (..)
import Services.Route


-- MODEL


type Route
    = HomeRoute
    | ServicesRoutes Services.Route.Route
    | NotFoundRoute


-- MATCHERS


matcherHome : PathMatcher Route
matcherHome =
    match1 HomeRoute "/home"


matcherServices : PathMatcher Route
matcherServices =
    nested1 ServicesRoutes "/services" Services.Route.matchers


matchers : List (PathMatcher Route)
matchers =
    [ matcherHome
    , matcherServices
    ]


-- REVERSE


reverse : Route -> String
reverse route =
    case route of
        HomeRoute ->
            matcherToPath matcherHome []

        ServicesRoutes subRoute ->
            "ballefjongberga"
            --let
            --    parentPath = matcherToPath matcherService []
            --    subPath = Services.Route.reverse subRoute
            --in
            --    parentPath ++ subPath

        NotFoundRoute ->
            ""
