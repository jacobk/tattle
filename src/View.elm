module View exposing (..)


import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Route exposing (Route(..))
import Services.Components.New
import Services.Components.List
import Services.View


view : AppModel -> Html Msg
view model =
    pageView model
  --div
  --  [ class "container-fluid" ]
  --  [ pageView model
  --  ]


pageView : AppModel -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            div
              [ class "container" ]
              [ div
                    [ class "row" ]
                    [ div
                        [ class "col-sm-6 col-sm-offset-3" ]
                        [ div
                           [ class "card"]
                           [ Services.Components.New.view model.newService
                                |> Html.App.map ServiceNewMsg
                           , Services.Components.List.view model.services model.servicesMeta
                                |> Html.App.map ServiceListMsg
                           ]
                        ]
                    ]
              ]

        ServicesRoutes subRoute ->
            let
                viewModel =
                  { services = model.services
                  , route = subRoute
                  }
            in
              Services.View.view viewModel
                  |> Html.App.map ServicesMsg

        NotFoundRoute ->
            h1 [] [ text "404"]
