module Service.List exposing (..)

import Service.Messages exposing (..)
import Service.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )


view : List (Service) -> Html Msg
view services =
    ul
        [ class "list-group list-group-flush" ]
        List.map serviceRow services


serviceRow : Service -> Html Msg
serviceRow service =
    a
        [ class "list-group-item"
        , href "#"
        , onClick ShowService service.username
        ]
        [ text service.username ]
