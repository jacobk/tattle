module AcceessToken exposing (..)

type alias Username =
    String

type alias Token =
    String

type alias AccessToken =
    { username: Username
    , token: Token
    }