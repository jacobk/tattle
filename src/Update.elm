module Update exposing (..)


import Messages exposing (..)
import Models exposing (..)
import Routing exposing (transitionToCmd)
import Service.Models
import Service.Add
import Service.List


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
    case message of
        ServiceAddMessage msg ->
            let
                ( newService, cmd ) =
                    Service.Add.update msg model.newService
            in
                ( addNewServiceIfValid newService model
                , Cmd.map ServiceAddMessage cmd
                )

        ServiceListMessage msg ->
            let
                ( servicesMeta, cmd ) =
                    Service.List.update msg model.servicesMeta
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