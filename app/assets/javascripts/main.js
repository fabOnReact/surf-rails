var location_path = event.currentTarget.location.pathname /*$(location).attr('pathname');*/


  startCarousel();

function getLocation(){
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert('Geolocation is not supported by this browser.')
  }
}

// function showPosition(position) {
//   $('input[name="post[latitude]"').val(position.coords.latitude);
//   $('input[name="post[longitude]"').val(position.coords.longitude);
// }

function containerStyle(){
  var alertHeight = $('.alert').outerHeight(true);
  $('.container').css('margin-bottom', - alertHeight );
  $('.alert').addClass('carouselAlerts');
}

function pauseCarouselonMobile(){
  if (window.matchMedia('(min-width: 576px)').matches){
      $('.carousel').carousel({
          interval: 2800
      });
  }
}

$(document).on('turbolinks:load', function() {
  // switch statement triggers functions based on the visited page
  switch(location_path) {
    case '/':
        containerStyle();
        break;
    case '/posts/new':
        getLocation();
        break;
  }
});
