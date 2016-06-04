import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Html.Events exposing ( onInput )
--import Platform.Sub

-- component import example
--import Components.Hello exposing ( hello )


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


type alias Model =
    { username: Username
    , token: Token
    }


initialModel : Model
initialModel =
  Model "" ""


-- UPDATE


type Msg
    = ChangeUsername Username
    | ChangeToken Token

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeUsername username ->
        ({model | username = username}, Cmd.none)
    ChangeToken token ->
        ({model | token = token}, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ div [ class "row" ]
        [ div [ class "col-sm-6 col-sm-offset-3" ]
            [ div [ class "card"]
                [ div [ class "card-block" ]
                    [ h3 [ class "card-title" ] [ text "Login" ]
                    , h4 [ class "card-subtitle text-muted"] [ text "Provide credentials"]
                    ]
                , div [ class "card-block" ]
                    [ Html.form []
                        [ bs_input "Username" "username" ChangeUsername
                        , bs_input "Access Token" "token" ChangeToken
                        ]
                    , div [ class "card card-block"]
                        [ dl []
                            [ dt [ class "col-sm-3" ] [ text "Username" ]
                            , dd [ class "col-sm-6"] [ text model.username ]
                            , dt [ class "col-sm-3"] [ text "Access Token" ]
                            , dd [ class "col-sm-6"] [ text model.token ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


bs_input : String -> String -> (String -> Msg) -> Html Msg
bs_input labelVal idVal msg =
    fieldset [ class "form-group" ]
        [ label [ class "", for idVal ]
            [ text labelVal ]
        , input
            [ class "form-control"
            , id idVal
            , type' "text"
            , onInput msg ] []
        ]

