{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controllers.Home
    ( home
    , login
    , getParsedData
    ) where

import           Views.Home   (homeView)
import           Web.Scotty   (ScottyM, get, html, json)
import           Data.Aeson   (ToJSON)
import           GHC.Generics

data Post = Post { parsedString :: String } deriving Generic

instance ToJSON Post

home :: ScottyM ()
home = get "/" homeView

login :: ScottyM ()
login = get "/login" $ html "login"

getParsedData :: ScottyM()
getParsedData = get "/parse" $ json $ Post "(x => (y => (x)))('Hello world')"
