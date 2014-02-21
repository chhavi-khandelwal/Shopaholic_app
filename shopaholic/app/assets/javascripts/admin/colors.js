$(document).ready(function() {
  var imageHelper = new ImageHelper();
  imageHelper.bindEvents();

  $('.color-box').on('click', '.new-btn', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).data('href'),
      dataType: 'script'
    }).complete(function(response) {
      $('#color-form').html(response.responseText);
    });
  });

  $('.admin-destroy-color').click(function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      type: 'DELETE',
      dataType: 'json'
    }).complete(function(response) {
      data = (response.responseJSON)
      if(data == undefined)
        alert('Color can not be deleted');
      else
        { $('#new_color').remove();
          $('div.alert').remove();
          $("#color_" + data.id).remove();
          $('.notice').show();
        }
    });
  });

  $('.admin-edit-color').click(function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      dataType: 'script'
    }).complete(function(response) {
      data = response.responseText
      if(data == undefined)
        alert("Can't edit the color");
      else
        { 
          $('#color-form').html(data)
        }
    });
  });
});
  
function ImageHelper() {
  var imageHelper = this;
  var imageCount = 3;

  this.bindEvents = function() {
    $('#color-form').on('click', '.add-image', imageHelper.addField);
    $('#color-form').on('click', '.remove-image', imageHelper.removeField);
  }

  this.addField = function() {
    var $link = $(this);
    var visibleImages = $('.color-table .image-field:visible');
    if (visibleImages.size() < imageCount) {
      var new_id = new Date().getTime();
      var regexp = new RegExp("new_" + $link.data('association'), "g");
      $link.parent().before($link.data('content').replace(regexp, new_id));
    };
  }

  this.removeField = function() {
    var $link = $(this);
    $link.prev("input[type='hidden']").val("1");
    $link.closest('span.image-field').hide();
  }
}
