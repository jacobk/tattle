import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Html.Events exposing ( onInput, onClick )
import Http
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
    , hasValidAccessToken: Bool
    }


initialModel : Model
initialModel =
    { accessToken = AccessToken "" ""
    , isValidatingAccessToken = False
    , hasValidAccessToken = False
    }


-- UPDATE


type Msg
    = ChangeUsername Username
    | ChangeToken Token
    | SaveAccessToken
    | AccessTokenValidationFailed TokenValidationError
    | ValidAccesToken Bool


type TokenValidationError
    = Invalid
    | InvalidOther String


--updateAccessToken model prop
--    let
--        accessToken = model.accessToken
--    in
--        {}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeUsername username ->
        let
            accessToken = model.accessToken
        in
            ({model | accessToken = { accessToken | username = username }}, Cmd.none)

    ChangeToken token ->
        let
            accessToken = model.accessToken
        in
            ({model | accessToken = { accessToken | token = token }}, Cmd.none)

    SaveAccessToken ->
        (model, verifyAccessTokenTask model.accessToken)

    AccessTokenValidationFailed a ->
        ({model | hasValidAccessToken = False }, Cmd.none)

    ValidAccesToken a ->
        ({model | hasValidAccessToken = True }, Cmd.none)


verifyAccessTokenTask : AccessToken -> Cmd Msg
verifyAccessTokenTask accessToken =
    let
        url =
            -- no CORS atm
            --"https://api.mblox.com/xms/v1/" ++ accessToken.username ++ "/groups"
            "/xms/v1/" ++ accessToken.username ++ "/groups"
        authHeader = "Bearer " ++ accessToken.token
        request =
            { verb = "OPTIONS"
            , headers = [ ("Authorization", authHeader) ]
            , url = url
            , body = Http.empty
            }

        promoteError _ =
            InvalidOther "foo"

        handleVerifyTokenResp : Http.Response -> Task.Task TokenValidationError Bool
        handleVerifyTokenResp response =
            if response.status == 200 then
                Task.succeed True
            else if response.status == 401 then
                Task.fail Invalid
            else
                Task.fail (InvalidOther "bar")

    in
        Task.mapError promoteError (Http.send Http.defaultSettings request)
            `Task.andThen` handleVerifyTokenResp
            |> Task.perform AccessTokenValidationFailed ValidAccesToken


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
                    [ h3 [ class "card-title" ] [ text "Login" ]
                    , h4 [ class "card-subtitle text-muted"] [ text "Provide credentials"]
                    ]
                , div
                    [ class "card-block" ]
                    [ div
                        []
                        [ accessTokenInput "Username" "username" ChangeUsername
                        , accessTokenInput "Access Token" "token" ChangeToken
                        , saveButton model
                        , accessTokenStatus model
                        ]
                    , div
                        [ class "card card-block"]
                        [ dl
                            []
                            [ dt [ class "col-sm-3" ] [ text "Username" ]
                            , dd [ class "col-sm-6"] [ text model.accessToken.username ]
                            , dt [ class "col-sm-3"] [ text "Access Token" ]
                            , dd [ class "col-sm-6"] [ text model.accessToken.token ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


accessTokenInput : String -> String -> (String -> Msg) -> Html Msg
accessTokenInput labelVal idVal msg =
    fieldset [ class "form-group" ]
        [ label
            [ class "", for idVal ]
            [ text labelVal ]
        , input
            [ class "form-control form-control-lg"
            , id idVal
            , type' "text"
            , autocomplete False
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
                    [ text "Save" ]
                ]
        else
            text ""


accessTokenStatus model =
    if model.hasValidAccessToken then
        div
            [ class "alert alert-success" ]
            [ text "Token valid!"]
    else
        div
            [ class "alert alert-danger" ]
            [ text "Invalid access token"]
