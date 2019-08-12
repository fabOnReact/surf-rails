/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/*!*********************************************!*\
  !*** ./app/javascript/packs/application.js ***!
  \*********************************************/
/*! no exports provided */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__lib_location__ = __webpack_require__(/*! ../lib/location */ 1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__lib_tide__ = __webpack_require__(/*! ../lib/tide */ 2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__lib_tide___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__lib_tide__);
/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb



function containerStyle() {
  var alertHeight = $('.alert').outerHeight(true);
  $('.container').css('margin-bottom', -alertHeight);
  $('.alert').addClass('carouselAlerts');
}

$(document).on('turbolinks:load', function () {
  // switch statement triggers functions based on the visited page
  var location_path = event.currentTarget.location.pathname;
  switch (location_path) {
    case '/':
      containerStyle();
      Object(__WEBPACK_IMPORTED_MODULE_0__lib_location__["b" /* setLocation */])();
      break;
    case '/posts':
    case '/users/sign_in':
    case '/users/sign_up':
      Object(__WEBPACK_IMPORTED_MODULE_0__lib_location__["a" /* getLocation */])();
      break;
  }

  if (location_path.match(/posts\/[0-9][0-9]/)) {
    var tide = $('#forecast-data').data('tide');
    console.log("tide", tide);
    var dates = $('#forecast-data').data('dates');
    var times = dates.map(function (time) {
      return new Date(time).getHours();
    });
    console.log("times", times);
    Object(__WEBPACK_IMPORTED_MODULE_1__lib_tide__["renderTideChart"])(tide, times);
  }

  // Skip cookie consent on android/ios devices
  var notAndroid = navigator.userAgent.match(/Android/) === null;
  var notIos = navigator.userAgent.match(/iPhone/) === null;

  // Trigger cookie consent
  if (notAndroid && notIos) {
    window.cookieconsent.initialise({
      palette: {
        popup: { background: "black" },
        button: { background: "#aa0000" }
      },
      position: 'top'
    });
  }
});

/***/ }),
/* 1 */
/*!****************************************!*\
  !*** ./app/javascript/lib/location.js ***!
  \****************************************/
/*! exports provided: setLocation, getLocation */
/*! exports used: getLocation, setLocation */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "b", function() { return setLocation; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return getLocation; });
var setLocation = function setLocation() {
  var latitude = sessionStorage.getItem('latitude');
  var longitude = sessionStorage.getItem('longitude');
  var url = '/posts?latitude=' + latitude + '&longitude=' + longitude;
  $("#posts_path").attr("href", url);
};

var getLocation = function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert('Geolocation is not supported by this browser.');
  }
};

function showPosition(position) {
  var coords = position.coords;
  sessionStorage.setItem('latitude', coords.latitude);
  sessionStorage.setItem('longitude', coords.longitude);
  var $lat = '<input type=\'hidden\' name=\'latitude\' id=\'latitude\' value=' + coords.latitude + '>';
  var $long = '<input type=\'hidden\' name=\'longitude\' id=\'longitude\' value=' + coords.longitude + '>';
  var $hiddenInput = $lat + $long;
  $("#new_user").append($hiddenInput);
}

/***/ }),
/* 2 */
/*!************************************!*\
  !*** ./app/javascript/lib/tide.js ***!
  \************************************/
/*! dynamic exports provided */
/*! exports used: renderTideChart */
/***/ (function(module, exports) {

throw new Error("Module build failed: SyntaxError: Unexpected token, expected , (40:16)\n\n  38 |             gridLines: { \n  39 |                 display: true\n> 40 |                 zeroLineColor: 'rgb(204, 0, 0)'\n     |                 ^\n  41 |             },\n  42 |             tickMarkLength: 1,\n  43 |         }],\n");

/***/ })
/******/ ]);
//# sourceMappingURL=application-2da1a7031fc9555743ea.js.map