module Messages exposing (..)

import Service.Components.New
import Service.Components.List


type Msg
    = ServiceNewMessage Service.Components.New.Msg
    | ServiceListMessage Service.Components.List.Msg
    | ShowServiceIndex
