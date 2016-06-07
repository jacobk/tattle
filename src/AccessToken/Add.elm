module AccessToken.Add exposing (view)

import AccessToken.Messages exposing (..)
import AccessToken.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )
import String

view : AccessToken -> Html Msg
view accessToken =
    div
       [ class "card"]
       [ div
           [ class "card-block" ]
           [ h4 [ class "card-subtitle text-muted"] [ text "Provide credentials"]
           ]
       , div
           [ class "card-block" ]
           [ div
               []
               [ accessTokenInput "Service username" "username" accessToken.username ChangeUsername
               , accessTokenInput "Access Token" "token" accessToken.token ChangeToken
               , saveButton accessToken
               , statusRow accessToken
               ]
           ]
       ]


accessTokenInput : String -> String -> String -> (String -> Msg) -> Html Msg
accessTokenInput labelVal idVal val msg =
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


saveButton : AccessToken -> Html Msg
saveButton accessToken =
    let
        hasFields : List String -> Bool
        hasFields =
            List.all (not << String.isEmpty)
    in
        if hasFields [accessToken.username, accessToken.token] then
            fieldset
                [ class "form-group" ]
                [ button
                    [ class "btn btn-primary btn-lg form-control"
                    , onClick SaveAccessToken ]
                    [ text "Set Credentials" ]
                ]
        else
            text ""


statusRow : AccessToken -> Html Msg
statusRow accessToken =
    case accessToken.status of
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