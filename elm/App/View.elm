module App.View where

import Signal exposing (Address)
import Html exposing (Html, text, button, input, form, div)
import Html.Attributes exposing (value)
import Html.Events exposing (on, onWithOptions, targetValue)
import Json.Decode exposing (succeed)

import App.Model exposing (..)
import App.Update exposing (..)

view : Address Action -> Model -> Html
view address model =
  div []
    [ messages model
    , newMessageForm address model
    ]

messages : Model -> Html
messages model =
  div [] <| List.map message model.messages

message : String -> Html
message m = div [] [text m]

newMessageForm : Address Action -> Model -> Html
newMessageForm address model =
  form
    [ onWithOptions
      "submit"
      { preventDefault = True, stopPropagation = False }
      ( Json.Decode.succeed Nothing )
      (\_ -> Signal.message address <| SendMessage model.pendingMessage)
    ]
    [ input
        [ value model.pendingMessage
        , on "input" targetValue (Signal.message address << UpdatePendingMessage)
        ]
        []
    , button [] [ text "Send" ]
    ]
