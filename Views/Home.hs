{-# LANGUAGE OverloadedStrings #-}

module Views.Home (homeView) where

import           Client.CSS                  (layoutCss)
import           Data.Monoid                 (mempty)
import           Data.Text.Lazy              (toStrict)
import           Prelude                     hiding (div, head, id)
import           Text.Blaze.Html             (Html, toHtml)
import           Text.Blaze.Html5            (Html, a, body, button,
                                              textarea, main, section,
                                              dataAttribute, div, docTypeHtml,
                                              form, h1, h2, head, input, li,
                                              link, meta, p, script, style,
                                              title, ul, (!))
import           Text.Blaze.Html5.Attributes (charset, class_, content, href,
                                              httpEquiv, id, media, name,
                                              placeholder, rel, src, type_)
import           Views.Utils                 (blaze, pet)
import           Web.Scotty                  (ActionM)

layout :: Html -> Html -> Html
layout t b = docTypeHtml $ do
           pet "<!--[if lt IE 7]>      <html class='no-js lt-ie9 lt-ie8 lt-ie7'> <![endif]-->"
           pet "<!--[if IE 7]>         <html class='no-js lt-ie9 lt-ie8'/> <![endif]-->"
           pet "<!--[if IE 8]>         <html class='no-js lt-ie9'> <![endif]-->"
           pet "<!--[if gt IE 8]><!--> <html class='no-js'> <!--<![endif]-->"
           head $ do
             title t
             meta ! charset "utf-8"
             meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge,chrome=1"
             meta ! name "description" ! content "Inspire Text"
             meta ! name "viewport" ! content "width=device-width"
             link ! href "//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" ! rel  "stylesheet" ! media "screen"
             style $ pet $ toStrict layoutCss
           body $ do
             b
             script ! src "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" $ mempty
             script ! src "//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" $ mempty
             script "const textarea=document.querySelector('textarea');const evalButton=document.querySelector('.eval-button');const parseButton=document.querySelector('.parse-button');const p=document.querySelector('p');const handleSubmit=action=>e=>fetch(location.origin+'/'+action+'?input='+textarea.value).then(data=>data.json()).then(res=>{p.innerHTML=res.output;}).catch(err=>{p.innerHTML=err;});parseButton.addEventListener('click',handleSubmit('parse'));evalButton.addEventListener('click',handleSubmit('eval'));"

homeView :: ActionM ()
homeView = blaze $ layout "home" $ do
             main $ do
               section $ do
                 h2 "source:"
                 textarea "((λ x (λ y x)) \"Hello, world!\")"
                 div ! class_ "buttons-wrapper" $ do
                   button "Eval"  ! class_ "eval-button"
                   button "Parse" ! class_ "parse-button"
               section $ do
                 h2 "parsed:"
                 p ""
