module App.Update where

import Effects exposing (Effects)
import Signal exposing (Mailbox, mailbox)

import App.Model exposing (..)

init : (Model, Effects Action)
init =
    (initialModel, Effects.none)

type Action
  = NewMessage String
  | SendMessage String
  | MessageSent
  | UpdatePendingMessage String

sendMessageMailbox : Mailbox Message
sendMessageMailbox = mailbox ""

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NewMessage message ->
      (addMessage model message, Effects.none)
    SendMessage message ->
      (model, sendMessageToBeSent message)
    UpdatePendingMessage message ->
      ({ model | pendingMessage = message }, Effects.none)
    MessageSent ->
      ({ model | pendingMessage = "" }, Effects.none)

addMessage : Model -> Message -> Model
addMessage model message =
  { model | messages = model.messages ++ [message]}

sendMessageToBeSent : Message -> Effects Action
sendMessageToBeSent message =
  Signal.send sendMessageMailbox.address message
  |> Effects.task
  |> Effects.map (\_ -> MessageSent)
