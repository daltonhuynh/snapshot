window.Snapshot.cities =
  index: (data) ->
    photos = data.photos
    @channels = data.channels
    @srcs = []
    for photo in photos
      html = ich.sell_image_template({
        src: photo.images.thumbnail.url,
        location: photo.city_name
      })
      $("#photo-wall").prepend(html)
      @srcs.push(html)

    # Faye
    callback = (message) =>
      city_name = message.channel.split("/")
      city_name = city_name[city_name.length - 1]
      replacement = ich.sell_image_template({
        src: message.images.thumbnail.url,
        location: city_name
      })
      random = Math.floor(Math.random()*@srcs.length)
      chosen = @srcs[random]
      @srcs[random] = replacement
      chosen.fadeOut ->
        $(this).replaceWith(replacement)
        replacement.hide().fadeIn()

    this.fayeSetup(data.faye, callback)

    # Map
    if data.cities?
      map = Snapshot.Map.init('map', {
        dragging: false,
        scrollWheelZoom: false,
        doubleClickZoom: false,
        zoomControl: false,
        attributionControl: false
      }, 999)
      map.setView(new L.LatLng(30, 10), 1)

      addMarker = (name, lat, lng, url) ->
        MyIcon = L.Icon.extend({
            iconSize: new L.Point(25, 41),
            shadowSize: new L.Point(41, 41),
        });
        icon = new MyIcon();

        marker = new L.Marker(new L.LatLng(lat, lng), {icon: icon})
        marker.on 'click', (e) ->
          window.location.href = url
        marker.on 'mouseover', (e) ->
          this.bindPopup("<b>#{name}</b>", {
            closeButton: false,
            autoPan: false
          }).openPopup()
        marker.on 'mouseout', (e) ->
          this.closePopup()
        marker
      map.addLayer(addMarker(city.name, city.lat, city.lng, city.url)) for city in data.cities

  show: (data) ->
    setInterval("Clock.updateTime()", 1000)

    # Faye
    @channels = data.channels
    callback = (message) =>
      @images.enqueue(message)
      $("#count").html("#{@images.queued}")
      $(".alert").show()
    this.fayeSetup(data.faye, callback)

    # clock
    @images = new Snapshot.Views.ImagesList(el: $("#photos"), photos: data.photos)
    $(".timeago").timeago()

    $("img[rel=tooltip]").tooltip({
      animation: false
    })

    # notifications
    notification = ich.notifications_template({
      alerts: {
        hide_close: true,
        type: "alert-info",
        message: "<a id='insert-new' href='#'><span id='count'></span> new photo(s)</a>"
      }
    })
    $("header").html(notification)
    notification.hide()
    $("#insert-new").click (e) =>
      e.stopPropagation()
      e.preventDefault()
      @images.flush()
      $(".timeago").timeago()
      notification.hide()

    # Map
    tileSet = if Clock.isNight($(".time").html()) then 999 else 998
    map = Snapshot.Map.init('city-map', {
      scrollWheelZoom: false,
      attributionControl: false
    }, tileSet)
    pos = new L.LatLng(data.city.lat, data.city.lng)
    map.setView(pos, 10)
    map.addLayer(new L.Marker(pos))

  fayeSetup: (fayeUrl, callback) ->
    faye = Snapshot.Faye.init(fayeUrl, @channels)
    for channel in Object.keys(@channels)
      sub = faye.subscribe channel, callback
      sub.errback (error) ->
        console.log error

window.Clock =
  isNight: (time) ->
    now = new Date(time)
    hour = now.getHours()
    hour >= 22 || hour < 6

  now: (time) ->
    now = new Date(time)
    now.setSeconds(now.getSeconds() + 1)
    hrs = now.getHours()
    min = now.getMinutes()
    sec = now.getSeconds()
    don = "AM"

    if hrs >= 12 then don = "PM"
    if hrs > 12 then hrs -= 12
    if hrs == 0 then hrs = 12
    if hrs < 10 then hrs = hrs
    if min < 10 then min = "0" + min
    if sec < 10 then sec = "0" + sec

    "#{now.getMonth() + 1}/#{now.getDate()}/#{now.getFullYear()} #{hrs}:#{min}:#{sec} #{don}"

  updateTime: ->
    time = $(".time").html()
    date = this.now(time)
    $(".time").html(date)