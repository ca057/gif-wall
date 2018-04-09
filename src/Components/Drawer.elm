module Components.Drawer exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


type alias Props =
    { open : Bool
    }


view : Props -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
view props attributes children =
    let
        classList =
            ("drawer "
                ++ (if props.open then
                        "drawerOpen"
                    else
                        ""
                   )
            )
    in
        div
            [ class classList
            ]
            ((p [] [ text "Drawer" ]) :: children)
