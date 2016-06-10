module Service.Add exposing (view)

import Service.Messages exposing (..)
import Service.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )
import String

view : Service -> Html Msg
view service =
    div
        [ class "card-block" ]
        [ div
           []
           [ serviceInput "Service username" "username" service.username ChangeUsername
           , serviceInput "Access Token" "token" service.token ChangeToken
           , saveButton service
           , statusRow service
           ]
        ]


serviceInput : String -> String -> String -> (String -> Msg) -> Html Msg
serviceInput labelVal idVal val msg =
    fieldset [ class "form-group" ]
        [ label
            [ class "", for idVal ]
            [ text labelVal ]
        , input
            [ class "form-control form-control-lg"
            , id idVal
            , type' "text"
            , autocomplete False
            , value val
            , onInput msg ]
            []
        ]


saveButton : Service -> Html Msg
saveButton service =
    let
        hasFields : List String -> Bool
        hasFields =
            List.all (not << String.isEmpty)
    in
        if hasFields [service.username, service.token] then
            fieldset
                [ class "form-group" ]
                [ button
                    [ class "btn btn-primary btn-lg form-control"
                    , onClick SaveService ]
                    [ text "Add service" ]
                ]
        else
            text ""


statusRow : Service -> Html Msg
statusRow service =
    case service.status of
        Init ->
            text ""
        Validating ->
            div
                [ class "text-center"]
                [ text "Verifying credentials..."
                , spinner
                ]
        Valid ->
            div
                [ class "alert alert-success" ]
                [ text "Token valid!"]
        Invalid reason ->
            div
                [ class "alert alert-danger" ]
                [ strong [] [ text "Invalid access token:" ]
                , text <| " " ++ reason
                ]


spinner : Html Msg
spinner =
    div
        [ class "loader-inner ball-scale" ]
        [ div [] [] ]