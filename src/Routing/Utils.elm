module Routing.Utils exposing (..)


import Navigation
import Routing.Config
import Hop exposing (makeUrl)


transitionToCmd : String -> Cmd a
transitionToCmd path =
    makeUrl Routing.Config.config path
        |> Navigation.modifyUrl
