module AcceessToken exposing (..)

type alias Username =
    String

type alias Token =
    String

type alias Service =
    { username: Username
    , token: Token
    }