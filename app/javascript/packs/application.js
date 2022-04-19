// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("chartkick").use(require("highcharts"))
require('jquery')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap';
import '../stylesheets/application';

$(function(){
  $('.alert, .notice').fadeOut(8000);
});

// function bindElements() {
// document.querySelectorAll('.delete').forEach(function(a) {
//   var deferred = new $.Deferred
//   debugger
//   a.addEventListener('ajax:success', function() {
//     debugger
//     var td = a.parentNode;
//     var tr = td.parentNode;
//     console.log('削除')
//     tr.style.display = 'none';
//     return deferred;
//   });
// }


$(document).on('click', '.delete', function(){
  document.addEventListener('turbolinks:load', function() {
    document.querySelectorAll('.delete').forEach(function(a) {
      a.addEventListener('ajax:success', function() {
        var td = a.parentNode;
        var tr = td.parentNode;
        console.log('削除')
        tr.style.display = 'none';
        window.location.reload();
      });
    });
  });
});
