#
# Simple HTTP proxy
#
# after http://ejz.ru/63/node-js-http-https-proxy
#
http = require 'http'
net = require 'net'
url = require 'url'

http.createServer (req, res)->
  console.log req.method, req.url
  to = url.parse req.url
  req.pipe http.request
    hostname: to.hostname
    port: to.port
    path: to.path
    method: req.method
    headers: req.headers
  .on 'response', (res2)->
    res.writeHead res2.statusCode, res2.headers
    res2.pipe res
.on 'connect', (req, sock, head)->
  console.log 'CONNECT', req.url
  headers = (text)->
    sock.write "HTTP/#{req.httpVersion} #{text}\r\n\r\n"
    headers = ->
  to = url.parse "https://" + req.url
  net.connect
    host: to.hostname
    port: to.port or 443
    ->
      headers '200 Connected'
      @write head
      @pipe sock
      .pipe @
  .on 'error', ->
    headers '500 Error'
    sock.end()
.listen 8000
