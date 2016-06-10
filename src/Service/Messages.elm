module Service.Messages exposing (..)

import Service.Models exposing (Username, Token)

type Msg
    = ChangeUsername Username
    | ChangeToken Token
    | SaveService
    | TokenValidationFailed String
    | TokenValidationSuccess Bool
    | Show Username
