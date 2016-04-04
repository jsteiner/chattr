module Main where

import StartApp
import Signal exposing (Signal)
import Effects exposing (Never)
import Task exposing (Task)

import App.Model exposing (..)
import App.Update exposing (..)
import App.View exposing (..)

main = app.html

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs =
        [ Signal.map NewMessage newMessage
        ]
    }

-- Incoming Ports

port newMessage : Signal String

-- Outgoing Ports

port sendMessage : Signal String
port sendMessage =
  sendMessageMailbox.signal

port tasks : Signal (Task Never ())
port tasks = app.tasks
