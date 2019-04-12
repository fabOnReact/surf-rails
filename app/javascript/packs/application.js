/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import { getLocation, setLocation } from '../lib/location'

function containerStyle(){
  var alertHeight = $('.alert').outerHeight(true);
  $('.container').css('margin-bottom', - alertHeight );
  $('.alert').addClass('carouselAlerts');
}

$(document).on('turbolinks:load', function() {
  // switch statement triggers functions based on the visited page
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
});
