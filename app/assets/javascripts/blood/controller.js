BloodForNepal.Controller = function(views) {
  var self = this;
  this.views = views;

  this.initialize = function() {
    this.map()
    this.views.activateSlider()
    this.bindAddressInput()
  };

  this.mapOptions = function(zoom, center) {
    var nepal = new google.maps.LatLng(28, 85)
    var zoom = zoom || 7
    var center = center || nepal

    return {
      zoom: zoom,
      center: center
    }
  };

  this.map = function() {
    return this.views.initialGoogleMap(this.mapOptions())
  };

  this.bindAddressInput = function() {
    var markers = [];
    var input = (document.getElementById('donor_address'))
    var searchBox = new google.maps.places.SearchBox(input);

    google.maps.event.addListener(searchBox, 'places_changed', function() {
      var places = searchBox.getPlaces();
      self.PinPointOnMap(markers, places, searchBox)
    })
  };

  this.PinPointOnMap = function(markers, places, searchBox) {
    var bounds = new google.maps.LatLngBounds();
    var map = this.map()

    for (var i = 0, place; place = places[i]; i++) {
      var marker = new google.maps.Marker({
        map: map,
        icon: '/person_pin.png',
        position: place.geometry.location,
        draggable: true,
        content: '<strong>We thing this is where you are right now.</strong>'
      });

      markers.push(marker);

      bounds.extend(place.geometry.location);
      self.views.setLatLongParams(marker.getPosition().lat(), marker.getPosition().lng())
      this.activatePinDrag(marker, searchBox)
    }

    this.mapBoundZoom(map, bounds)
  };

  this.activatePinDrag = function(marker, searchBox) {
    google.maps.event.addListener(marker, 'dragend', function(e) {
      self.views.setLatLongParams(e.latLng.lat(), e.latLng.lng())
    });
  };

  this.mapBoundZoom = function(map, bounds) {
    map.fitBounds(bounds);
    var zoom = map.getZoom();
    map.setZoom(zoom > 11 ? 11 : zoom);
  };
};
