class Snapshot.Views.ImageActions extends Backbone.View
  tagName: "div"
  className: "actions"
  events:
    "click .like-btn" : "likeToggle"

  initialize: ->
    @liked = false
    this.toggleButton(@$el.find(".like-btn")) if @options.liked
    @photo_id = @options.id

  likeToggle: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.post "/photos", {id: @photo_id}, (data) =>
      this.toggleButton($(e.currentTarget))
    .error(this.errorHandler)

  toggleButton: (target) ->
    icon = target.find("i")

    if @liked
      icon.removeClass 'icon-white'
      target.removeClass 'btn-danger'
    else
      icon.addClass 'icon-white'
      target.addClass 'btn-danger'
    @liked = !@liked

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()

  errorHandler: ->
    notification = ich.notifications_template({
      alerts: {
        type: "alert-error",
        message: "SNAP! Something broke, but we're on it."
      }
    })
    $("header").html(notification)
    $(notification).alert()