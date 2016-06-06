import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Html.Events exposing ( onInput, onClick )
import Http
import Ports exposing (..)
import String
import Task
--import Platform.Sub

-- component import example
--import Components.Hello exposing ( hello )


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none }






init : (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)


-- MODEL


type alias Username =
    String


type alias Token =
    String


type alias AccessToken =
    { username: Username
    , token: Token
    }


type alias Model =
    { accessToken: AccessToken
    , isValidatingAccessToken: Bool
    , hasValidAccessToken: Maybe Bool
    , tokenValidationFailureReason: Maybe String
    }


initialModel : Model
initialModel =
    { accessToken = AccessToken "" ""
    , isValidatingAccessToken = False
    , hasValidAccessToken = Nothing
    , tokenValidationFailureReason = Nothing
    }


-- UPDATE


type Msg
    = ChangeUsername Username
    | ChangeToken Token
    | SaveAccessToken
    | TokenValidationFailed String
    | TokenValidationSuccess Bool


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeUsername username ->
        let
            accessToken = model.accessToken
        in
            {model | accessToken = { accessToken | username = username }}
                ! [localStorage username]

    ChangeToken token ->
        let
            accessToken = model.accessToken
        in
            ({model | accessToken = { accessToken | token = token }}, Cmd.none)

    SaveAccessToken ->
        { model
            | isValidatingAccessToken = True
            , hasValidAccessToken = Nothing
        } ! [verifyAccessTokenTask model.accessToken]

    TokenValidationFailed reason ->
        { model
            | isValidatingAccessToken = False
            , hasValidAccessToken = Just False
            , tokenValidationFailureReason = Just reason
        } ! []

    TokenValidationSuccess isValid ->
        { model
            | isValidatingAccessToken = False
            , hasValidAccessToken = Just isValid
         } ! []


verifyAccessTokenTask : AccessToken -> Cmd Msg
verifyAccessTokenTask accessToken =
    let
        -- no CORS atm
        --"https://api.mblox.com/xms/v1/" ++ accessToken.username ++ "/groups"
        url =
            "/xms/v1/" ++ accessToken.username ++ "/groups"
        authHeader = "Bearer " ++ accessToken.token
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
            |> Task.perform TokenValidationFailed TokenValidationSuccess


-- VIEW


view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ div
        [ class "row" ]
        [ div
            [ class "col-sm-6 col-sm-offset-3" ]
            [ div
                [ class "card"]
                [ div
                    [ class "card-block" ]
                    [ h4 [ class "card-subtitle text-muted"] [ text "Provide credentials"]
                    ]
                , div
                    [ class "card-block" ]
                    [ div
                        []
                        [ accessTokenInput "Service username" "username" model.accessToken.username ChangeUsername
                        , accessTokenInput "Access Token" "token" model.accessToken.token ChangeToken
                        , saveButton model
                        , statusRow model
                        , accessTokenStatus model
                        ]
                    ]
                ]
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


saveButton : Model -> Html Msg
saveButton model =
    let
        hasFields : List String -> Bool
        hasFields =
            List.all (not << String.isEmpty)
        accessToken = model.accessToken
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


statusRow : Model -> Html Msg
statusRow model =
    if model.isValidatingAccessToken then
        div
            [ class "text-center"]
            [ text "Verifying credentials..."
            , spinner
            ]
    else
        text ""


accessTokenStatus : Model -> Html Msg
accessTokenStatus model =
    case model.hasValidAccessToken of
        Just hasValidAccessToken ->
            if hasValidAccessToken then
                div
                    [ class "alert alert-success" ]
                    [ text "Token valid!"]
            else
                let
                    defaultReason = "Username/Token combination invalid"
                    reason = Maybe.withDefault defaultReason
                        model.tokenValidationFailureReason
                in
                    div
                        [ class "alert alert-danger" ]
                        [ strong [] [ text "Invalid access token:" ]
                        , text <| " " ++ reason
                        ]
        Nothing ->
            text ""


spinner : Html Msg
spinner =
    div
        [ class "loader-inner ball-scale" ]
        [ div [] [] ]