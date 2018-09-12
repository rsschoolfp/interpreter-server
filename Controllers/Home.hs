{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controllers.Home
    ( toMainPage
    , getParsedData
    ) where

import           Views.Home   (homeView)
import           Web.Scotty
import           Data.Aeson   (ToJSON)
import           GHC.Generics
import           Lib
import           Parser
import           Data.Text.Internal.Lazy


data Post = Post { input :: String, output :: String } deriving Generic

instance ToJSON Post

-- home :: ScottyM ()
-- home = get "/" homeView

getParsedData :: ScottyM()
getParsedData = get "/parse" $ do
    input <- param "input"
    json $ Post input $ parseString input

toMainPage :: ScottyM ()
toMainPage = get "/" $ do
    -- origin <- header "Origin"
    -- redirect $ origin ++ "/index.html"
    redirect "https://interpreter-server.herokuapp.com/index.html"
    -- redirect "http://localhost:3000/index.html"

parseString:: String -> String
parseString str = do
  result <- runParser expr str
  fromEither $ compile $ fst result

fromEither::(Show a, Show b) => Either a b -> String
fromEither (Right a) = show a
fromEither (Left b)   = show b
