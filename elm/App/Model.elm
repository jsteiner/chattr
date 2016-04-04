module App.Model where

type alias Model =
  { messages : List Message
  , pendingMessage : String
  }

type alias Message = String

initialModel : Model
initialModel =
  { messages = []
  , pendingMessage = ""
  }
