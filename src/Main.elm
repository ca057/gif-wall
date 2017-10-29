module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class)
import Components.Loading as Loading exposing (view)
import Components.Attributions as Attributions exposing (view)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



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
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
