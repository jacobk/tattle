module AccessToken.Models exposing (..)


type alias Username =
    String


type alias Token =
    String


type Status
    = Init
    | Validating
    | Valid
    | Invalid String


type alias AccessToken =
    { username : Username
    , token : Token
    , status : Status
    }


init : AccessToken
init =
  AccessToken "" "" Init