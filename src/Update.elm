module Update exposing (..)


import Messages exposing (..)
import Models exposing (..)
import Routing exposing (transitionToCmd)
import Service.Models
import Service.Components.New
import Service.Components.List


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
    case message of
        ServiceNewMessage msg ->
            let
                ( newService, cmd ) =
                    Service.Components.New.update msg model.newService
            in
                ( addNewServiceIfValid newService model
                , Cmd.map ServiceNewMessage cmd
                )

        ServiceListMessage msg ->
            let
                ( servicesMeta, cmd ) =
                    Service.Components.List.update msg model.servicesMeta
            in
                ( { model | servicesMeta = servicesMeta }
                , Cmd.map ServiceListMessage cmd
                )

        ShowServiceIndex ->
            (model, transitionToCmd "/foobar")


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