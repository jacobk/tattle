module AccessToken.Update exposing (..)


import AccessToken.Messages exposing (Msg(..))
import AccessToken.Models exposing (..)
import AccessToken.Commands exposing (validate)


update : Msg -> AccessToken -> (AccessToken, Cmd Msg)
update msg accessToken =
  case msg of
    ChangeUsername username ->
        { accessToken | username = username } ! []

    ChangeToken token ->
        { accessToken | token = token } ! []

    SaveAccessToken ->
        { accessToken | status = Validating } ! [validate accessToken]

    TokenValidationFailed reason ->
        { accessToken | status = Invalid reason } ! []

    TokenValidationSuccess isValid ->
        let
            status = if isValid then
                Valid
            else
                Invalid "Username/Token combination invalid"
        in
            { accessToken | status = status } ! []
