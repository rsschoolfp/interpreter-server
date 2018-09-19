{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controllers.Home
    ( home
    , getParsedData
    , getEvaledData
    ) where

import           Views.Home   (homeView)
import           Web.Scotty
import           Data.Aeson   (ToJSON)
import           GHC.Generics
import           Lib          (compile, eval)
import           Parser       (runParser, expr)
import           Data.Text.Internal.Lazy

data Post = Post { input :: String, output :: String } deriving Generic

instance ToJSON Post

home :: ScottyM ()
home = get "/" homeView

getParsedData :: ScottyM()
getParsedData = get "/parse" $ do
    input <- param "input"
    json $ Post input $ parseString input

getEvaledData :: ScottyM()
getEvaledData = get "/eval" $ do
    input <- param "input"
    json $ Post input $ evalString input

parseString:: String -> String
parseString str = do
  result <- runParser expr str
  fromEither $ compile $ fst result

evalString:: String -> String
evalString str = do
  expres <- runParser expr str
  fromEither $ eval [] $ fst expres

fromEither::(Show a, Show b) => Either a b -> String
fromEither (Right a) = show a
fromEither (Left b)   = show b
