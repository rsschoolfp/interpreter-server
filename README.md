# Lambda Calculus Interpreter Server

  ### UI:

        https://interpreter-server.herokuapp.com

  ### parser endpoint:
        https://interpreter-server.herokuapp.com/parse?input=((%CE%BB%20x%20(%CE%BB%20y%20x))%20%22Hello,%20world!%22)

### to run the project:
 - type in console `stack build`
 - wait ~10-15 mins
 - type in console `stack exec app`
### what next:
 Now you can open next links in browser:
 - `localhost:3000` - static template page(possible usage: place UI page)
 - `localhost:3000/parse` - mocked endpoint to next parser implementation(param `input` is required)
