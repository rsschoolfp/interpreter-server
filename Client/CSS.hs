{-# LANGUAGE OverloadedStrings #-}

module Client.CSS
    ( layoutCss
    ) where

import           Clay
import           Data.Text.Lazy (Text)

layoutCss :: Text
layoutCss = render $ do

  element "main" ? do
    display        flex
    justifyContent center

  element "section" ? do
    display        flex
    margin         (px 10) (px 10) (px 10) (px 10)
    padding        (px 10) (px 10) (px 10) (px 10)
    flexDirection column
    width          (pct 50)
    maxWidth       (px 400)
    border         solid (px 1) black

  element ".buttons-wrapper" ? do
    display        flex
    justifyContent spaceBetween

  element "textarea" ? do
    minHeight      (px 300)
    minWidth       (px 150)
    maxWidth       (pct 100)

  element "button" ? do
    alignSelf      flexEnd
    width          (pct 45)
    height         (px 40)
    margin         (px 10) (px 0) (px 10) (px 0)
