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
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__lib_router__ = __webpack_require__(/*! ../lib/router */ 2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__lib_router___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__lib_router__);
/* eslint no-console:0 */



$(document).on('turbolinks:load', function () {
  Object(__WEBPACK_IMPORTED_MODULE_1__lib_router__["router"])();

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
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export setLocation */
/* unused harmony export getLocation */
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
/*!**************************************!*\
  !*** ./app/javascript/lib/router.js ***!
  \**************************************/
/*! dynamic exports provided */
/*! exports used: router */
/***/ (function(module, exports) {

throw new Error("Module build failed: SyntaxError: Unexpected token, expected ; (30:66)\n\n  28 |     console.log('tides', tides)\n  29 |     console.log('times', times)\n> 30 |     renderChart(type, data, times, ctx, backgroundColor, options) {\n     |                                                                   ^\n  31 |     renderChart('bar', tides, times, 'tideTable', [\"rgb(0, 128, 0)\"], tideOptions)\n  32 |     renderChart('bar', waves, times, 'waveChart', [], waveOptions)\n  33 |   }\n");

/***/ })
/******/ ]);
//# sourceMappingURL=application-d47c04efd53355cc5571.js.map