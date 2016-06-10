module Service.List exposing (..)

import Service.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )


type Msg
    = Show Username


-- VIEW

view : List (Service) -> Html Msg
view services =
    case services of
        [] ->
            div
                [ class "card-block" ]
                [ text "No services added"
                ]
        _ ->
            ul
                [ class "list-group list-group-flush" ]
                (List.map serviceRow services)


serviceRow : Service -> Html Msg
serviceRow service =
    a
        [ class "list-group-item"
        , href "#"
        , onClick <| Show service.username
        ]
        [ text service.username ]
