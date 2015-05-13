BloodForNepal.Views = function() {
  this.activateSlider = function() {
    var slider = new Slider("#commute_radius", {
      ticks: [0, 5, 10, 15, 20, 25],
      ticks_labels: ['0', '5', '10', '15', '20','25'],
      ticks_snap_bounds: 30
    });
  }

  this.setLatLongParams = function(lat, long) {
    document.getElementById('latitude').value = lat
    document.getElementById('longitude').value = long
  }

  this.initialGoogleMap = function(mapOptions) {
    return new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  }

  this.updateAddressInput = function(address) {
    var el = document.getElementById('donor_address')
    el.value = address
    el.className += ' animated '
    el.className += ' pulse '

    setTimeout(function(){ el.classList.remove("pulse"); }, 1000);
  }
};
