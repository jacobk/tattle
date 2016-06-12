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


type alias ServicesMeta =
    { quickLinksIdx : Maybe Int
    }


new : Service
new =
  Service "" "" Init


newServicesMeta : ServicesMeta
newServicesMeta =
    ServicesMeta Nothing
