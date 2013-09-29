$ ->
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

  option = { type: "textarea", action: "dblclick" }
  $(".sticky").each ->
    $(this).find(".editable").editable option, (e) =>
      if(e.value == "")
        e.target.html(e.old_value)
      else
        $.post "/api/edit/#{ $(this).data("id") }",
          body: e.value
        , (data) ->
          console.log data
    $(this).find(".delete-button").click (e) =>
      $(this).fadeOut()
      $.post "/api/delete/#{ $(this).data("id") }", (data) =>
        console.log data

  #$("#field").click (e) ->
  #  p = $('<p>').text('ここに内容を入力してください').addClass('editable')
  #  sticky = $('<div>').addClass('sticky').append(p).css("left", "#{e.pageX}px").css("top", "#{e.pageY}px")
  #  $(this).append(sticky)
