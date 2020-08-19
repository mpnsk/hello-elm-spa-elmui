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

        myBody =
            [ column [ padding 20, spacing 20, height fill ]
                [ row [ spacing 20 ]
                    [ link [ Font.color (rgb 0 0.25 0.5), Font.underline ] { url = Route.toString Route.Top, label = text "Homepage" }
                    , link [ Font.color (rgb 0 0.25 0.5), Font.underline ] { url = Route.toString Route.NotFound, label = text "Not found" }
                    , text "this is the shared part"
                    , text (Debug.toString model)
                    ]
                , column [ height fill ] page.body
                ]
            ]

        alternativeBody =
            [ text "this is alternative" ]
    in
    { title = page.title
    , body =
        case page.title of
            "Homepage" ->
                alternativeBody

            _ ->
                myBody
    }
