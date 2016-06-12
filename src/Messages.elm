module Messages exposing (..)

import Service.Components.Add
import Service.Components.List


type Msg
    = ServiceAddMessage Service.Components.Add.Msg
    | ServiceListMessage Service.Components.List.Msg
    | ShowServiceIndex
