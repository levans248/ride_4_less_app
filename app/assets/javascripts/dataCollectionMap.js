function dataCollectionMap(array) {

  if(array.length < 6) {
    var map = new google.maps.Map(document.getElementById('data_collection_map'), {
        zoom:12,
        center: {lat: 37.7776793, lng: -122.4076399}, 
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
  } else {
    var map = new google.maps.Map(document.getElementById('data_collection_map'), {
        zoom:2,
        center: {lat: 17.5236873, lng: -8.481522}, 
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }); 
  }

  for(var i=0; i < array.length; i++) {
    var marker = new google.maps.Marker({
              position: {lat: array[i][0], lng: array[i][1]},
              map: map
          });
  }


}