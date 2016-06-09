module Service.Update exposing (..)


import Service.Messages exposing (Msg(..))
import Service.Models exposing (..)
import Service.Commands exposing (validate)


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
