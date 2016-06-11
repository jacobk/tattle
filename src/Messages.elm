module Messages exposing (..)

import Service.Add
import Service.List


type Msg
    = ServiceAddMessage Service.Add.Msg
    | ServiceListMessage Service.List.Msg
    | ShowServiceIndex
