(function () {
  function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

  function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }

  function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

  (window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-dashboard-dashboard-module"], {
    /***/
    "6dU7":
    /*!*****************************************************!*\
      !*** ./src/app/views/dashboard/dashboard.module.ts ***!
      \*****************************************************/

    /*! exports provided: DashboardModule */

    /***/
    function dU7(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "DashboardModule", function () {
        return DashboardModule;
      });
      /* harmony import */


      var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! tslib */
      "mrSG");
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/core */
      "8Y7J");
      /* harmony import */


      var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/forms */
      "s7LF");
      /* harmony import */


      var ng2_charts__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ng2-charts */
      "hrfs");
      /* harmony import */


      var ngx_bootstrap_dropdown__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ngx-bootstrap/dropdown */
      "FE24");
      /* harmony import */


      var ngx_bootstrap_buttons__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ngx-bootstrap/buttons */
      "aHM3");
      /* harmony import */


      var _dashboard_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(
      /*! ./dashboard.component */
      "l70X");
      /* harmony import */


      var _dashboard_routing_module__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(
      /*! ./dashboard-routing.module */
      "jUYC");

      var DashboardModule = /*#__PURE__*/_createClass(function DashboardModule() {
        _classCallCheck(this, DashboardModule);
      });

      DashboardModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"], _dashboard_routing_module__WEBPACK_IMPORTED_MODULE_7__["DashboardRoutingModule"], ng2_charts__WEBPACK_IMPORTED_MODULE_3__["ChartsModule"], ngx_bootstrap_dropdown__WEBPACK_IMPORTED_MODULE_4__["BsDropdownModule"], ngx_bootstrap_buttons__WEBPACK_IMPORTED_MODULE_5__["ButtonsModule"].forRoot()],
        declarations: [_dashboard_component__WEBPACK_IMPORTED_MODULE_6__["DashboardComponent"]]
      })], DashboardModule);
      /***/
    },

    /***/
    "9pNJ":
    /*!*******************************************!*\
      !*** ./src/app/services/stats.service.ts ***!
      \*******************************************/

    /*! exports provided: StatsService */

    /***/
    function pNJ(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "StatsService", function () {
        return StatsService;
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

      var StatsService = /*#__PURE__*/function () {
        function StatsService(http, cookie) {
          _classCallCheck(this, StatsService);

          this.http = http;
          this.cookie = cookie;
          this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
        }

        _createClass(StatsService, [{
          key: "get_stats_gender",
          value: function get_stats_gender() {
            return this.http.get(this.baseurl + 'stats/gender', {
              observe: 'response'
            });
          }
        }, {
          key: "get_gender_age",
          value: function get_gender_age() {
            return this.http.get(this.baseurl + 'stats/age', {
              observe: 'response'
            });
          }
        }, {
          key: "get_gender_age_2",
          value: function get_gender_age_2() {
            return this.http.get(this.baseurl + 'stats/group_by_age', {
              observe: 'response'
            });
          }
        }, {
          key: "lab_name",
          value: function lab_name() {
            return this.http.get(this.baseurl + 'stats/lab_name', {
              observe: 'response'
            });
          }
        }, {
          key: "species",
          value: function species() {
            return this.http.get(this.baseurl + 'stats/species', {
              observe: 'response'
            });
          }
        }, {
          key: "molecular_test",
          value: function molecular_test() {
            return this.http.get(this.baseurl + 'stats/test', {
              observe: 'response'
            });
          }
        }, {
          key: "clear",
          value: function clear() {
            this.cookie.remove('token');
          }
        }]);

        return StatsService;
      }();

      StatsService.ctorParameters = function () {
        return [{
          type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"]
        }, {
          type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]
        }];
      };

      StatsService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
      }), Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])], StatsService);
      /***/
    },

    /***/
    "P3Bu":
    /*!************************************************************************************************!*\
      !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/dashboard/dashboard.component.html ***!
      \************************************************************************************************/

    /*! exports provided: default */

    /***/
    function P3Bu(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony default export */


      __webpack_exports__["default"] = "<div class=\"animated fadeIn\">\n  <div class=\"card-columns cols-2\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Total patients by staff medical\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"polarAreaChartData2\" [labels]=\"polarAreaChartLabels2\" [colors]=\"vv\"\n            [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n\n\n\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        laboratory stats\n\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"lab_count\" [labels]=\"lab_name\" [colors]=\"color_lab_name \"\n            [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Gender Chart by age </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [datasets]=\"barChartData2\" [labels]=\"barChartLabels2\"\n            [options]=\"barChartOptions\" [legend]=\"barChartLegend\" [chartType]=\"barChartType\"\n            (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Molecular Test stats\n        <div class=\"card-header-actions\">\n        </div>\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"doughnutChartData\" [labels]=\"doughnutChartLabels\"\n            [chartType]=\"doughnutChartType\" [colors]=\"color_test\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Species test\n        <div class=\"card-header-actions\">\n        </div>\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"doughnutChartData2\" [labels]=\"doughnutChartLabels2\"\n            [chartType]=\"doughnutChartType\" [colors]=\"color_species\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Gender Chart\n\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"gender_stats_number\" [labels]=\"gender_stats_name\"\n            [colors]=\"color_gender\" [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Age Chart\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [datasets]=\"barChartData\" [labels]=\"barChartLabels\"\n            [options]=\"barChartOptions\" [legend]=\"barChartLegend\" [chartType]=\"barChartType\"\n            (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n  </div>";
      /***/
    },

    /***/
    "aHM3":
    /*!******************************************************************************!*\
      !*** ./node_modules/ngx-bootstrap/buttons/fesm2015/ngx-bootstrap-buttons.js ***!
      \******************************************************************************/

    /*! exports provided: ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective, ButtonsModule, ɵa, ɵb, ɵc */

    /***/
    function aHM3(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ButtonCheckboxDirective", function () {
        return ButtonCheckboxDirective;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ButtonRadioDirective", function () {
        return ButtonRadioDirective;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ButtonRadioGroupDirective", function () {
        return ButtonRadioGroupDirective;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ButtonsModule", function () {
        return ButtonsModule;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ɵa", function () {
        return CHECKBOX_CONTROL_VALUE_ACCESSOR;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ɵb", function () {
        return RADIO_CONTROL_VALUE_ACCESSOR$1;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ɵc", function () {
        return RADIO_CONTROL_VALUE_ACCESSOR;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "8Y7J");
      /* harmony import */


      var _angular_forms__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/forms */
      "s7LF");
      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */
      // TODO: config: activeClass - Class to apply to the checked buttons

      /** @type {?} */


      var CHECKBOX_CONTROL_VALUE_ACCESSOR = {
        provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],

        /* tslint:disable-next-line: no-use-before-declare */
        useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
        /**
        * @return {?}
        */
        function () {
          return ButtonCheckboxDirective;
        }),
        multi: true
      };
      /**
       * Add checkbox functionality to any element
       */

      var ButtonCheckboxDirective = /*#__PURE__*/function () {
        function ButtonCheckboxDirective() {
          _classCallCheck(this, ButtonCheckboxDirective);

          /**
           * Truthy value, will be set to ngModel
           */
          this.btnCheckboxTrue = true;
          /**
           * Falsy value, will be set to ngModel
           */

          this.btnCheckboxFalse = false;
          this.state = false;
          this.onChange = Function.prototype;
          this.onTouched = Function.prototype;
        } // view -> model

        /**
         * @return {?}
         */


        _createClass(ButtonCheckboxDirective, [{
          key: "onClick",
          value: function onClick() {
            if (this.isDisabled) {
              return;
            }

            this.toggle(!this.state);
            this.onChange(this.value);
          }
          /**
           * @return {?}
           */

        }, {
          key: "ngOnInit",
          value: function ngOnInit() {
            this.toggle(this.trueValue === this.value);
          }
          /**
           * @protected
           * @return {?}
           */

        }, {
          key: "trueValue",
          get: function get() {
            return typeof this.btnCheckboxTrue !== 'undefined' ? this.btnCheckboxTrue : true;
          }
          /**
           * @protected
           * @return {?}
           */

        }, {
          key: "falseValue",
          get: function get() {
            return typeof this.btnCheckboxFalse !== 'undefined' ? this.btnCheckboxFalse : false;
          }
          /**
           * @param {?} state
           * @return {?}
           */

        }, {
          key: "toggle",
          value: function toggle(state) {
            this.state = state;
            this.value = this.state ? this.trueValue : this.falseValue;
          } // ControlValueAccessor
          // model -> view

          /**
           * @param {?} value
           * @return {?}
           */

        }, {
          key: "writeValue",
          value: function writeValue(value) {
            this.state = this.trueValue === value;
            this.value = value ? this.trueValue : this.falseValue;
          }
          /**
           * @param {?} isDisabled
           * @return {?}
           */

        }, {
          key: "setDisabledState",
          value: function setDisabledState(isDisabled) {
            this.isDisabled = isDisabled;
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnChange",
          value: function registerOnChange(fn) {
            this.onChange = fn;
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnTouched",
          value: function registerOnTouched(fn) {
            this.onTouched = fn;
          }
        }]);

        return ButtonCheckboxDirective;
      }();

      ButtonCheckboxDirective.ɵfac = function ButtonCheckboxDirective_Factory(t) {
        return new (t || ButtonCheckboxDirective)();
      };

      ButtonCheckboxDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({
        type: ButtonCheckboxDirective,
        selectors: [["", "btnCheckbox", ""]],
        hostVars: 3,
        hostBindings: function ButtonCheckboxDirective_HostBindings(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function ButtonCheckboxDirective_click_HostBindingHandler() {
              return ctx.onClick();
            });
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("aria-pressed", ctx.state);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassProp"]("active", ctx.state);
          }
        },
        inputs: {
          btnCheckboxTrue: "btnCheckboxTrue",
          btnCheckboxFalse: "btnCheckboxFalse"
        },
        features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([CHECKBOX_CONTROL_VALUE_ACCESSOR])]
      });
      ButtonCheckboxDirective.propDecorators = {
        btnCheckboxTrue: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        btnCheckboxFalse: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        state: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['class.active']
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.aria-pressed']
        }],
        onClick: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['click']
        }]
      };

      (function () {
        (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonCheckboxDirective, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
          args: [{
            selector: '[btnCheckbox]',
            providers: [CHECKBOX_CONTROL_VALUE_ACCESSOR]
          }]
        }], function () {
          return [];
        }, {
          btnCheckboxTrue: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          btnCheckboxFalse: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          state: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['class.active']
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.aria-pressed']
          }],
          // view -> model

          /**
           * @return {?}
           */
          onClick: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['click']
          }]
        });
      })();

      if (false) {}
      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */

      /** @type {?} */


      var RADIO_CONTROL_VALUE_ACCESSOR = {
        provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],

        /* tslint:disable-next-line: no-use-before-declare */
        useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
        /**
        * @return {?}
        */
        function () {
          return ButtonRadioDirective;
        }),
        multi: true
      };
      /**
       * Create radio buttons or groups of buttons.
       * A value of a selected button is bound to a variable specified via ngModel.
       */

      var ButtonRadioDirective = /*#__PURE__*/function () {
        /**
         * @param {?} el
         * @param {?} cdr
         * @param {?} renderer
         * @param {?} group
         */
        function ButtonRadioDirective(el, cdr, renderer, group) {
          _classCallCheck(this, ButtonRadioDirective);

          this.el = el;
          this.cdr = cdr;
          this.renderer = renderer;
          this.group = group;
          this.onChange = Function.prototype;
          this.onTouched = Function.prototype;
          this.role = 'radio';
          this._hasFocus = false;
        }
        /**
         * Current value of radio component or group
         * @return {?}
         */


        _createClass(ButtonRadioDirective, [{
          key: "value",
          get: function get() {
            return this.group ? this.group.value : this._value;
          }
          /**
           * @param {?} value
           * @return {?}
           */
          ,
          set: function set(value) {
            if (this.group) {
              this.group.value = value;
              return;
            }

            this._value = value;
          }
          /**
           * If `true` — radio button is disabled
           * @return {?}
           */

        }, {
          key: "disabled",
          get: function get() {
            return this._disabled;
          }
          /**
           * @param {?} disabled
           * @return {?}
           */
          ,
          set: function set(disabled) {
            this.setDisabledState(disabled);
          }
          /**
           * @return {?}
           */

        }, {
          key: "controlOrGroupDisabled",
          get: function get() {
            return this.disabled || this.group && this.group.disabled ? true : undefined;
          }
          /**
           * @return {?}
           */

        }, {
          key: "hasDisabledClass",
          get: function get() {
            // Although the radio is disabled the active radio should still stand out.
            // The disabled class will prevent this so don't add it on the active radio
            return this.controlOrGroupDisabled && !this.isActive;
          }
          /**
           * @return {?}
           */

        }, {
          key: "isActive",
          get: function get() {
            return this.btnRadio === this.value;
          }
          /**
           * @return {?}
           */

        }, {
          key: "tabindex",
          get: function get() {
            if (this.controlOrGroupDisabled) {
              // Disabled radio buttons should not receive focus
              return undefined;
            } else if (this.isActive || this.group == null) {
              return 0;
            } else {
              return -1;
            }
          }
          /**
           * @return {?}
           */

        }, {
          key: "hasFocus",
          get: function get() {
            return this._hasFocus;
          }
          /**
           * @return {?}
           */

        }, {
          key: "toggleIfAllowed",
          value: function toggleIfAllowed() {
            if (!this.canToggle()) {
              return;
            }

            this.value = this.uncheckable && this.btnRadio === this.value ? undefined : this.btnRadio;

            this._onChange(this.value);
          }
          /**
           * @param {?} event
           * @return {?}
           */

        }, {
          key: "onSpacePressed",
          value: function onSpacePressed(event) {
            this.toggleIfAllowed();
            event.preventDefault();
          }
          /**
           * @return {?}
           */

        }, {
          key: "focus",
          value: function focus() {
            this.el.nativeElement.focus();
          }
          /**
           * @return {?}
           */

        }, {
          key: "onFocus",
          value: function onFocus() {
            this._hasFocus = true;
          }
          /**
           * @return {?}
           */

        }, {
          key: "onBlur",
          value: function onBlur() {
            this._hasFocus = false;
            this.onTouched();
          }
          /**
           * @return {?}
           */

        }, {
          key: "canToggle",
          value: function canToggle() {
            return !this.controlOrGroupDisabled && (this.uncheckable || this.btnRadio !== this.value);
          }
          /**
           * @return {?}
           */

        }, {
          key: "ngOnInit",
          value: function ngOnInit() {
            this.uncheckable = typeof this.uncheckable !== 'undefined';
          }
          /**
           * @param {?} value
           * @return {?}
           */

        }, {
          key: "_onChange",
          value: function _onChange(value) {
            if (this.group) {
              this.group.value = value;
              return;
            }

            this.onTouched();
            this.onChange(value);
          } // ControlValueAccessor
          // model -> view

          /**
           * @param {?} value
           * @return {?}
           */

        }, {
          key: "writeValue",
          value: function writeValue(value) {
            this.value = value;
            this.cdr.markForCheck();
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnChange",
          value: function registerOnChange(fn) {
            this.onChange = fn;
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnTouched",
          value: function registerOnTouched(fn) {
            this.onTouched = fn;
          }
          /**
           * @param {?} disabled
           * @return {?}
           */

        }, {
          key: "setDisabledState",
          value: function setDisabledState(disabled) {
            this._disabled = disabled;

            if (disabled) {
              this.renderer.setAttribute(this.el.nativeElement, 'disabled', 'disabled');
              return;
            }

            this.renderer.removeAttribute(this.el.nativeElement, 'disabled');
          }
        }]);

        return ButtonRadioDirective;
      }();

      ButtonRadioDirective.ɵfac = function ButtonRadioDirective_Factory(t) {
        return new (t || ButtonRadioDirective)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
        /**
        * @return {?}
        */
        function () {
          return ButtonRadioGroupDirective;
        }), 8));
      };

      ButtonRadioDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({
        type: ButtonRadioDirective,
        selectors: [["", "btnRadio", ""]],
        hostVars: 8,
        hostBindings: function ButtonRadioDirective_HostBindings(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function ButtonRadioDirective_click_HostBindingHandler() {
              return ctx.toggleIfAllowed();
            })("keydown.space", function ButtonRadioDirective_keydown_space_HostBindingHandler($event) {
              return ctx.onSpacePressed($event);
            })("focus", function ButtonRadioDirective_focus_HostBindingHandler() {
              return ctx.onFocus();
            })("blur", function ButtonRadioDirective_blur_HostBindingHandler() {
              return ctx.onBlur();
            });
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("role", ctx.role)("aria-disabled", ctx.controlOrGroupDisabled)("aria-checked", ctx.isActive)("tabindex", ctx.tabindex);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassProp"]("disabled", ctx.hasDisabledClass)("active", ctx.isActive);
          }
        },
        inputs: {
          value: "value",
          disabled: "disabled",
          uncheckable: "uncheckable",
          btnRadio: "btnRadio"
        },
        features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([RADIO_CONTROL_VALUE_ACCESSOR])]
      });
      /** @nocollapse */

      ButtonRadioDirective.ctorParameters = function () {
        return [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"]
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"]
        }, {
          type: ButtonRadioGroupDirective,
          decorators: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Optional"]
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"],
            args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
            /**
            * @return {?}
            */
            function () {
              return ButtonRadioGroupDirective;
            })]
          }]
        }];
      };

      ButtonRadioDirective.propDecorators = {
        btnRadio: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        uncheckable: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        value: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        disabled: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }],
        controlOrGroupDisabled: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.aria-disabled']
        }],
        hasDisabledClass: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['class.disabled']
        }],
        isActive: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['class.active']
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.aria-checked']
        }],
        role: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.role']
        }],
        tabindex: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.tabindex']
        }],
        toggleIfAllowed: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['click']
        }],
        onSpacePressed: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['keydown.space', ['$event']]
        }],
        onFocus: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['focus']
        }],
        onBlur: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['blur']
        }]
      };

      (function () {
        (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonRadioDirective, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
          args: [{
            selector: '[btnRadio]',
            providers: [RADIO_CONTROL_VALUE_ACCESSOR]
          }]
        }], function () {
          return [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"]
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"]
          }, {
            type: ButtonRadioGroupDirective,
            decorators: [{
              type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Optional"]
            }, {
              type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"],
              args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
              /**
              * @return {?}
              */
              function () {
                return ButtonRadioGroupDirective;
              })]
            }]
          }];
        }, {
          role: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.role']
          }],
          value: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          disabled: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          controlOrGroupDisabled: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.aria-disabled']
          }],
          hasDisabledClass: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['class.disabled']
          }],
          isActive: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['class.active']
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.aria-checked']
          }],
          tabindex: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.tabindex']
          }],

          /**
           * @return {?}
           */
          toggleIfAllowed: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['click']
          }],

          /**
           * @param {?} event
           * @return {?}
           */
          onSpacePressed: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['keydown.space', ['$event']]
          }],

          /**
           * @return {?}
           */
          onFocus: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['focus']
          }],

          /**
           * @return {?}
           */
          onBlur: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['blur']
          }],
          uncheckable: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          btnRadio: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }]
        });
      })();

      if (false) {}
      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */

      /** @type {?} */


      var RADIO_CONTROL_VALUE_ACCESSOR$1 = {
        provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],

        /* tslint:disable-next-line: no-use-before-declare */
        useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
        /**
        * @return {?}
        */
        function () {
          return ButtonRadioGroupDirective;
        }),
        multi: true
      };
      /**
       * A group of radio buttons.
       * A value of a selected button is bound to a variable specified via ngModel.
       */

      var ButtonRadioGroupDirective = /*#__PURE__*/function () {
        /**
         * @param {?} cdr
         */
        function ButtonRadioGroupDirective(cdr) {
          _classCallCheck(this, ButtonRadioGroupDirective);

          this.cdr = cdr;
          this.onChange = Function.prototype;
          this.onTouched = Function.prototype;
          this.role = 'radiogroup';
        }
        /**
         * @return {?}
         */


        _createClass(ButtonRadioGroupDirective, [{
          key: "value",
          get: function get() {
            return this._value;
          }
          /**
           * @param {?} value
           * @return {?}
           */
          ,
          set: function set(value) {
            this._value = value;
            this.onChange(value);
          }
          /**
           * @return {?}
           */

        }, {
          key: "tabindex",
          get: function get() {
            if (this._disabled) {
              return null;
            } else {
              return 0;
            }
          }
          /**
           * @param {?} value
           * @return {?}
           */

        }, {
          key: "writeValue",
          value: function writeValue(value) {
            this._value = value;
            this.cdr.markForCheck();
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnChange",
          value: function registerOnChange(fn) {
            this.onChange = fn;
          }
          /**
           * @param {?} fn
           * @return {?}
           */

        }, {
          key: "registerOnTouched",
          value: function registerOnTouched(fn) {
            this.onTouched = fn;
          }
          /**
           * @param {?} disabled
           * @return {?}
           */

        }, {
          key: "setDisabledState",
          value: function setDisabledState(disabled) {
            if (this.radioButtons) {
              this._disabled = disabled;
              this.radioButtons.forEach(
              /**
              * @param {?} buttons
              * @return {?}
              */
              function (buttons) {
                buttons.setDisabledState(disabled);
              });
              this.cdr.markForCheck();
            }
          }
          /**
           * @return {?}
           */

        }, {
          key: "onFocus",
          value: function onFocus() {
            if (this._disabled) {
              return;
            }
            /** @type {?} */


            var activeRadio = this.getActiveOrFocusedRadio();

            if (activeRadio) {
              activeRadio.focus();
            } else {
              /** @type {?} */
              var firstEnabled = this.radioButtons.find(
              /**
              * @param {?} r
              * @return {?}
              */
              function (r) {
                return !r.disabled;
              });

              if (firstEnabled) {
                firstEnabled.focus();
              }
            }
          }
          /**
           * @return {?}
           */

        }, {
          key: "onBlur",
          value: function onBlur() {
            if (this.onTouched) {
              this.onTouched();
            }
          }
          /**
           * @param {?} event
           * @return {?}
           */

        }, {
          key: "selectNext",
          value: function selectNext(event) {
            this.selectInDirection('next');
            event.preventDefault();
          }
          /**
           * @param {?} event
           * @return {?}
           */

        }, {
          key: "selectPrevious",
          value: function selectPrevious(event) {
            this.selectInDirection('previous');
            event.preventDefault();
          }
          /**
           * @return {?}
           */

        }, {
          key: "disabled",
          get: function get() {
            return this._disabled;
          }
          /**
           * @private
           * @param {?} direction
           * @return {?}
           */

        }, {
          key: "selectInDirection",
          value: function selectInDirection(direction) {
            if (this._disabled) {
              return;
            }
            /**
             * @param {?} currentIndex
             * @param {?} buttonRadioDirectives
             * @return {?}
             */


            function nextIndex(currentIndex, buttonRadioDirectives) {
              /** @type {?} */
              var step = direction === 'next' ? 1 : -1;
              /** @type {?} */

              var calcIndex = (currentIndex + step) % buttonRadioDirectives.length;

              if (calcIndex < 0) {
                calcIndex = buttonRadioDirectives.length - 1;
              }

              return calcIndex;
            }
            /** @type {?} */


            var activeRadio = this.getActiveOrFocusedRadio();

            if (activeRadio) {
              /** @type {?} */
              var buttonRadioDirectives = this.radioButtons.toArray();
              /** @type {?} */

              var currentActiveIndex = buttonRadioDirectives.indexOf(activeRadio);

              for (var i = nextIndex(currentActiveIndex, buttonRadioDirectives); i !== currentActiveIndex; i = nextIndex(i, buttonRadioDirectives)) {
                if (buttonRadioDirectives[i].canToggle()) {
                  buttonRadioDirectives[i].toggleIfAllowed();
                  buttonRadioDirectives[i].focus();
                  break;
                }
              }
            }
          }
          /**
           * @private
           * @return {?}
           */

        }, {
          key: "getActiveOrFocusedRadio",
          value: function getActiveOrFocusedRadio() {
            return this.radioButtons.find(
            /**
            * @param {?} button
            * @return {?}
            */
            function (button) {
              return button.isActive;
            }) || this.radioButtons.find(
            /**
            * @param {?} button
            * @return {?}
            */
            function (button) {
              return button.hasFocus;
            });
          }
        }]);

        return ButtonRadioGroupDirective;
      }();

      ButtonRadioGroupDirective.ɵfac = function ButtonRadioGroupDirective_Factory(t) {
        return new (t || ButtonRadioGroupDirective)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]));
      };

      ButtonRadioGroupDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({
        type: ButtonRadioGroupDirective,
        selectors: [["", "btnRadioGroup", ""]],
        contentQueries: function ButtonRadioGroupDirective_ContentQueries(rf, ctx, dirIndex) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵcontentQuery"](dirIndex, ButtonRadioDirective, 0);
          }

          if (rf & 2) {
            var _t;

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵloadQuery"]()) && (ctx.radioButtons = _t);
          }
        },
        hostVars: 2,
        hostBindings: function ButtonRadioGroupDirective_HostBindings(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("focus", function ButtonRadioGroupDirective_focus_HostBindingHandler() {
              return ctx.onFocus();
            })("blur", function ButtonRadioGroupDirective_blur_HostBindingHandler() {
              return ctx.onBlur();
            })("keydown.ArrowRight", function ButtonRadioGroupDirective_keydown_ArrowRight_HostBindingHandler($event) {
              return ctx.selectNext($event);
            })("keydown.ArrowDown", function ButtonRadioGroupDirective_keydown_ArrowDown_HostBindingHandler($event) {
              return ctx.selectNext($event);
            })("keydown.ArrowLeft", function ButtonRadioGroupDirective_keydown_ArrowLeft_HostBindingHandler($event) {
              return ctx.selectPrevious($event);
            })("keydown.ArrowUp", function ButtonRadioGroupDirective_keydown_ArrowUp_HostBindingHandler($event) {
              return ctx.selectPrevious($event);
            });
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("role", ctx.role)("tabindex", ctx.tabindex);
          }
        },
        features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([RADIO_CONTROL_VALUE_ACCESSOR$1])]
      });
      /** @nocollapse */

      ButtonRadioGroupDirective.ctorParameters = function () {
        return [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]
        }];
      };

      ButtonRadioGroupDirective.propDecorators = {
        role: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.role']
        }],
        radioButtons: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ContentChildren"],
          args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
          /**
          * @return {?}
          */
          function () {
            return ButtonRadioDirective;
          })]
        }],
        tabindex: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
          args: ['attr.tabindex']
        }],
        onFocus: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['focus']
        }],
        onBlur: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['blur']
        }],
        selectNext: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['keydown.ArrowRight', ['$event']]
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['keydown.ArrowDown', ['$event']]
        }],
        selectPrevious: [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['keydown.ArrowLeft', ['$event']]
        }, {
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
          args: ['keydown.ArrowUp', ['$event']]
        }]
      };

      (function () {
        (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonRadioGroupDirective, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
          args: [{
            selector: '[btnRadioGroup]',
            providers: [RADIO_CONTROL_VALUE_ACCESSOR$1]
          }]
        }], function () {
          return [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]
          }];
        }, {
          role: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.role']
          }],
          tabindex: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.tabindex']
          }],

          /**
           * @return {?}
           */
          onFocus: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['focus']
          }],

          /**
           * @return {?}
           */
          onBlur: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['blur']
          }],

          /**
           * @param {?} event
           * @return {?}
           */
          selectNext: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['keydown.ArrowRight', ['$event']]
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['keydown.ArrowDown', ['$event']]
          }],

          /**
           * @param {?} event
           * @return {?}
           */
          selectPrevious: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['keydown.ArrowLeft', ['$event']]
          }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"],
            args: ['keydown.ArrowUp', ['$event']]
          }],
          radioButtons: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ContentChildren"],
            args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(
            /**
            * @return {?}
            */
            function () {
              return ButtonRadioDirective;
            })]
          }]
        });
      })();

      if (false) {}
      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */


      var ButtonsModule = /*#__PURE__*/function () {
        function ButtonsModule() {
          _classCallCheck(this, ButtonsModule);
        }

        _createClass(ButtonsModule, null, [{
          key: "forRoot",
          value:
          /**
           * @return {?}
           */
          function forRoot() {
            return {
              ngModule: ButtonsModule,
              providers: []
            };
          }
        }]);

        return ButtonsModule;
      }();

      ButtonsModule.ɵfac = function ButtonsModule_Factory(t) {
        return new (t || ButtonsModule)();
      };

      ButtonsModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({
        type: ButtonsModule
      });
      ButtonsModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({});

      (function () {
        (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](ButtonsModule, {
          declarations: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective],
          exports: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective]
        });
      })();

      (function () {
        (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonsModule, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
          args: [{
            declarations: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective],
            exports: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective]
          }]
        }], null, null);
      })();
      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */

      /**
       * @fileoverview added by tsickle
       * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
       */
      //# sourceMappingURL=ngx-bootstrap-buttons.js.map

      /***/

    },

    /***/
    "jUYC":
    /*!*************************************************************!*\
      !*** ./src/app/views/dashboard/dashboard-routing.module.ts ***!
      \*************************************************************/

    /*! exports provided: DashboardRoutingModule */

    /***/
    function jUYC(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "DashboardRoutingModule", function () {
        return DashboardRoutingModule;
      });
      /* harmony import */


      var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! tslib */
      "mrSG");
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/core */
      "8Y7J");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/router */
      "iInd");
      /* harmony import */


      var _dashboard_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ./dashboard.component */
      "l70X");

      var routes = [{
        path: '',
        component: _dashboard_component__WEBPACK_IMPORTED_MODULE_3__["DashboardComponent"],
        data: {
          title: 'Dashboard'
        }
      }];

      var DashboardRoutingModule = /*#__PURE__*/_createClass(function DashboardRoutingModule() {
        _classCallCheck(this, DashboardRoutingModule);
      });

      DashboardRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
      })], DashboardRoutingModule);
      /***/
    },

    /***/
    "l70X":
    /*!********************************************************!*\
      !*** ./src/app/views/dashboard/dashboard.component.ts ***!
      \********************************************************/

    /*! exports provided: DashboardComponent */

    /***/
    function l70X(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "DashboardComponent", function () {
        return DashboardComponent;
      });
      /* harmony import */


      var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! tslib */
      "mrSG");
      /* harmony import */


      var _raw_loader_dashboard_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! raw-loader!./dashboard.component.html */
      "P3Bu");
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/core */
      "8Y7J");
      /* harmony import */


      var _services_patient_service__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ../../services/patient.service */
      "7wfR");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! @angular/router */
      "iInd");
      /* harmony import */


      var _services_stats_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ../../services/stats.service */
      "9pNJ");

      var DashboardComponent = /*#__PURE__*/function () {
        function DashboardComponent(patientservice, router, statsservice) {
          _classCallCheck(this, DashboardComponent);

          this.patientservice = patientservice;
          this.router = router;
          this.statsservice = statsservice;
          this.colors = [];
          this.pieChartType = 'pie';
          this.polarAreaChartLabels2 = [];
          this.polarAreaChartData2 = [];
          this.vv = [{
            backgroundColor: []
          }];
          this.color_gender = [{
            backgroundColor: ['rgba(58, 163, 248, 0.8)', 'rgba(245, 40, 145, 0.8)']
          }];
          this.gender_stats_name = ['Male', 'Female'];
          this.gender_stats_number = [];
          this.pieChartType_gender = 'pie'; // barChart

          this.barChartOptions = {
            scaleShowVerticalLines: false,
            responsive: true,
            scales: {
              yAxes: [{
                ticks: {
                  min: 0
                }
              }]
            }
          };
          this.barChartLabels = [];
          this.barChartType = 'bar';
          this.barChartLegend = true;
          this.barChartData = [{
            data: [],
            label: 'Age',
            backgroundColor: 'rgba(40, 166, 145, 0.8)',
            hoverBackgroundColor: 'rgba(40, 166, 145, 0.8)',
            hoverBorderColor: 'rgba(40, 166, 145, 0.8)',
            borderColor: 'rgba(40, 166, 145, 0.8)'
          }];
          this.barChartLabels2 = [];
          this.barChartData2 = [{
            data: [],
            label: 'Female'
          }, {
            data: [],
            label: 'Male'
          }];
          this.color_lab_name = [{
            backgroundColor: []
          }];
          this.lab_name = [];
          this.lab_count = []; // Doughnut

          this.doughnutChartLabels = [];
          this.doughnutChartData = [];
          this.doughnutChartType = 'doughnut';
          this.color_test = [{
            backgroundColor: []
          }]; // Doughnut

          this.doughnutChartLabels2 = [];
          this.doughnutChartData2 = [];
          this.color_species = [{
            backgroundColor: []
          }];
        }

        _createClass(DashboardComponent, [{
          key: "ngOnInit",
          value: function ngOnInit() {
            this.get_stats();
            this.get_stats_gender();
            this.get_stats_age_gender();
            this.get_stats_age_gender2();
            this.get_lab_name();
            this.get_molecular_test();
            this.get_species();
          } // events

        }, {
          key: "chartClicked",
          value: function chartClicked(e) {
            console.log(e);
          }
        }, {
          key: "chartHovered",
          value: function chartHovered(e) {
            console.log(e);
          }
        }, {
          key: "get_stats",
          value: function get_stats() {
            var _this = this;

            this.patientservice.stats().subscribe(function (data) {
              _this.xx = [];
              data.body.forEach(function (element) {
                _this.splitted = element.split(",", 2);

                _this.xx.push(_this.splitted);
              });

              _this.xx.forEach(function (element) {
                _this.polarAreaChartLabels2.push(element[0]);

                _this.polarAreaChartData2.push(Number(element[1])); // this.colors.push('#'+Math.floor(Math.random()*16777215).toString(16));


                do {
                  var o = Math.round,
                      r = Math.random,
                      s = 255;
                  var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');

                _this.vv[0].backgroundColor.push(col);
              });
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this.patientservice.clear();

                _this.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_stats_gender",
          value: function get_stats_gender() {
            var _this2 = this;

            this.statsservice.get_stats_gender().subscribe(function (data) {
              _this2.gender_stats_number.push(Number(data.body.Male));

              _this2.gender_stats_number.push(Number(data.body.Female));
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this2.patientservice.clear();

                _this2.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_stats_age_gender",
          value: function get_stats_age_gender() {
            var _this3 = this;

            this.statsservice.get_gender_age().subscribe(function (data) {
              console.log(data);
              data.body.forEach(function (element) {
                _this3.barChartLabels.push(element[1]);

                _this3.barChartData[0].data.push(element[0]);
              });
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this3.patientservice.clear();

                _this3.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_stats_age_gender2",
          value: function get_stats_age_gender2() {
            var _this4 = this;

            this.statsservice.get_gender_age_2().subscribe(function (data) {
              console.log(data);
              var cc = [];
              var ll = [];
              data.body["age"].forEach(function (element) {
                _this4.barChartLabels2.push(element);
              });
              console.log("liste age ===  " + _this4.barChartLabels2);

              _this4.barChartLabels2.forEach(function (element) {
                cc.push(0);
              });

              data.body["Male"].forEach(function (element) {
                if (_this4.barChartLabels2.includes(element[1])) {
                  cc[_this4.barChartLabels2.indexOf(element[1])] = element[0];
                }
              });
              console.log(cc);

              _this4.barChartLabels2.forEach(function (element) {
                ll.push(0);
              });

              data.body["Female"].forEach(function (element) {
                if (_this4.barChartLabels2.includes(element[1])) {
                  ll[_this4.barChartLabels2.indexOf(element[1])] = element[0];
                }
              });
              console.log(ll); // this.barChartData2[2].data=n_a;

              _this4.barChartData2[0].data = ll;
              _this4.barChartData2[1].data = cc;
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this4.patientservice.clear();

                _this4.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_lab_name",
          value: function get_lab_name() {
            var _this5 = this;

            this.statsservice.lab_name().subscribe(function (data) {
              data.body.forEach(function (element) {
                _this5.lab_name.push(element[1]);

                _this5.lab_count.push(element[0]);

                do {
                  var o = Math.round,
                      r = Math.random,
                      s = 255;
                  var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');

                _this5.color_lab_name[0].backgroundColor.push(col);
              });
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this5.patientservice.clear();

                _this5.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_molecular_test",
          value: function get_molecular_test() {
            var _this6 = this;

            this.statsservice.molecular_test().subscribe(function (data) {
              data.body.forEach(function (element) {
                _this6.doughnutChartLabels.push(element[1]);

                _this6.doughnutChartData.push(element[0]);

                do {
                  var o = Math.round,
                      r = Math.random,
                      s = 255;
                  var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');

                _this6.color_test[0].backgroundColor.push(col);
              });
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this6.patientservice.clear();

                _this6.router.navigateByUrl('/login');
              }
            });
          }
        }, {
          key: "get_species",
          value: function get_species() {
            var _this7 = this;

            this.statsservice.species().subscribe(function (data) {
              data.body.forEach(function (element) {
                _this7.doughnutChartLabels2.push(element[1]);

                _this7.doughnutChartData2.push(element[0]);

                do {
                  var o = Math.round,
                      r = Math.random,
                      s = 255;
                  var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');

                _this7.color_species[0].backgroundColor.push(col);
              });
            }, function (error) {
              if (error.status == 403) {
                localStorage.clear();

                _this7.patientservice.clear();

                _this7.router.navigateByUrl('/login');
              }
            });
          }
        }]);

        return DashboardComponent;
      }();

      DashboardComponent.ctorParameters = function () {
        return [{
          type: _services_patient_service__WEBPACK_IMPORTED_MODULE_3__["PatientService"]
        }, {
          type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]
        }, {
          type: _services_stats_service__WEBPACK_IMPORTED_MODULE_5__["StatsService"]
        }];
      };

      DashboardComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Component"])({
        template: _raw_loader_dashboard_component_html__WEBPACK_IMPORTED_MODULE_1__["default"]
      }), Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_patient_service__WEBPACK_IMPORTED_MODULE_3__["PatientService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"], _services_stats_service__WEBPACK_IMPORTED_MODULE_5__["StatsService"]])], DashboardComponent);
      /***/
    }
  }]);
})();
//# sourceMappingURL=views-dashboard-dashboard-module-es5.js.map