module Handler.Home where

import Import
import Yesod.WebSockets

getHomeR :: Handler Html
getHomeR = do
    webSockets chatStream
    defaultLayout $ do
        setTitle "Welcome To Chattr!"
        $(widgetFile "home")

chatStream :: WebSocketsT Handler ()
chatStream = do
    App { appBroadcastChannel = writeChannel } <- getYesod
    readChannel <- atomically $ dupTChan writeChannel
    race_
        (forever $ atomically (readTChan readChannel) >>= sendTextData)
        (sourceWS $$ mapM_C (atomically . writeTChan writeChannel))
