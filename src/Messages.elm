module Messages exposing (..)

import Service.Messages
import Service.List


type Msg
    = ServiceMessage Service.Messages.Msg
    | ServiceListMessage Service.List.Msg
    | ShowServiceIndex
