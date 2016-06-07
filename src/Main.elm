import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import AccessToken.Add
import AccessToken.Models
import AccessToken.Messages
import AccessToken.Update
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


-- MODEL


type alias Model =
    { accessToken : AccessToken.Models.AccessToken }


init : (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)


initialModel : Model
initialModel =
    { accessToken = AccessToken.Models.init }


-- UPDATE


type Msg
    = AccessTokenMessage AccessToken.Messages.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    AccessTokenMessage msg ->
        let
            ( accessToken, cmd) =
                AccessToken.Update.update msg model.accessToken
        in
            ( { model | accessToken =  accessToken}
            , Cmd.map AccessTokenMessage cmd
            )


-- VIEW


view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ div
        [ class "row" ]
        [ div
            [ class "col-sm-6 col-sm-offset-3" ]
            [ AccessToken.Add.view model.accessToken
                |> Html.App.map AccessTokenMessage ]
        ]
    ]

