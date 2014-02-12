$(document).ready(function() {
  var colorFormHelper = new ColorFormHelper();
  colorFormHelper.bindEvents();
});

function ColorFormHelper() {
  var colorFormHelper = this;
  this.bindEvents = function() {
    // $('.product-desc').on('click', '#create-color', this.submit);
  }

  this.submitForm = function(e) {
    alert('abc')
  }
}