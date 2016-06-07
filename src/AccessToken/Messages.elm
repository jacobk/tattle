module AccessToken.Messages exposing (..)

import AccessToken.Models exposing (Username, Token)

type Msg
    = ChangeUsername Username
    | ChangeToken Token
    | SaveAccessToken
    | TokenValidationFailed String
    | TokenValidationSuccess Bool
