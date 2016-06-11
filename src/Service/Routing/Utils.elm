module Service.Routing.Utils exposing (..)

import Hop exposing (matcherToPath)
import Service.Models exposing (..)
--import Routing.Config
import Service.Routing.Config exposing (..)


--config : Config Models.Route
--config =
--    Routing.Config.config


--reverseWithPrefix : Route -> String
--reverseWithPrefix route =
--    "/languages" ++ (reverse route)


reverse : Route -> String
reverse route =
    case route of
        ServiceIndexRoute username ->
            matcherToPath matcherServiceIndex [ username ]

        SendRoute username ->
            matcherToPath matcherSend [ username ]

        NotFoundRoute ->
            ""
