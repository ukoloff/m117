#
# Simple HTTP proxy
#
os = require 'os'
cluster = require 'cluster'

if cluster.isMaster
  do cluster.fork for n in os.cpus()
  cluster
  .on 'listening', (worker, address)->
    console.log "Worker #{worker.process.pid} listening on #{address.port}"
  .on 'exit', (worker, code, signal)->
    console.log "Worker #{worker.process.pid} died!"
else
  require './proxy'
