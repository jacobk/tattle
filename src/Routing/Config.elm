module Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, PathMatcher)
import Hop.Matchers exposing (..)
import Models exposing (..)
import Service.Routing.Config


config : Config Route
config =
    { basePath = ""
    , hash = False
    , matchers = matchers
    , notFound = NotFoundRoute
    }


matcherHome : PathMatcher Route
matcherHome =
    match1 HomeRoute ""


matcherService : PathMatcher Route
matcherService =
    nested1 ServiceRoutes "" Service.Routing.Config.matchers


matchers : List (PathMatcher Route)
matchers =
    [matcherHome, matcherService]

