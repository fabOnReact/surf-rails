/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import { getLocation, setLocation } from '../lib/location'
import { renderTideChart } from '../lib/tide'

function containerStyle(){
  var alertHeight = $('.alert').outerHeight(true);
  $('.container').css('margin-bottom', - alertHeight );
  $('.alert').addClass('carouselAlerts');
}

$(document).on('turbolinks:load', function() {
  var location_path = event.currentTarget.location.pathname 
  switch(location_path) {
    case '/':
        containerStyle();
        setLocation()
        break;
    case '/posts':
    case '/users/sign_in':
    case '/users/sign_up':
        getLocation();
        break;
  }

  if (location_path.match(/posts\/[0-9][0-9]/)) { 
    var tide = $('#forecast-data').data('tide')
    var dates = $('#forecast-data').data('dates')
    console.log(tide)
    var times = dates.map((time) => new Date(time).getHours())
    console.log(times)
    renderTideChart(tide, times) 
  }

  // Skip cookie consent on android/ios devices
  var notAndroid = navigator.userAgent.match(/Android/) === null
  var notIos = navigator.userAgent.match(/iPhone/) === null

  // Trigger cookie consent
  if (notAndroid && notIos) { 
    window.cookieconsent.initialise({
      palette:{
        popup: {background: "black"},
        button: {background: "#aa0000"},
      },
      position: 'top'
    });    
  }

});

