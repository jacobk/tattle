module View exposing (..)


import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Models exposing (..)
import Service.Add


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
                    [ Service.Add.view model.service
                        |> Html.App.map ServiceMessage ]
                ]

        ServiceRoutes serviceRoute ->
            text "I'm riding yolo"

        NotFoundRoute ->
            h1 [] [ text "404"]
