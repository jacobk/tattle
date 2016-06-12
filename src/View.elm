module View exposing (..)


import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Models exposing (..)
import Route exposing (Route(..))
import Service.Components.New
import Service.Components.List


view : AppModel -> Html Msg
view model =
  div
    [ class "container" ]
    [ button
        [ onClick ShowServiceIndex ]
        [ text "ROUTE ME"]
    , pageView model
    ]


pageView : AppModel -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            div
                [ class "row" ]
                [ div
                    [ class "col-sm-6 col-sm-offset-3" ]
                    [ div
                       [ class "card"]
                       [ Service.Components.New.view model.newService
                            |> Html.App.map ServiceNewMessage
                       , Service.Components.List.view model.services model.servicesMeta
                            |> Html.App.map ServiceListMessage
                       ]
                    ]
                ]

        ServiceRoutes serviceRoute ->
            text "I'm riding yolo"

        NotFoundRoute ->
            h1 [] [ text "404"]
