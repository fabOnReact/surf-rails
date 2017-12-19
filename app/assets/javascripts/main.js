$(document).on('turbolinks:load', function() {
  //console.log('turbolinks:load - ' + event.data.url);
  //console.log('the pathname is - ' + event.currentTarget.location.pathname);

  var location_path = event.currentTarget.location.pathname /*$(location).attr('pathname');*/
  
  // switch statement triggers functions based on the visited page
  switch(location_path) {
  	case '/':
  		containerStyle();
  		break;
  	case '/posts/new':
  		getLocation();
  		break;
  }

	startCarousel();

  function getLocation(){
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      alert('Geolocation is not supported by this browser.')
    }
  }

  function showPosition(position) {
    $('input[name="post[latitude]"').val(position.coords.latitude);
    $('input[name="post[longitude]"').val(position.coords.longitude);
  }

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

});


// js animation for scrolling down page with arrow button
/*$('#circleArrow').hover(function(){
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
}*/


// Understanding Turbolinks 5 events
/*
$(document).on('turbolinks:before-visit', function(){
  // switch statement triggers functions based on the visited page
  console.log('before visit - ' + event.data.url);
  console.log('the pathname is - ' + event.currentTarget.location.pathname);

  switch(event.data.url) {
  	case '/':
  	case '':
  		console.log('switch at root page');
  		containerStyle();
  		break;
  	case '/posts/new':
  		console.log('switch at posts/new');
  		getLocation();
  		break;
  }	
});
$(document).on('turbolinks:request-start', function(){
	console.log('request-start - ' + event.data.xhr);
	console.log('the pathname is - ' + event.currentTarget.location.pathname);
});*/