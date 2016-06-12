module Routing exposing (..)


import Hop exposing (makeUrl)
import Hop.Types
import Navigation
import Route


-- SETUP


config : Hop.Types.Config Route.Route
config =
    { basePath = ""
    , hash = False
    , matchers = Route.matchers
    , notFound = Route.NotFoundRoute
    }


-- UTILS


transitionToCmd : String -> Cmd a
transitionToCmd path =
    makeUrl config path
        |> Navigation.modifyUrl
