# Description:
#   Hubot bokete.jp script
#   http://bokete.jp/boke/から画像をランダムに表示します。
#
# Dependencies:
#   "request":""
#   "cheerio":""
#
# Configuration:
#   None
#
# Commands:
#   hubot <bokete|ぼけて> [recent|hot|popular|pickup|select|legend|Description|Commands]
#
# URLS:
#   None

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  stagearr = ["recent","hot","pickup","popular","select","legend"]
  robot.respond /(bo|ﾎﾞ|[ぼボ])(ke|[けケｹ])(te|[てテﾃ])\s*(.+)?(\s*)?$/i, (msg) ->
    if msg.match[4] in stagearr
      stage = msg.match[4]
    else
      stage = "popular"
    options =
      url: "http://bokete.jp/boke/" + "#{stage}"
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

