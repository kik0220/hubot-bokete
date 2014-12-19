# Description:
#   Hubot bokete.jp script
#   http://bokete.jp/boke/dailyから画像をランダムに表示します。
#
# Dependencies:
#   "request":""
#   "cheerio":""
#
# Configuration:
#   None
#
# Commands:
#   /(bo|ﾎﾞ|[ぼボ])(ke|[けケｹ])(te|[てテﾃ])/i
#
# URLS:
#   None

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->

  robot.respond /(bo|ﾎﾞ|[ぼボ])(ke|[けケｹ])(te|[てテﾃ])/i, (msg) ->
    options =
      url: "http://bokete.jp/boke/daily"
      timeout: 2000
      headers: {'user-agent': 'node fetcher'}
    request options, (error, response, body) ->
      $ = cheerio.load body
      hits = $('a[href^="/boke/"]')
      bokes = []
      for hit in hits
        boke = hit.attribs.href.match(/\/boke\/(\d+)/)
        if boke
          bokes.push boke[1]
      msg.send "http://ss.bokete.jp/#{msg.random(bokes)}.jpg"

