(function($) {
  $.fn.country_select = function(settings) {
    var options =  $.extend({'region_select_id': null}, settings);

    this.each(function() {
      $(this).bind('change', function() {
        var region = $(options['region_select_id'])
        region.selectedIndex = -1;
        var country_id = $(this).val();
        $.ajax({
          url : '/regions.json?country_id=' + country_id,
          type : 'get',
          success: function(regions) {
            var html_options = $.map(regions, function(region) {
              return '<option value="' + region.id + '">' + region.name + '</option>';
            });
            html_options.unshift('<option value="">Select a Region</option>');
            var region = $(options['region_select_id'])
            region.html(html_options.join(''));
            regions.length == 0 ? region.hide() : region.show();
          }
        });
      });
    });

    return this;
  };
})(jQuery);
