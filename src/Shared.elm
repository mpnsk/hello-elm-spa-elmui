module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation exposing (Key)
import Debug exposing (log)
import Element exposing (..)
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route
import Url exposing (Url)



-- INIT


type alias Flags =
    ()


type alias Model =
    { url : Url
    , key : Key
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    let
        _ =
            log "x" page

        body =
            [ column [ padding 20, spacing 20, height fill ]
                [ row [ spacing 20 ]
                    [ createLink Route.Top "Home"
                    , createLink Route.NotFound "!found"
                    , createLink Route.AStaticPage "static link"
                    ]
                , column [ height fill ] page.body
                ]
            ]

        homeBody =
            [ column [ padding 20, spacing 20, height fill ]
                [ row [ spacing 20 ]
                    [ text "this is alternative" ]
                ]
            ]
    in
    { title = page.title
    , body =
        case page.title of
            "Homepage" ->
                homeBody

            _ ->
                body
    }


createLink : Route.Route -> String -> Element msg
createLink r s =
    link [ Font.color (rgb 0 0.25 0.5), Font.underline ] { url = Route.toString r, label = text s }
