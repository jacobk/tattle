module Messages exposing (..)

import Services.Messages
import Services.Components.New
import Services.Components.List


type Msg
    = ServiceNewMsg Services.Components.New.Msg
    | ServiceListMsg Services.Components.List.Msg
    | ServicesMsg Services.Messages.Msg
