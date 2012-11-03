window.Snapshot.users =
  show: (data) ->

  likes: (data) ->
    new Snapshot.Views.ImagesList(el: $("#photos"), photos: data)
    $(".timeago").timeago()