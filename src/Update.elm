module Update exposing (..)


import Hop exposing (makeUrl)
import Navigation
import Messages exposing (..)
import Models exposing (..)
import Routing.Config
import Service.Update


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
  case message of
    ServiceMessage msg ->
        let
            ( service, cmd) =
                Service.Update.update msg model.service
        in
            ( { model | service =  service}
            , Cmd.map ServiceMessage cmd
            )

    ShowServiceIndex ->
        (model, makeUrl Routing.Config.config "/foobar" |> Navigation.newUrl)

