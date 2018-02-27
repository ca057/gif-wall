module Components.Drawer exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


-- TODO improve passing in of className


view : String -> Html msg
view className =
    div [ class ("drawer " ++ className) ]
        [ p [] [ text "Drawer" ]
        ]
