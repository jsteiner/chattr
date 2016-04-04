module Handler.Home where

import Import
import Yesod.WebSockets

getHomeR :: Handler Html
getHomeR = do
    webSockets chatApp
    defaultLayout $ do
        setTitle "Welcome To Chattr!"
        $(widgetFile "home")

chatApp :: WebSocketsT Handler ()
chatApp = do
    app <- getYesod
    let writeChannel = appBroadcastChannel app
    readChannel <- atomically $ dupTChan writeChannel
    race_
        (forever $ atomically (readTChan readChannel) >>= sendTextData)
        (sourceWS $$ mapM_C (atomically . writeTChan writeChannel))
