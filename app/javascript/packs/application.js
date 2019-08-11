/* eslint no-console:0 */
import { router } from  '../lib/router'

$(document).on('turbolinks:load', function() {
  router()

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

