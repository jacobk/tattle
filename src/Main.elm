import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App
import Navigation
import Hop exposing (matchUrl, makeUrl)
import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
--import Models exposing (..)
import Service.Add
import Service.Models
import Service.Messages
import Service.Update
import Service.Routing.Config
--import Platform.Sub

-- component import example
--import Components.Hello exposing ( hello )


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = always Sub.none }
--main =
--    Html.App.program
--        { init = init
--        , view = view
--        , update = update
--        , subscriptions = always Sub.none }


-- MODEL


type Route
    = HomeRoute
    | ServiceRoutes Service.Models.Route
    | NotFoundRoute


type alias AppModel =
    { location : Location
    , route : Route
    , service : Service.Models.Service
    }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { location = location
    , route = route
    , service = Service.Models.init
    }


init : (Route, Location) -> (AppModel, Cmd Msg)
init (route, location) =
    (newAppModel route location, Cmd.none)


-- UPDATE


type Msg
    = ServiceMessage Service.Messages.Msg
    | ShowServiceIndex


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
  case message of
    ServiceMessage msg ->
        let
            ( service, cmd) =
                Service.Update.update msg model.service
        in
            ( { model | service =  service}
            , Cmd.map ServiceMessage cmd
            )

    ShowServiceIndex ->
        (model, makeUrl config "/foobar" |> Navigation.modifyUrl)


-- ROUTING


config : Config Route
config =
    { basePath = ""
    , hash = True
    , matchers = matchers
    , notFound = NotFoundRoute
    }


urlUpdate : (Route, Location) -> AppModel -> (AppModel, Cmd Msg)
urlUpdate (route, location) model =
    let
        _ =
            Debug.log "urlUpdate location" location
    in
        ({ model | route = route, location = location }, Cmd.none)


urlParser : Navigation.Parser (Route, Location)
urlParser =
    Navigation.makeParser (.href >> matchUrl config)


matcherHome : PathMatcher Route
matcherHome =
    match1 HomeRoute ""


matcherService : PathMatcher Route
matcherService =
    nested1 ServiceRoutes "" Service.Routing.Config.matchers


matchers : List (PathMatcher Route)
matchers =
    [matcherHome, matcherService]

-- VIEW


view : AppModel -> Html Msg
view model =
  div
    [ class "container" ]
    [ button
        [ onClick ShowServiceIndex ]
        [ text "ROUTE ME"]
    , pageView model
    ]


pageView : AppModel -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            div
                [ class "row" ]
                [ div
                    [ class "col-sm-6 col-sm-offset-3" ]
                    [ Service.Add.view model.service
                        |> Html.App.map ServiceMessage ]
                ]

        ServiceRoutes serviceRoute ->
            text "I'm riding yolo"

        NotFoundRoute ->
            h1 [] [ text "404"]
