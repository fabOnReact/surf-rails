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
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
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
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/application.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/application.js":
/*!*********************************************!*\
  !*** ./app/javascript/packs/application.js ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

throw new Error("Module build failed (from ./node_modules/babel-loader/lib/index.js):\nInvariant Violation: [BABEL] /home/fabrizio/Documents/sourcecode/Rails/surfcheck/app/javascript/packs/application.js: Invalid Option: The 'useBuiltIns' option must be either\n    'false' (default) to indicate no polyfill,\n    '\"entry\"' to indicate replacing the entry polyfill, or\n    '\"usage\"' to import only used polyfills per file (While processing: \"/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/preset-env/lib/index.js\")\n    at invariant (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/invariant/invariant.js:40:15)\n    at validateUseBuiltInsOption (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/preset-env/lib/normalize-options.js:150:28)\n    at normalizeOptions (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/preset-env/lib/normalize-options.js:191:23)\n    at _default (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/preset-env/lib/index.js:109:37)\n    at /home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/helper-plugin-utils/lib/index.js:19:12\n    at loadDescriptor (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/full.js:165:14)\n    at cachedFunction (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/caching.js:33:19)\n    at loadPresetDescriptor (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/full.js:235:63)\n    at config.presets.reduce (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/full.js:77:21)\n    at Array.reduce (<anonymous>)\n    at recurseDescriptors (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/full.js:74:38)\n    at loadFullConfig (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/config/full.js:108:6)\n    at process.nextTick (/home/fabrizio/Documents/sourcecode/Rails/surfcheck/node_modules/@babel/core/lib/transform.js:28:33)\n    at processTicksAndRejections (internal/process/task_queues.js:79:9)");

/***/ })

/******/ });
//# sourceMappingURL=application-4d0f993ad138a5fcb85e.js.map