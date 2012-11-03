class Snapshot.Views.ImageView extends Backbone.View
  tagName: "div"
  className: "photo"
  events:
    "mouseenter" : "showActions"
    "mouseleave" : "hideActions"

  initialize: ->
    data = @options.image
    lowRes = data.images.low_resolution.url
    time = new Date(data.created_time * 1000)
    @id = data.id
    @liked = data.snap_like
    @args = {
      id: @id,
      src: lowRes,
      time: time.toISOString(),
      link: data.link,
      username: data.user.username,
      like: @liked
    }
    @args.text = data.caption.text if data.caption?

  showActions: (e) ->
    @actions.show()

  hideActions: (e) ->
    @actions.hide()

  render: ->
    this.setElement(ich.image_template(@args))
    @actions = new Snapshot.Views.ImageActions(el: @$el.find(".actions"), id: @id, liked: @liked)
    this

  hide: ->
    @$el.hide()