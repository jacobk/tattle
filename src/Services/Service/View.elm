module Services.Service.View exposing (..)


import Html exposing (..)
import Services.Models exposing (..)
import Services.Service.Route
import Services.Service.Messages exposing (..)


type alias Context =
    { service : Service
    , route : Services.Service.Route.Route
    }


view : Context -> Html Msg
view ctx =
    text ctx.service.username
