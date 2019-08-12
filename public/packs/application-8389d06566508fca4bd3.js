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

function getLatitude() {}

var getLocation = function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert('Geolocation is not supported by this browser.');
  }
};

function showPosition(position) {
  var coords = position.coords;
  var $lat = '<input type=\'hidden\' name=\'latitude\' id=\'latitude\' value=' + coords.latitude + '>';
  var $long = '<input type=\'hidden\' name=\'longitude\' id=\'longitude\' value=' + coords.longitude + '>';
  var $hiddenInput = $lat + $long;
  $("#new_user").append($hiddenInput);
}

/***/ })
/******/ ]);
//# sourceMappingURL=application-8389d06566508fca4bd3.js.map