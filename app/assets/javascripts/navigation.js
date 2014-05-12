(function($) {
  $(function() {
    $('a[href=#second-level]').bind('click', function(e) {
      e.preventDefault();
      $('#second-level').addClass('current');
    });
    
    $('a[href=#third-level]').bind('click', function(e) {
      e.preventDefault();
      $('section#third-level').addClass('current');
    });

    $('grid-item > a').click(function(e) {
      e.preventDefault();
    });
  });
})(jQuery);
