module Main exposing (..)

import Array exposing (Array)
import Maybe
import Random
import Http
import Json.Decode as Decode
import Html exposing (Html, img)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onDoubleClick)
import Time
import Components.Loading as Loading exposing (view)
import Components.Attributions as Attributions exposing (view)
import Components.Drawer as Drawer exposing (view)


---- FLAGS ----


type alias Flags =
    { tags : String
    , rating : String
    , apiKey : String
    , refreshRate : String
    }



---- MODEL ----


type alias Config =
    { apiKey : String
    }


type alias Model =
    { tags : Array String
    , rating : String
    , gifUrl : String
    , refreshRate : Float
    , config : Config
    , drawerOpen : Bool
    }


clampToMinimumOne : number -> number
clampToMinimumOne =
    clamp 1 (2 ^ 53 - 1)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        apiKey =
            flags.apiKey

        tags =
            Array.filter (not << String.isEmpty) <| Array.fromList <| String.split "," flags.tags

        rating =
            flags.rating

        refreshRate =
            Time.second * clampToMinimumOne (Result.withDefault 10 (String.toFloat flags.refreshRate))
    in
        ( Model tags rating "" refreshRate (Config apiKey) False, requestNextGif (Array.length tags) )



---- UPDATE ----


type Msg
    = RequestGif
    | PerformRequestGif Int
    | NewGif (Result Http.Error String)
    | ToggleDrawer


requestNextGif : Int -> Cmd Msg
requestNextGif upperBound =
    Random.generate PerformRequestGif <| Random.int -1 upperBound


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestGif ->
            ( model, requestNextGif (Array.length model.tags) )

        PerformRequestGif tagIndex ->
            ( model, getRandomGif ( model.config.apiKey, Maybe.withDefault "" <| Array.get tagIndex model.tags, model.rating ) )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )

        ToggleDrawer ->
            ( { model | drawerOpen = not model.drawerOpen }, Cmd.none )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every model.refreshRate (\_ -> RequestGif)



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        contentView =
            if String.isEmpty model.gifUrl then
                Loading.view
            else
                img
                    [ src model.gifUrl
                    , class "gifView"
                    ]
                    []
    in
        Html.main_ [ class "container", onDoubleClick ToggleDrawer ]
            [ contentView
            , Drawer.view
                { open = model.drawerOpen
                }
                []
                [ Attributions.view ]
            ]



---- HTTP ----


getRandomGif : ( String, String, String ) -> Cmd Msg
getRandomGif ( apiKey, tag, rating ) =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=" ++ apiKey ++ "&tag=" ++ tag ++ "&rating=" ++ rating

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
