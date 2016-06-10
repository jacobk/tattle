module Main exposing (..)

import Navigation
import Hop exposing (matchUrl)
import Hop.Types


import Messages exposing (..)
import Models exposing (..)
import View exposing (..)
import Update exposing (..)
import Routing.Config exposing (..)


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = always Sub.none }


init : (Route, Hop.Types.Location) -> (AppModel, Cmd Msg)
init (route, location) =
    (newAppModel route location, Cmd.none)


urlUpdate : (Route, Hop.Types.Location) -> AppModel -> (AppModel, Cmd Msg)
urlUpdate (route, location) model =
    let
        _ =
            Debug.log "urlUpdate location" location
    in
        ({ model | route = route, location = location }, Cmd.none)


urlParser : Navigation.Parser (Route, Hop.Types.Location)
urlParser =
    let
        _ =
            Debug.log "GIMME A PARSER!"
    in
        Navigation.makeParser (.href >> matchUrl config)
