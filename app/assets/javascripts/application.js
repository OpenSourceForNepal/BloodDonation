//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require namespace
//= require_tree ./blood
//= require vendor/slider.js

$(document).ready(function() {
  var views = new BloodForNepal.Views()
  var controller = new BloodForNepal.Controller(views)

  controller.initialize()
})
