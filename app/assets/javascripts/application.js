//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require namespace
//= require_tree ./blood
//= require vendor/slider.js
//= require vendor/jquery.mask.min.js

window.onload = (function() {
  var views = new BloodForNepal.Views()
  var controller = new BloodForNepal.Controller(views)

  controller.initialize()
})
