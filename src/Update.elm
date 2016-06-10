module Update exposing (..)


import Hop exposing (makeUrl)
import Navigation
import Messages exposing (..)
import Models exposing (..)
import Routing.Config
import Service.Update
import Service.Models


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
    case message of
        ServiceMessage msg ->
            let
                ( newService, cmd ) =
                    Service.Update.update msg model.newService
            in
                ( addNewServiceIfValid newService model
                , Cmd.map ServiceMessage cmd
                )

        ServiceListMessage msg ->
            (model, Cmd.none)

        ShowServiceIndex ->
            (model, makeUrl Routing.Config.config "/foobar" |> Navigation.newUrl)


addNewServiceIfValid : Service.Models.Service -> AppModel -> AppModel
addNewServiceIfValid newService model =
    case newService.status of
        Service.Models.Valid ->
            { model
                | services = newService :: model.services
                , newService = Service.Models.new
            }

        _ ->
            { model | newService = newService }