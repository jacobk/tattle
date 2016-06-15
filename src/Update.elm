module Update exposing (..)


import Messages exposing (..)
import Models exposing (..)
import Routing exposing (transitionToCmd)
import Services.Models
import Services.Components.New
import Services.Components.List


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
    let
      _ = Debug.log "AppModel" model
    in
        case Debug.log "message" message of
            ServiceNewMsg msg ->
                let
                    ( newService, cmd ) =
                        Services.Components.New.update msg model.newService
                in
                    ( addNewServiceIfValid newService model
                    , Cmd.map ServiceNewMsg cmd
                    )

            ServiceListMsg msg ->
                let
                    ( servicesMeta, cmd ) =
                        Services.Components.List.update msg model.servicesMeta
                    _ = Debug.log "servicesMeta" servicesMeta
                    _ = Debug.log "cmd" cmd
                in
                    ( { model | servicesMeta = servicesMeta }
                    , Cmd.map ServiceListMsg cmd
                    )

            ServicesMsg msg ->
                (model, Cmd.none)


addNewServiceIfValid : Services.Models.Service -> AppModel -> AppModel
addNewServiceIfValid newService model =
    case newService.status of
        Services.Models.Valid ->
            { model
                | services = newService :: model.services
                , newService = Services.Models.new
            }

        _ ->
            { model | newService = newService }
