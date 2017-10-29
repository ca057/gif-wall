module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class)
import Components.Loading as Loading exposing (view)
import Components.Attributions as Attributions exposing (view)


---- FLAGS ----


type alias Flags =
    { tag : String
    , rating : String
    }



---- MODEL ----


type alias Model =
    { tag : String
    , rating : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model flags.tag flags.rating, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    Html.main_ [ class "container" ]
        [ Loading.view
        , Attributions.view
        , text model.tag
        , text model.rating
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
