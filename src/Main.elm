module Main exposing (..)

import Http
import Json.Decode as Decode
import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class, src)
import Time exposing (Time, minute)
import Components.Loading as Loading exposing (view)
import Components.Attributions as Attributions exposing (view)


---- FLAGS ----


type alias Flags =
    { tag : String
    , rating : String
    , apiKey : String
    , refreshRate : String
    }



---- MODEL ----


type alias Config =
    { apiKey : String
    }


type alias Model =
    { tag : String
    , rating : String
    , gifUrl : String
    , refreshRate : Float
    , config : Config
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        apiKey =
            flags.apiKey

        tag =
            flags.tag

        rating =
            flags.rating

        parsedRefreshRate =
            Result.withDefault 10 (String.toFloat flags.refreshRate)

        refreshRate =
            (Time.second
                * if (parsedRefreshRate <= 0) then
                    1
                  else
                    parsedRefreshRate
            )
    in
        ( Model tag
            rating
            ""
            refreshRate
            (Config apiKey)
        , getRandomGif ( apiKey, tag, rating )
        )



---- UPDATE ----


type Msg
    = RequestGif
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestGif ->
            ( model, getRandomGif ( model.config.apiKey, model.tag, model.rating ) )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every model.refreshRate (\time -> RequestGif)



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
        , subscriptions = subscriptions
        }



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
