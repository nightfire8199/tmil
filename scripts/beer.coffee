ba = require('beeradvocate-api')

module.exports = (robot) ->
  robot.respond /(beer)( me)? (.*)/i, (msg) ->
    beer msg, msg.match[3]

beer = (msg, query) ->
  ba.beerSearch query, (beers) ->
    allBeers = JSON.parse(beers)
    if allBeers.length
      firstBeer = allBeers[Math.floor(Math.random() * allBeers.length)]
      ba.beerPage firstBeer.beer_url, (beer) ->
        theBeer = JSON.parse(beer)[0]
        theUrl = 'http://beeradvocate.com' + firstBeer.beer_url
        msg.send "#{theBeer.brewery_name}\n
          #{theBeer.beer_name}\n
          Style: #{theBeer.beer_style}\n
          ABV: #{theBeer.beer_abv}\n
          Rating: #{theBeer.ba_score}\n
          #{theUrl}"
    else
      msg.send "I couldn't find that one"