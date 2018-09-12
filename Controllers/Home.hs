{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controllers.Home
    ( home
    , login
    , getParsedData
    ) where

import           Views.Home   (homeView)
import           Web.Scotty   (ScottyM, get, html, json, param)
import           Data.Aeson   (ToJSON)
import           GHC.Generics
import           Lib
import           Parser

data Post = Post { input :: String, output :: String } deriving Generic

instance ToJSON Post

home :: ScottyM ()
home = get "/" homeView

login :: ScottyM ()
login = get "/login" $ html "login"

getParsedData :: ScottyM()
getParsedData = get "/parse" $ do
    input <- param "input"
    json $ Post input $ parseString input

-- post "/api/articles" $ do
--     curUser <- Auth.requireUser
--     req <- parseJsonBody ("article" .: createArticleForm)
--     result <- stopIfError articleErrorHandler $ createArticle curUser req
--     json $ ArticleWrapper result

parseString:: String -> String
parseString str = do
  result <- runParser expr str
  fromEither $ compile $ fst result

fromEither::(Show a, Show b) => Either a b -> String
fromEither (Right a) = show a
fromEither (Left b)   = show b
