module Services.Components.List exposing (..)

import Json.Decode as Json
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onWithOptions, onMouseEnter,
    onMouseLeave, defaultOptions )
import Routing exposing (transitionToCmd)
import Services.Models exposing (..)


type Msg
    = TransitionToService Username
    | ShowQuickLinks Int
    | HideQuickLinks Int


-- UPDATE


update : Msg -> ServicesMeta -> (ServicesMeta, Cmd Msg)
update msg model =
    case msg of
        TransitionToService username ->
            let
                -- path =
                --     Route.ServiceRoute username |> Route.reverse
                path = "/services/" ++ username
                _ = Debug.log "path" path
            in
                (model, transitionToCmd path)

        ShowQuickLinks idx ->
            { model | quickLinksIdx = Just idx } ! []

        HideQuickLinks idx ->
            { model | quickLinksIdx = Nothing } ! []


-- VIEW


view : List (Service) -> ServicesMeta -> Html Msg
view services model =
    case services of
        [] ->
            div
                [ class "card-block" ]
                [ text "No services added"
                ]
        _ ->
            ul
                [ class "list-group list-group-flush" ]
                ( List.indexedMap (serviceRow model) services)


serviceRow : ServicesMeta -> Int -> Service -> Html Msg
serviceRow model idx service =
    let
        options =
            { defaultOptions
            | preventDefault = True
            }
    in
        a
            [ class "list-group-item"
            , href "#"
            , onWithOptions "click" options
                <| Json.succeed
                <| TransitionToService service.username
            , onMouseEnter <| ShowQuickLinks idx
            , onMouseLeave <| HideQuickLinks idx
            ]
            [ text service.username
            , quickLinks model idx service
            ]


quickLinks : ServicesMeta -> Int -> Service -> Html Msg
quickLinks model idx service =
    case model.quickLinksIdx of
        Nothing ->
            text ""

        Just quickLinkIdx ->
            if quickLinkIdx == idx then
                nav
                    [ class "nav nav-inline pull-xs-right" ]
                    [ navLink "Send"
                    , navLink "Inbox"
                    , navLink "History"
                    , navLink "Schedule"
                    , navLink "Groups"
                    ]
            else
                text ""


navLink : String -> Html Msg
navLink label =
    a
        [ class "nav-link"
        , href "#" ]
        [ text label ]
