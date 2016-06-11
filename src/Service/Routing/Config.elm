module Service.Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Service.Models exposing (..)


matcherServiceIndex : PathMatcher Route
matcherServiceIndex =
    match2 ServiceIndexRoute "/" str


matcherSend : PathMatcher Route
matcherSend =
    match3 SendRoute "/" str "/send"


matchers : List (PathMatcher Route)
matchers =
    [matcherServiceIndex, matcherSend]
