$(document).ready(function() {
  var productDashBoard = new ProductDashBoard();
  productDashBoard.bindEvents();

  $('#add-cart').click(function() {
    if($('.size-all.selected').length == 1)
    {
      $.ajax({
        url: $(this).data('href'),
        type: 'POST',
        data: { 'size_id': $('.size-all.selected').data('id') },
        dataType: 'json'
      }).complete(function(response) {
        response = response.responseJSON;
        $('#cart-count').text(response.cart_size)
        $('#cart-link').attr('href', '/carts/' + response.cart_id )
      });
    }
    else {
      $('#before-add').toggleClass('visibility').html('Select a size');
    }
  });
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
    this.changeFocussedImage(product_color);
    var product_angles = this.setImageAngles(product_color);
    var sizes = product_color.data('sizes');
    var product_sizes = this.setSizes(product_color, sizes);
    $('.product-angles').html(product_angles);
    $('.size-container').html(product_sizes);
    $('#selected-size-value').find('strong').html(sizes[0]);
  }

  this.setImageAngles = function(product_color) {
    var small_images = product_color.data('images');
    var medium_images = product_color.data('image-angles');
    var product_angles = [];
    for(var i = 0; i < small_images.length; i++) {
      product_angles.push($('<div/>').addClass('angle')
        .data('focussed-image', medium_images[i])
        .html("<img src=" + small_images[i] + " class='small-image'>"));
    }
    return product_angles;
  }

  this.setSizes = function(product_color, sizes) {
    var size_ids = product_color.data('size-ids');
    var product_sizes = [];
    for(var i = 0; i < size_ids.length; i++) {
      product_sizes.push($('<div/>').addClass('size-all')
        .data('id', size_ids[i])
        .html("<span>" + sizes[i] + "</span>"));
    }
    return product_sizes;
  }

  this.getSize = function(selected_size) {
    $('#selected-size-value').find('strong').html(selected_size.find('span').html());
    selected_size.addClass('selected')
      .siblings()
      .removeClass('selected');
  }
}