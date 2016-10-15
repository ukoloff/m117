#
# Simple HTTP proxy
#
http = require 'http'
url = require 'url'

http.createServer (req, res)->
  console.log req.url
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
.listen 8000
