$(document).ready(function() {
  var productDashBoard = new ProductDashBoard();
  productDashBoard.bindEvents();
});

function ProductDashBoard() {

  var productDashBoard = this;

  this.bindEvents = function() {
    $('.product-angles').on('click', '.angle', function() { productDashBoard.changeFocussedImage($(this)) });
    $('#color-avail').on('click', '.color-all', function() { productDashBoard.changeProductAngles($(this)) });
    $('.size-container').on('click', '.size-all', function() { productDashBoard.getSize($(this)) });
  }

  this.getFocussedImage = function(product_angle) {
    return ("<img src=" + product_angle.data('focussed-image') + ">")
  }

  this.changeFocussedImage = function(product_angle) {
    $('.product-in-focus').html(productDashBoard.getFocussedImage(product_angle));
  }

  this.changeProductAngles = function(product_color) {
    productDashBoard.changeFocussedImage(product_color);
    $('.angle').each(function(index) {
      var product_angle = $(this);
      product_angle.html("<img src=" + product_color.data('image' + index) + " class='small-image'>");
      product_angle.data('focussed-image', product_color.data('image-angle' + index));
    });
  }

  this.getSize = function(selected_size) {
    $('#selected-size-value').find('strong').html(selected_size.find('span').html());
    selected_size.addClass('selected').siblings().removeClass('selected');
  }
}