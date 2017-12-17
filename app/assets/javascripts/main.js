$(document).on('turbolinks:load', function() {
  
  var location_path = $(location).attr('pathname');
  if (location_path == '/posts/new') {
    getLocation();
  }  
  /*getLocation();*/

  function getLocation(){
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      alert('Geolocation is not supported by this browser.')
    }
  }

  function showPosition(position) {
    alert('Latitude: ' + position.coords.latitude + "Longitude: " + position.coords.longitude);
  }

});


// js animation for scrolling down page with arrow button
$('#circleArrow').hover(function(){
    $(this).effect("bounce", {times: 3}, 2000);
  });

function scrollToParagraph(target) {
  position = $(target).offset();
  top_position = parseInt(position["top"]) - 20;
  $('html, body').animate({scrollTop: top_position}, 'slow');
  height = document.getElementById("bs-example-navbar-collapse-1").style.height
  if (target == '#portfolio' && height != "1px") {
    $("#bs-example-navbar-collapse-1").css("height","1px");
  }
}

function animateLink(target) {
  target.effect("bounce", "slow");
}