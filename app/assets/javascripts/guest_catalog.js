jQuery(document).ready(function($) {

  $('#catalog').on('click', '.catalog_show_disciplines', function () {
    var container = $(this).closest('.cat_sector_disciplines');
    var sector_id = parseInt($(this).attr('data-sector-id'));
    $.ajax({
      url: "/guest/disciplines.json",
      data: {sector_id: sector_id},
      dataType: 'json',
      beforeSend: function (jqXHR, settings) {
        $(".ajax_spinner").show();
      },
      success: function (data, textStatus, jqXHR) {
        container.empty();
        $.each(data, function (i, elem) {
          $("<h3>"+elem.name+"</h3>").appendTo(container);
          $('<div class="cat_discipline_addresses"><p><a class="catalog_show_addresses" data-sector-id="'+sector_id+'" data-discipline-id="'+elem.id+'" href="/catalog/'+sector_id+'/'+elem.id+'">Показать интернет-адреса</a></p></div>').appendTo(container);
        });
        $('<p><a class="catalog_hide_disciplines" data-sector-id="'+sector_id+'" href="/catalog">Скрыть дисциплины</a></p>').appendTo(container);
      },
      complete: function (jqXHR, textStatus) {
        $(".ajax_spinner").hide();
      }
    });
    return false;
  });

  $('#catalog').on('click', '.catalog_hide_disciplines', function () {
    var container = $(this).closest('.cat_sector_disciplines');
    var sector_id = parseInt($(this).attr('data-sector-id'));
    container.empty();
    $('<p><a class="catalog_show_disciplines" data-sector-id="'+sector_id+'" href="/catalog/'+sector_id+'">Показать дисциплины</a></p>').appendTo(container);
    return false;
  });

  $('#catalog').on('click', '.catalog_show_addresses', function () {
    var container = $(this).closest('.cat_discipline_addresses');
    var sector_id = parseInt($(this).attr('data-sector-id'));
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
          $('<li><a href="'+elem.url+'">'+elem.url+'</a> (<a href="http://'+elem.domain+'/">'+elem.domain+'</a>)</li>').appendTo(list);
        });
        list.appendTo(container);
        $('<p><a class="catalog_hide_addresses" data-sector-id="'+sector_id+'" data-discipline-id="'+discipline_id+'" href="/catalog/'+sector_id+'">Скрыть интернет-адреса</a></p>').appendTo(container);
      },
      complete: function (jqXHR, textStatus) {
        $(".ajax_spinner").hide();
      }
    });
    return false;
  });

  $('#catalog').on('click', '.catalog_hide_addresses', function () {
    var container = $(this).closest('.cat_discipline_addresses');
    var sector_id = parseInt($(this).attr('data-sector-id'));
    var discipline_id = parseInt($(this).attr('data-discipline-id'));
    container.empty();
    $('<p><a class="catalog_show_addresses" data-sector-id="'+sector_id+'" data-discipline-id="'+discipline_id+'" href="/catalog/'+sector_id+'">Показать интернет-адреса</a></p>').appendTo(container);
    return false;
  });

});
