$(document).ready(function() {
  var colorFormHelper = new ColorFormHelper();
  colorFormHelper.bindEvents();

});

function ColorFormHelper() {
  var colorFormHelper = this;
  this.bindEvents = function() {
    $(document).on('click', '#color-submit', colorFormHelper.submitForm);
  }

  this.submitForm = function(e) {
    if (!($('#color-name').val().trim())) {
      e.preventDefault();
      $('#error-content').html('Name is required');
    }
    else if (!($('#color_images_attributes_0_file').val().trim())) {
      e.preventDefault();
      $('#error-content').html('Image is required');
    }
    // else if ($('.image-field .color-image').length() == 3) {
    //   e.preventDefault();
    //   $('#error-content').html('3 images required for the color');
    // }
  }
}