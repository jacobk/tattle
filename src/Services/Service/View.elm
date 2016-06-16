module Services.Service.View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Services.Models exposing (..)
import Services.Service.Route exposing(Route(..))
import Services.Service.Messages exposing (..)


type alias Context =
    { service : Service
    , route : Services.Service.Route.Route
    }


view : Context -> Html Msg
view ctx =
    div
        []
        [ topNav ctx.service
        , pageView ctx
        ]


pageView : Context -> Html Msg
pageView ctx =
    case ctx.route of
        IndexRoute ->
            text <| "ACCESS TOKEN: " ++ ctx.service.token

        SendRoute ->
            text "SEND"


topNav : Service -> Html Msg
topNav service =
    nav
        [ class "navbar navbar-static-top navbar-dark bg-warning text-center" ]
        [ div
            [ class "nav navbar-nav" ]
            [ a
                [ class "nav-item nav-link"
                , href "#"
                ]
                [ text "Send" ]
            , a
                [ class "nav-item nav-link"
                , href "#"
                ]
                [ text "Inbox" ]
            , a
                [ class "nav-item nav-link"
                , href "#"
                ]
                [ text "Batches" ]
            , a
                [ class "nav-item nav-link"
                , href "#"
                ]
                [ text "Schedule" ]
            , a
                [ class "nav-item nav-link"
                , href "#"
                ]
                [ text "Groups" ]
            ]
        ]
