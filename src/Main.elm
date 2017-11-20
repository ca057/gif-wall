module Main exposing (..)

import Http
import Json.Decode as Decode
import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class, src)
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
    , gifUrl : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model flags.tag flags.rating "", getRandomGif ( flags.tag, flags.rating ) )



---- UPDATE ----


type Msg
    = RequestGif
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestGif ->
            ( model, getRandomGif ( model.tag, model.rating ) )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        contentView =
            if String.isEmpty model.gifUrl then
                Loading.view
            else
                img [ src model.gifUrl, class "gifView" ] []
    in
        Html.main_ [ class "container" ]
            [ contentView
            , Attributions.view
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



---- HTTP ----


getRandomGif : ( String, String ) -> Cmd Msg
getRandomGif ( topic, rating ) =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic ++ "&rating=" ++ rating

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
