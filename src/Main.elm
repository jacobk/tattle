module Main exposing (..)

import Navigation
import Hop
import Hop.Types

import Messages exposing (Msg)
import Models exposing (AppModel, newAppModel)
import Route
import Routing exposing (config, transitionToCmd)
import Update exposing (..)
import View exposing (..)


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = always Sub.none }


init : (Route.Route, Hop.Types.Location) -> (AppModel, Cmd Msg)
init (route, location) =
    (newAppModel route location, Cmd.none)



urlUpdate : (Route.Route, Hop.Types.Location) -> AppModel -> (AppModel, Cmd Msg)
urlUpdate (route, location) model =
    ({ model | route = route, location = location }, Cmd.none)


urlParser : Navigation.Parser (Route.Route, Hop.Types.Location)
urlParser =
    Navigation.makeParser (.href >> Hop.matchUrl config)
