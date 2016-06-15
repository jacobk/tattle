module Services.View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App

import Services.Models exposing (..)
import Services.Route exposing(Route(..))
import Services.Messages exposing (..)
import Services.Service.View


type alias ViewModel =
    { services : List Service
    , route : Services.Route.Route
    }


view : ViewModel -> Html Msg
view ctx =
    pageView ctx

-- view : ViewModel -> Html Msg
-- view model =
--     div
--         []
--         [ nav
--             [ class "navbar navbar-static-top navbar-dark bg-inverse" ]
--             [ a
--                 [ class "navbar-brand" ]
--                 [ strong [] [ text "{" ]
--                 , text model.service.username
--                 , strong [] [ text "}"]
--                 ]
--             ]
--         , childView model
--         ]


pageView : ViewModel -> Html Msg
pageView ctx =
    case ctx.route of
        IndexRoute ->
            text "LIST OF SERVICES"

        ServiceRoutes username subRoute ->
            let
                _ = Debug.log "Username" username
                _ = Debug.log "subRoute" subRoute
                service = ctx.services
                    |> List.filter (.username >> (==) username)
                    |> List.head
            in
                case service of
                    Nothing -> h1 [] [ text "Not Found 404 " ]
                    Just service ->
                        Services.Service.View.view
                            { service = service
                            , route = subRoute
                            }
                            |> Html.App.map ServiceMsg



childView : ViewModel -> Html Msg
childView model =
    nav
        [ class "navbar navbar-static-top navbar-light bg-faded text-center" ]
        [ a
            [ class "navbar-brand" ]
            [ text "yolo" ]
        ]
