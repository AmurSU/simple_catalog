jQuery(document).ready(function($) {

  $('#catalog').on('click', '.catalog_show_addresses', function () {
    var container = $(this).closest('.cat_discipline_addresses');
    var discipline_id = parseInt($(this).attr('data-discipline-id'));
    $.ajax({
      url: "/guest/addresses.json",
      data: {discipline_id: discipline_id},
      dataType: 'json',
      beforeSend: function (jqXHR, settings) {
        $(".ajax_spinner").show();
      },
      success: function (data, textStatus, jqXHR) {
        container.empty();
        var list = $("<ul>");
        $.each(data, function (i, elem) {
          $('<li><a href="'+elem.normalized_url+'">'+elem.url+'</a> (<a href="http://'+elem.normalized_domain+'/">'+elem.domain+'</a>)</li>').appendTo(list);
        });
        list.appendTo(container);
        $('<p><a class="catalog_hide_addresses" data-discipline-id="'+discipline_id+'" href="/catalog">Скрыть интернет-адреса</a></p>').appendTo(container);
      },
      complete: function (jqXHR, textStatus) {
        $(".ajax_spinner").hide();
      }
    });
    return false;
  });

  $('#catalog').on('click', '.catalog_hide_addresses', function () {
    var container = $(this).closest('.cat_discipline_addresses');
    var discipline_id = parseInt($(this).attr('data-discipline-id'));
    container.empty();
    $('<p><a class="catalog_show_addresses" data-discipline-id="'+discipline_id+'" href="/catalog/'+discipline_id+'">Показать интернет-адреса</a></p>').appendTo(container);
    return false;
  });

  // Searching in catalog
  $('#catalog_search').on('input', function () {
    $.ajax({
      url: "/catalog.js",
      data: {search: $(this).val()},
      dataType: 'script',
      timeout: 15000,
      beforeSend: function (jqXHR, settings) {
        $(".ajax_message").hide();
        $(".ajax_spinner").show();
        $(".ajax_loading").show();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        $(".ajax_error").show();
      },
      complete: function (jqXHR, textStatus) {
        $(".ajax_spinner").hide();
        $(".ajax_loading").hide();
      }
    });
  });

});
