module Components.Drawer exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


view : List (Html.Attribute msg) -> List (Html msg) -> Html msg
view attributes children =
    div (class ("drawer") :: attributes)
        ((p [] [ text "Drawer" ]) :: children)
