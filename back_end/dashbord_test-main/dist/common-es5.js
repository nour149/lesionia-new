(function () {
  function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

  function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

  function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }

  (window["webpackJsonp"] = window["webpackJsonp"] || []).push([["common"], {
    /***/
    "7wfR":
    /*!*********************************************!*\
      !*** ./src/app/services/patient.service.ts ***!
      \*********************************************/

    /*! exports provided: PatientService */

    /***/
    function wfR(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "PatientService", function () {
        return PatientService;
      });
      /* harmony import */


      var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! tslib */
      "mrSG");
      /* harmony import */


      var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/common/http */
      "IheW");
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/core */
      "8Y7J");
      /* harmony import */


      var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ngx-cookie */
      "4pnn");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ../../environments/environment */
      "AytR");

      var PatientService = /*#__PURE__*/function () {
        function PatientService(http, cookie) {
          _classCallCheck(this, PatientService);

          this.http = http;
          this.cookie = cookie;
          this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
        }

        _createClass(PatientService, [{
          key: "get_patients",
          value: function get_patients() {
            return this.http.get(this.baseurl + 'patient/all', {
              observe: 'response'
            });
          }
        }, {
          key: "stats",
          value: function stats() {
            return this.http.get(this.baseurl + 'stats/patient_by_user', {
              observe: 'response'
            });
          }
        }, {
          key: "clear",
          value: function clear() {
            this.cookie.remove('token');
          }
        }]);

        return PatientService;
      }();

      PatientService.ctorParameters = function () {
        return [{
          type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"]
        }, {
          type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]
        }];
      };

      PatientService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
      }), Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])], PatientService);
      /***/
    }
  }]);
})();
//# sourceMappingURL=common-es5.js.map