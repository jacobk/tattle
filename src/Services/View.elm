module Services.View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App

import Services.Models exposing (..)
import Services.Route exposing(Route(..))
import Services.Messages exposing (..)
import Services.Service.View
import Services.Service.Route


type alias Context =
    { services : List Service
    , route : Services.Route.Route
    }


view : Context -> Html Msg
view ctx =
    div
        [ class "container" ]
        [ pageView ctx ]


pageView : Context -> Html Msg
pageView ctx =
    case ctx.route of
        IndexRoute ->
            text "LIST OF SERVICES"

        ServiceRoutes username subRoute ->
            let
                service = ctx.services
                    |> List.filter (.username >> (==) username)
                    |> List.head
            in
                case service of
                    Nothing -> h1 [] [ text "Not Found 404 " ]
                    Just service ->
                        div
                            []
                            [ topNav service
                            , childView service subRoute
                            ]


topNav : Service -> Html Msg
topNav service =
    nav
        [ class "navbar navbar-static-top navbar-dark bg-inverse text-center" ]
        [ a
            [ class "navbar-brand" ]
            [ text service.username ]
        ]


childView : Service -> Services.Service.Route.Route -> Html Msg
childView service subRoute =
    let
        childCtx =
            { service = service
            , route = subRoute
            }
    in
        Services.Service.View.view childCtx
            |> Html.App.map ServiceMsg
