$(document).ready(function() {
  var imageHelper = new ImageHelper();
  imageHelper.bindEvents();
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
