google.load("webfont", "1");

google.setOnLoadCallback(function() {
  WebFont.load({
    google: {
      families: ['Droid Serif:regular,italic,bold,bolditalic']
    }
  });
});

(function($) {

  $('#deck').livequery(function() {
    var deck = $(this);
    var cards = deck.find('.card');

    cards.each(function() {
      var card = $(this);
      var number = card.find('.number .text');
      var delta = 0;
      var requesting = false;
      var remove_link = card.find('a.remove');
      var add_link = card.find('a.add');
      var adjust_url = add_link.attr('href').replace(/\?.+$/, '');
      var attempt_to_schedule_request = function() {
        if(requesting || delta != 0) {
          setTimeout(attempt_request, 1000);
        }
      }
      var attempt_request = function() {
        if(!requesting && delta != 0) {
          var number = delta;
          delta = 0;
          requesting = true;
          $.ajax({
            url: adjust_url,
            data: {number: number},
            dataType: 'json',
            success: function() {
              requesting = false;
            }
          });
        }
        attempt_to_schedule_request();
      };
      var remove_card = function() {
        card.remove();
        // restripe table
        var class_name = 'odd';
        deck.find('.card').each(function() {
          $(this).removeClass('even').removeClass('odd').addClass(class_name);
          class_name = class_name == 'odd' ? 'even' : 'odd';
        });
      };

      remove_link.click(function() {
        delta = delta - 1;
        var next_number = parseInt(number.text()) - 1;
        if(next_number == 0) { remove_card(); }
        number.text(next_number);
        attempt_to_schedule_request();
        return false;
      });

      add_link.click(function() {
        delta = delta + 1;
        number.text(parseInt(number.text()) + 1);
        attempt_to_schedule_request();
        return false;
      });

      card.find('a.remove_all').click(function() {
        remove_card();
        $.ajax({
          url: this.href
        });
        return false;
      })
    });
  });

  $('#cards').livequery(function() {
    $('a.add').click(function() {
      $(this).parents('li').eq(0).remove();
      $.ajax({url: this.href});
      return false;
    });
  });

})(jQuery);