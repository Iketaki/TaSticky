$ ->
  $('.sticky').each ->
    console.log $(this).position()

  $('.sticky').draggable
    start: ->
      $(this).css('opacity', '0,8')
    stop: ->
      $(this).css('opacity', '1.0')
      $.post "/api/pos/#{ $(this).data("id") }",
        x: $(this).position().left
        y: $(this).position().top
      , (data) ->
          console.log data
