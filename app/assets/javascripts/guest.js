jQuery(document).ready(function($) {

  $('#domain_search').on('input', function () {
    $.ajax({
      url: "/domains.json",
      data: {search: $(this).val()},
      dataType: 'json',
      timeout: 15000,
      beforeSend: function (jqXHR, settings) {
        $(".ajax_message").hide();
        $(".ajax_spinner").show();
        $(".ajax_loading").show();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        $(".ajax_error").show();
      },
      success: function (data, textStatus, jqXHR) {
        $(".domain_list").empty();
        if (data.length) {
          $.each(data, function (i, elem) {
            $("<li><a href=\"http://"+elem+"/\">"+elem+"</a></li>").appendTo(".domain_list");
          });
        } else {
          $(".ajax_not_found").show();
        }
      },
      complete: function (jqXHR, textStatus) {
        $(".ajax_spinner").hide();
        $(".ajax_loading").hide();
      }
    });
  });

});
