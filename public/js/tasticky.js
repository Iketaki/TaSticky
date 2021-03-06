// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var option;
    $('.sticky').draggable({
      start: function() {
        return $(this).css('opacity', '0,8');
      },
      stop: function() {
        $(this).css('opacity', '1.0');
        return $.post("/api/pos/" + ($(this).data("id")), {
          x: $(this).position().left,
          y: $(this).position().top
        }, function(data) {
          return console.log(data);
        });
      }
    });
    $('.sticky').hover(function() {
      return $(this).find('.delete-button, .done-button').fadeIn('fast');
    }, function() {
      return $(this).find('.delete-button, .done-button').fadeOut('fast');
    });
    option = {
      type: "textarea",
      action: "dblclick"
    };
    return $(".sticky").each(function() {
      var _this = this;
      $(this).find(".editable").editable(option, function(e) {
        if (e.value === "") {
          return e.target.html(e.old_value);
        } else {
          return $.post("/api/edit/" + ($(_this).data("id")), {
            body: e.value
          }, function(data) {
            return console.log(data);
          });
        }
      });
      $(this).find(".delete-button").click(function(e) {
        $(_this).fadeOut();
        return $.post("/api/delete/" + ($(_this).data("id")), function(data) {
          return console.log(data);
        });
      });
      return $(this).find(".done-button").click(function(e) {
        $(_this).toggleClass('done');
        return $.post("/api/done/" + ($(_this).data("id")), function(data) {
          return console.log(data);
        });
      });
    });
  });

}).call(this);
