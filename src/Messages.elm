module Messages exposing (..)

import Hop.Types exposing (Location)
import Service.Messages



type Msg
    = ServiceMessage Service.Messages.Msg
    | ShowServiceIndex
