module Service.Components.Add exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )
import Http
import Task
import String


import Service.Models exposing (..)


type Msg
    = ChangeUsername Username
    | ChangeToken Token
    | SaveService
    | TokenValidationFailed String
    | TokenValidationSuccess Bool


-- UPDATE


update : Msg -> Service -> (Service, Cmd Msg)
update msg service =
  case msg of
    ChangeUsername username ->
        { service | username = username } ! []

    ChangeToken token ->
        { service | token = token } ! []

    SaveService ->
        { service | status = Validating } ! [validate service]

    TokenValidationFailed reason ->
        { service | status = Invalid reason } ! []

    TokenValidationSuccess isValid ->
        let
            status = if isValid then
                Valid
            else
                Invalid "Username/Token combination invalid"
        in
            { service | status = status } ! []


-- VIEW


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


-- COMMANDS


validateTask : Service -> Task.Task String Bool
validateTask service =
    let
        -- no CORS atm
        --"https://api.mblox.com/xms/v1/" ++ service.username ++ "/groups"
        url =
            "/xms/v1/" ++ service.username ++ "/groups"
        authHeader = "Bearer " ++ service.token
        request =
            { verb = "OPTIONS"
            , headers = [ ("Authorization", authHeader) ]
            , url = url
            , body = Http.empty
            }

        promoteError _ =
            "Request failed"

        handleVerifyTokenResp : Http.Response -> Task.Task String Bool
        handleVerifyTokenResp response =
            if response.status == 200 then
                Task.succeed True
            else if response.status == 401 then
                Task.succeed False
            else
                Task.fail "Unexpected response code"
    in
        Task.mapError promoteError (Http.send Http.defaultSettings request)
            `Task.andThen` handleVerifyTokenResp


validate : Service -> Cmd Msg
validate service =
    validateTask service
        |> Task.perform TokenValidationFailed TokenValidationSuccess

