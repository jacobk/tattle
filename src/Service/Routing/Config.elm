module Service.Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Service.Models exposing (..)


matcherService : PathMatcher Route
matcherService =
    match2 ServiceIndexRoute "/" str


matcherServiceSend : PathMatcher Route
matcherServiceSend =
    match3 SendRoute "/" str "/send"


matchers : List (PathMatcher Route)
matchers =
    [matcherService, matcherServiceSend]
