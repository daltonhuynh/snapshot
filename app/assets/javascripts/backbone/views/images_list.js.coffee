class Snapshot.Views.ImagesList extends Backbone.View
  tagName: "div"
  className: "photos"

  initialize: ->
    data = @options.photos
    this.add(photo) for photo in data
    @$el.imagesLoaded ->
      $(this).masonry({
        itemSelector: '.photo',
        columnWidth: 320
      })

  mason: ->
    @$el.imagesLoaded ->
      $(this).masonry('reload')

  add: (data) ->
    image = new Snapshot.Views.ImageView(image: data)
    @$el.prepend(image.render().$el)
    image

  enqueue: (data) ->
    @queued ?= 0
    @queued += 1
    this.add(data).hide()

  flush: ->
    @queued = 0
    $(".photo").show()
    this.mason()