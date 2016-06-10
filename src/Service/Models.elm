module Service.Models exposing (..)


type alias Username =
    String


type alias Token =
    String


type Status
    = Init
    | Validating
    | Valid
    | Invalid String


type alias Service =
    { username : Username
    , token : Token
    , status : Status
    }


new : Service
new =
  Service "" "" Init


-- ROUTING


type Route
    = ServiceIndexRoute Username
    | SendRoute Username