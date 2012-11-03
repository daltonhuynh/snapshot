window.Snapshot =
  Views: {}
  Faye:
    init: (fayeUrl, channels) ->
      @channels = channels
      faye = new Faye.Client(fayeUrl, {timeout: 120})
      faye.disable("websocket")

      faye.addExtension
        incoming: (message, callback) =>
          message.data.channel = message.channel if message.data
          callback(message)
        outgoing: (message, callback) =>
          if message.channel == "/meta/subscribe"
            channel = @channels[message.subscription]
            message.ext ?= {}
            message.ext.timestamp = channel.timestamp
            message.ext.signature = channel.signature
          callback(message)
      faye
  Map:
    init: (tag, options, tile = 998) ->
      key = "REPLACE_ME"
      map = new L.Map(tag, options)
      cloudmade = new L.TileLayer("http://{s}.tile.cloudmade.com/#{key}/#{tile}/256/{z}/{x}/{y}.png", {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
        maxZoom: 18,
      })
      map.addLayer(cloudmade)

  init: (data) ->
    controller = $("body").data("controller")
    action = $("body").data("action")
    this.exec(controller, action, data)

  exec: (controller, action, data = null) ->
    Snapshot[controller][action](data)


