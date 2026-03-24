(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-dashboard-dashboard-module"],{

/***/ "6dU7":
/*!*****************************************************!*\
  !*** ./src/app/views/dashboard/dashboard.module.ts ***!
  \*****************************************************/
/*! exports provided: DashboardModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DashboardModule", function() { return DashboardModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var ng2_charts__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ng2-charts */ "hrfs");
/* harmony import */ var ngx_bootstrap_dropdown__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ngx-bootstrap/dropdown */ "FE24");
/* harmony import */ var ngx_bootstrap_buttons__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ngx-bootstrap/buttons */ "aHM3");
/* harmony import */ var _dashboard_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./dashboard.component */ "l70X");
/* harmony import */ var _dashboard_routing_module__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ./dashboard-routing.module */ "jUYC");








let DashboardModule = class DashboardModule {
};
DashboardModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"],
            _dashboard_routing_module__WEBPACK_IMPORTED_MODULE_7__["DashboardRoutingModule"],
            ng2_charts__WEBPACK_IMPORTED_MODULE_3__["ChartsModule"],
            ngx_bootstrap_dropdown__WEBPACK_IMPORTED_MODULE_4__["BsDropdownModule"],
            ngx_bootstrap_buttons__WEBPACK_IMPORTED_MODULE_5__["ButtonsModule"].forRoot()
        ],
        declarations: [_dashboard_component__WEBPACK_IMPORTED_MODULE_6__["DashboardComponent"]]
    })
], DashboardModule);



/***/ }),

/***/ "9pNJ":
/*!*******************************************!*\
  !*** ./src/app/services/stats.service.ts ***!
  \*******************************************/
/*! exports provided: StatsService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "StatsService", function() { return StatsService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let StatsService = class StatsService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_stats_gender() {
        return this.http.get(this.baseurl + 'stats/gender', { observe: 'response' });
    }
    get_gender_age() {
        return this.http.get(this.baseurl + 'stats/age', { observe: 'response' });
    }
    get_gender_age_2() {
        return this.http.get(this.baseurl + 'stats/group_by_age', { observe: 'response' });
    }
    lab_name() {
        return this.http.get(this.baseurl + 'stats/lab_name', { observe: 'response' });
    }
    species() {
        return this.http.get(this.baseurl + 'stats/species', { observe: 'response' });
    }
    molecular_test() {
        return this.http.get(this.baseurl + 'stats/test', { observe: 'response' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
StatsService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
StatsService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], StatsService);



/***/ }),

/***/ "P3Bu":
/*!************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/dashboard/dashboard.component.html ***!
  \************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<div class=\"animated fadeIn\">\n  <div class=\"card-columns cols-2\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Total patients by staff medical\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"polarAreaChartData2\" [labels]=\"polarAreaChartLabels2\" [colors]=\"vv\"\n            [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n\n\n\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        laboratory stats\n\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"lab_count\" [labels]=\"lab_name\" [colors]=\"color_lab_name \"\n            [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Gender Chart by age </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [datasets]=\"barChartData2\" [labels]=\"barChartLabels2\"\n            [options]=\"barChartOptions\" [legend]=\"barChartLegend\" [chartType]=\"barChartType\"\n            (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Molecular Test stats\n        <div class=\"card-header-actions\">\n        </div>\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"doughnutChartData\" [labels]=\"doughnutChartLabels\"\n            [chartType]=\"doughnutChartType\" [colors]=\"color_test\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Species test\n        <div class=\"card-header-actions\">\n        </div>\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"doughnutChartData2\" [labels]=\"doughnutChartLabels2\"\n            [chartType]=\"doughnutChartType\" [colors]=\"color_species\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Gender Chart\n\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [data]=\"gender_stats_number\" [labels]=\"gender_stats_name\"\n            [colors]=\"color_gender\" [chartType]=\"pieChartType\" (chartHover)=\"chartHovered($event)\"\n            (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n\n    <div class=\"card\">\n      <div class=\"card-header\">\n        Age Chart\n      </div>\n      <div class=\"card-body\">\n        <div class=\"chart-wrapper\">\n          <canvas baseChart class=\"chart\" [datasets]=\"barChartData\" [labels]=\"barChartLabels\"\n            [options]=\"barChartOptions\" [legend]=\"barChartLegend\" [chartType]=\"barChartType\"\n            (chartHover)=\"chartHovered($event)\" (chartClick)=\"chartClicked($event)\"></canvas>\n        </div>\n      </div>\n    </div>\n  </div>");

/***/ }),

/***/ "aHM3":
/*!******************************************************************************!*\
  !*** ./node_modules/ngx-bootstrap/buttons/fesm2015/ngx-bootstrap-buttons.js ***!
  \******************************************************************************/
/*! exports provided: ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective, ButtonsModule, ɵa, ɵb, ɵc */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ButtonCheckboxDirective", function() { return ButtonCheckboxDirective; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ButtonRadioDirective", function() { return ButtonRadioDirective; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ButtonRadioGroupDirective", function() { return ButtonRadioGroupDirective; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ButtonsModule", function() { return ButtonsModule; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ɵa", function() { return CHECKBOX_CONTROL_VALUE_ACCESSOR; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ɵb", function() { return RADIO_CONTROL_VALUE_ACCESSOR$1; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ɵc", function() { return RADIO_CONTROL_VALUE_ACCESSOR; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/forms */ "s7LF");



/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */
// TODO: config: activeClass - Class to apply to the checked buttons
/** @type {?} */

const CHECKBOX_CONTROL_VALUE_ACCESSOR = {
    provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],
    /* tslint:disable-next-line: no-use-before-declare */
    useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])((/**
     * @return {?}
     */
    () => ButtonCheckboxDirective)),
    multi: true
};
/**
 * Add checkbox functionality to any element
 */
class ButtonCheckboxDirective {
    constructor() {
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
    }
    // view -> model
    /**
     * @return {?}
     */
    onClick() {
        if (this.isDisabled) {
            return;
        }
        this.toggle(!this.state);
        this.onChange(this.value);
    }
    /**
     * @return {?}
     */
    ngOnInit() {
        this.toggle(this.trueValue === this.value);
    }
    /**
     * @protected
     * @return {?}
     */
    get trueValue() {
        return typeof this.btnCheckboxTrue !== 'undefined'
            ? this.btnCheckboxTrue
            : true;
    }
    /**
     * @protected
     * @return {?}
     */
    get falseValue() {
        return typeof this.btnCheckboxFalse !== 'undefined'
            ? this.btnCheckboxFalse
            : false;
    }
    /**
     * @param {?} state
     * @return {?}
     */
    toggle(state) {
        this.state = state;
        this.value = this.state ? this.trueValue : this.falseValue;
    }
    // ControlValueAccessor
    // model -> view
    /**
     * @param {?} value
     * @return {?}
     */
    writeValue(value) {
        this.state = this.trueValue === value;
        this.value = value ? this.trueValue : this.falseValue;
    }
    /**
     * @param {?} isDisabled
     * @return {?}
     */
    setDisabledState(isDisabled) {
        this.isDisabled = isDisabled;
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnChange(fn) {
        this.onChange = fn;
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnTouched(fn) {
        this.onTouched = fn;
    }
}
ButtonCheckboxDirective.ɵfac = function ButtonCheckboxDirective_Factory(t) { return new (t || ButtonCheckboxDirective)(); };
ButtonCheckboxDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({ type: ButtonCheckboxDirective, selectors: [["", "btnCheckbox", ""]], hostVars: 3, hostBindings: function ButtonCheckboxDirective_HostBindings(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function ButtonCheckboxDirective_click_HostBindingHandler() { return ctx.onClick(); });
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("aria-pressed", ctx.state);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassProp"]("active", ctx.state);
    } }, inputs: { btnCheckboxTrue: "btnCheckboxTrue", btnCheckboxFalse: "btnCheckboxFalse" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([CHECKBOX_CONTROL_VALUE_ACCESSOR])] });
ButtonCheckboxDirective.propDecorators = {
    btnCheckboxTrue: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    btnCheckboxFalse: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    state: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['class.active',] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.aria-pressed',] }],
    onClick: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['click',] }]
};
(function () { (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonCheckboxDirective, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
        args: [{
                selector: '[btnCheckbox]',
                providers: [CHECKBOX_CONTROL_VALUE_ACCESSOR]
            }]
    }], function () { return []; }, { btnCheckboxTrue: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }], btnCheckboxFalse: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }], state: [{
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
        }] }); })();
if (false) {}

/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */
/** @type {?} */
const RADIO_CONTROL_VALUE_ACCESSOR = {
    provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],
    /* tslint:disable-next-line: no-use-before-declare */
    useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])((/**
     * @return {?}
     */
    () => ButtonRadioDirective)),
    multi: true
};
/**
 * Create radio buttons or groups of buttons.
 * A value of a selected button is bound to a variable specified via ngModel.
 */
class ButtonRadioDirective {
    /**
     * @param {?} el
     * @param {?} cdr
     * @param {?} renderer
     * @param {?} group
     */
    constructor(el, cdr, renderer, group) {
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
    get value() {
        return this.group ? this.group.value : this._value;
    }
    /**
     * @param {?} value
     * @return {?}
     */
    set value(value) {
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
    get disabled() {
        return this._disabled;
    }
    /**
     * @param {?} disabled
     * @return {?}
     */
    set disabled(disabled) {
        this.setDisabledState(disabled);
    }
    /**
     * @return {?}
     */
    get controlOrGroupDisabled() {
        return this.disabled || (this.group && this.group.disabled) ? true : undefined;
    }
    /**
     * @return {?}
     */
    get hasDisabledClass() {
        // Although the radio is disabled the active radio should still stand out.
        // The disabled class will prevent this so don't add it on the active radio
        return this.controlOrGroupDisabled && !this.isActive;
    }
    /**
     * @return {?}
     */
    get isActive() {
        return this.btnRadio === this.value;
    }
    /**
     * @return {?}
     */
    get tabindex() {
        if (this.controlOrGroupDisabled) {
            // Disabled radio buttons should not receive focus
            return undefined;
        }
        else if (this.isActive || this.group == null) {
            return 0;
        }
        else {
            return -1;
        }
    }
    /**
     * @return {?}
     */
    get hasFocus() {
        return this._hasFocus;
    }
    /**
     * @return {?}
     */
    toggleIfAllowed() {
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
    onSpacePressed(event) {
        this.toggleIfAllowed();
        event.preventDefault();
    }
    /**
     * @return {?}
     */
    focus() {
        this.el.nativeElement.focus();
    }
    /**
     * @return {?}
     */
    onFocus() {
        this._hasFocus = true;
    }
    /**
     * @return {?}
     */
    onBlur() {
        this._hasFocus = false;
        this.onTouched();
    }
    /**
     * @return {?}
     */
    canToggle() {
        return !this.controlOrGroupDisabled && (this.uncheckable || this.btnRadio !== this.value);
    }
    /**
     * @return {?}
     */
    ngOnInit() {
        this.uncheckable = typeof this.uncheckable !== 'undefined';
    }
    /**
     * @param {?} value
     * @return {?}
     */
    _onChange(value) {
        if (this.group) {
            this.group.value = value;
            return;
        }
        this.onTouched();
        this.onChange(value);
    }
    // ControlValueAccessor
    // model -> view
    /**
     * @param {?} value
     * @return {?}
     */
    writeValue(value) {
        this.value = value;
        this.cdr.markForCheck();
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnChange(fn) {
        this.onChange = fn;
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnTouched(fn) {
        this.onTouched = fn;
    }
    /**
     * @param {?} disabled
     * @return {?}
     */
    setDisabledState(disabled) {
        this._disabled = disabled;
        if (disabled) {
            this.renderer.setAttribute(this.el.nativeElement, 'disabled', 'disabled');
            return;
        }
        this.renderer.removeAttribute(this.el.nativeElement, 'disabled');
    }
}
ButtonRadioDirective.ɵfac = function ButtonRadioDirective_Factory(t) { return new (t || ButtonRadioDirective)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(( /**
                 * @return {?}
                 */() => ButtonRadioGroupDirective)), 8)); };
ButtonRadioDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({ type: ButtonRadioDirective, selectors: [["", "btnRadio", ""]], hostVars: 8, hostBindings: function ButtonRadioDirective_HostBindings(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function ButtonRadioDirective_click_HostBindingHandler() { return ctx.toggleIfAllowed(); })("keydown.space", function ButtonRadioDirective_keydown_space_HostBindingHandler($event) { return ctx.onSpacePressed($event); })("focus", function ButtonRadioDirective_focus_HostBindingHandler() { return ctx.onFocus(); })("blur", function ButtonRadioDirective_blur_HostBindingHandler() { return ctx.onBlur(); });
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("role", ctx.role)("aria-disabled", ctx.controlOrGroupDisabled)("aria-checked", ctx.isActive)("tabindex", ctx.tabindex);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassProp"]("disabled", ctx.hasDisabledClass)("active", ctx.isActive);
    } }, inputs: { value: "value", disabled: "disabled", uncheckable: "uncheckable", btnRadio: "btnRadio" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([RADIO_CONTROL_VALUE_ACCESSOR])] });
/** @nocollapse */
ButtonRadioDirective.ctorParameters = () => [
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"] },
    { type: ButtonRadioGroupDirective, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Optional"] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"], args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])((/**
                     * @return {?}
                     */
                    () => ButtonRadioGroupDirective)),] }] }
];
ButtonRadioDirective.propDecorators = {
    btnRadio: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    uncheckable: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    value: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    disabled: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"] }],
    controlOrGroupDisabled: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.aria-disabled',] }],
    hasDisabledClass: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['class.disabled',] }],
    isActive: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['class.active',] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.aria-checked',] }],
    role: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.role',] }],
    tabindex: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.tabindex',] }],
    toggleIfAllowed: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['click',] }],
    onSpacePressed: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['keydown.space', ['$event'],] }],
    onFocus: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['focus',] }],
    onBlur: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['blur',] }]
};
(function () { (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonRadioDirective, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
        args: [{
                selector: '[btnRadio]',
                providers: [RADIO_CONTROL_VALUE_ACCESSOR]
            }]
    }], function () { return [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ElementRef"] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Renderer2"] }, { type: ButtonRadioGroupDirective, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Optional"]
            }, {
                type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"],
                args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(( /**
                                     * @return {?}
                                     */() => ButtonRadioGroupDirective))]
            }] }]; }, { role: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.role']
        }], value: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }], disabled: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }], controlOrGroupDisabled: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.aria-disabled']
        }], hasDisabledClass: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['class.disabled']
        }], isActive: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['class.active']
        }, {
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.aria-checked']
        }], tabindex: [{
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
        }], uncheckable: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }], btnRadio: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
        }] }); })();
if (false) {}

/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */
/** @type {?} */
const RADIO_CONTROL_VALUE_ACCESSOR$1 = {
    provide: _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NG_VALUE_ACCESSOR"],
    /* tslint:disable-next-line: no-use-before-declare */
    useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])((/**
     * @return {?}
     */
    () => ButtonRadioGroupDirective)),
    multi: true
};
/**
 * A group of radio buttons.
 * A value of a selected button is bound to a variable specified via ngModel.
 */
class ButtonRadioGroupDirective {
    /**
     * @param {?} cdr
     */
    constructor(cdr) {
        this.cdr = cdr;
        this.onChange = Function.prototype;
        this.onTouched = Function.prototype;
        this.role = 'radiogroup';
    }
    /**
     * @return {?}
     */
    get value() {
        return this._value;
    }
    /**
     * @param {?} value
     * @return {?}
     */
    set value(value) {
        this._value = value;
        this.onChange(value);
    }
    /**
     * @return {?}
     */
    get tabindex() {
        if (this._disabled) {
            return null;
        }
        else {
            return 0;
        }
    }
    /**
     * @param {?} value
     * @return {?}
     */
    writeValue(value) {
        this._value = value;
        this.cdr.markForCheck();
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnChange(fn) {
        this.onChange = fn;
    }
    /**
     * @param {?} fn
     * @return {?}
     */
    registerOnTouched(fn) {
        this.onTouched = fn;
    }
    /**
     * @param {?} disabled
     * @return {?}
     */
    setDisabledState(disabled) {
        if (this.radioButtons) {
            this._disabled = disabled;
            this.radioButtons.forEach((/**
             * @param {?} buttons
             * @return {?}
             */
            buttons => {
                buttons.setDisabledState(disabled);
            }));
            this.cdr.markForCheck();
        }
    }
    /**
     * @return {?}
     */
    onFocus() {
        if (this._disabled) {
            return;
        }
        /** @type {?} */
        const activeRadio = this.getActiveOrFocusedRadio();
        if (activeRadio) {
            activeRadio.focus();
        }
        else {
            /** @type {?} */
            const firstEnabled = this.radioButtons.find((/**
             * @param {?} r
             * @return {?}
             */
            r => !r.disabled));
            if (firstEnabled) {
                firstEnabled.focus();
            }
        }
    }
    /**
     * @return {?}
     */
    onBlur() {
        if (this.onTouched) {
            this.onTouched();
        }
    }
    /**
     * @param {?} event
     * @return {?}
     */
    selectNext(event) {
        this.selectInDirection('next');
        event.preventDefault();
    }
    /**
     * @param {?} event
     * @return {?}
     */
    selectPrevious(event) {
        this.selectInDirection('previous');
        event.preventDefault();
    }
    /**
     * @return {?}
     */
    get disabled() {
        return this._disabled;
    }
    /**
     * @private
     * @param {?} direction
     * @return {?}
     */
    selectInDirection(direction) {
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
            const step = direction === 'next' ? 1 : -1;
            /** @type {?} */
            let calcIndex = (currentIndex + step) % buttonRadioDirectives.length;
            if (calcIndex < 0) {
                calcIndex = buttonRadioDirectives.length - 1;
            }
            return calcIndex;
        }
        /** @type {?} */
        const activeRadio = this.getActiveOrFocusedRadio();
        if (activeRadio) {
            /** @type {?} */
            const buttonRadioDirectives = this.radioButtons.toArray();
            /** @type {?} */
            const currentActiveIndex = buttonRadioDirectives.indexOf(activeRadio);
            for (let i = nextIndex(currentActiveIndex, buttonRadioDirectives); i !== currentActiveIndex; i = nextIndex(i, buttonRadioDirectives)) {
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
    getActiveOrFocusedRadio() {
        return this.radioButtons.find((/**
         * @param {?} button
         * @return {?}
         */
        button => button.isActive)) || this.radioButtons.find((/**
         * @param {?} button
         * @return {?}
         */
        button => button.hasFocus));
    }
}
ButtonRadioGroupDirective.ɵfac = function ButtonRadioGroupDirective_Factory(t) { return new (t || ButtonRadioGroupDirective)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"])); };
ButtonRadioGroupDirective.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineDirective"]({ type: ButtonRadioGroupDirective, selectors: [["", "btnRadioGroup", ""]], contentQueries: function ButtonRadioGroupDirective_ContentQueries(rf, ctx, dirIndex) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵcontentQuery"](dirIndex, ButtonRadioDirective, 0);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵloadQuery"]()) && (ctx.radioButtons = _t);
    } }, hostVars: 2, hostBindings: function ButtonRadioGroupDirective_HostBindings(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("focus", function ButtonRadioGroupDirective_focus_HostBindingHandler() { return ctx.onFocus(); })("blur", function ButtonRadioGroupDirective_blur_HostBindingHandler() { return ctx.onBlur(); })("keydown.ArrowRight", function ButtonRadioGroupDirective_keydown_ArrowRight_HostBindingHandler($event) { return ctx.selectNext($event); })("keydown.ArrowDown", function ButtonRadioGroupDirective_keydown_ArrowDown_HostBindingHandler($event) { return ctx.selectNext($event); })("keydown.ArrowLeft", function ButtonRadioGroupDirective_keydown_ArrowLeft_HostBindingHandler($event) { return ctx.selectPrevious($event); })("keydown.ArrowUp", function ButtonRadioGroupDirective_keydown_ArrowUp_HostBindingHandler($event) { return ctx.selectPrevious($event); });
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵattribute"]("role", ctx.role)("tabindex", ctx.tabindex);
    } }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵProvidersFeature"]([RADIO_CONTROL_VALUE_ACCESSOR$1])] });
/** @nocollapse */
ButtonRadioGroupDirective.ctorParameters = () => [
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"] }
];
ButtonRadioGroupDirective.propDecorators = {
    role: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.role',] }],
    radioButtons: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ContentChildren"], args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])((/**
                 * @return {?}
                 */
                () => ButtonRadioDirective)),] }],
    tabindex: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"], args: ['attr.tabindex',] }],
    onFocus: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['focus',] }],
    onBlur: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['blur',] }],
    selectNext: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['keydown.ArrowRight', ['$event'],] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['keydown.ArrowDown', ['$event'],] }],
    selectPrevious: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['keydown.ArrowLeft', ['$event'],] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostListener"], args: ['keydown.ArrowUp', ['$event'],] }]
};
(function () { (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonRadioGroupDirective, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Directive"],
        args: [{
                selector: '[btnRadioGroup]',
                providers: [RADIO_CONTROL_VALUE_ACCESSOR$1]
            }]
    }], function () { return [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ChangeDetectorRef"] }]; }, { role: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["HostBinding"],
            args: ['attr.role']
        }], tabindex: [{
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
        }], radioButtons: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["ContentChildren"],
            args: [Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["forwardRef"])(( /**
                             * @return {?}
                             */() => ButtonRadioDirective))]
        }] }); })();
if (false) {}

/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */
class ButtonsModule {
    /**
     * @return {?}
     */
    static forRoot() {
        return { ngModule: ButtonsModule, providers: [] };
    }
}
ButtonsModule.ɵfac = function ButtonsModule_Factory(t) { return new (t || ButtonsModule)(); };
ButtonsModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: ButtonsModule });
ButtonsModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({});
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](ButtonsModule, { declarations: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective], exports: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective] }); })();
(function () { (typeof ngDevMode === "undefined" || ngDevMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ButtonsModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
                declarations: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective],
                exports: [ButtonCheckboxDirective, ButtonRadioDirective, ButtonRadioGroupDirective]
            }]
    }], null, null); })();

/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */

/**
 * @fileoverview added by tsickle
 * @suppress {checkTypes,extraRequire,missingOverride,missingReturn,unusedPrivateMembers,uselessCode} checked by tsc
 */



//# sourceMappingURL=ngx-bootstrap-buttons.js.map

/***/ }),

/***/ "jUYC":
/*!*************************************************************!*\
  !*** ./src/app/views/dashboard/dashboard-routing.module.ts ***!
  \*************************************************************/
/*! exports provided: DashboardRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DashboardRoutingModule", function() { return DashboardRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _dashboard_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./dashboard.component */ "l70X");




const routes = [
    {
        path: '',
        component: _dashboard_component__WEBPACK_IMPORTED_MODULE_3__["DashboardComponent"],
        data: {
            title: 'Dashboard'
        }
    }
];
let DashboardRoutingModule = class DashboardRoutingModule {
};
DashboardRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], DashboardRoutingModule);



/***/ }),

/***/ "l70X":
/*!********************************************************!*\
  !*** ./src/app/views/dashboard/dashboard.component.ts ***!
  \********************************************************/
/*! exports provided: DashboardComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DashboardComponent", function() { return DashboardComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_dashboard_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./dashboard.component.html */ "P3Bu");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _services_patient_service__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../services/patient.service */ "7wfR");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_stats_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/stats.service */ "9pNJ");






let DashboardComponent = class DashboardComponent {
    constructor(patientservice, router, statsservice) {
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
        this.color_gender = [
            {
                backgroundColor: [
                    'rgba(58, 163, 248, 0.8)',
                    'rgba(245, 40, 145, 0.8)',
                ]
            }
        ];
        this.gender_stats_name = ['Male', 'Female'];
        this.gender_stats_number = [];
        this.pieChartType_gender = 'pie';
        // barChart
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
        this.barChartData = [
            {
                data: [], label: 'Age',
                backgroundColor: 'rgba(40, 166, 145, 0.8)',
                hoverBackgroundColor: 'rgba(40, 166, 145, 0.8)',
                hoverBorderColor: 'rgba(40, 166, 145, 0.8)',
                borderColor: 'rgba(40, 166, 145, 0.8)',
            }
        ];
        this.barChartLabels2 = [];
        this.barChartData2 = [
            { data: [], label: 'Female' },
            { data: [], label: 'Male' }
        ];
        this.color_lab_name = [
            {
                backgroundColor: []
            }
        ];
        this.lab_name = [];
        this.lab_count = [];
        // Doughnut
        this.doughnutChartLabels = [];
        this.doughnutChartData = [];
        this.doughnutChartType = 'doughnut';
        this.color_test = [
            {
                backgroundColor: []
            }
        ];
        // Doughnut
        this.doughnutChartLabels2 = [];
        this.doughnutChartData2 = [];
        this.color_species = [
            {
                backgroundColor: []
            }
        ];
    }
    ngOnInit() {
        this.get_stats();
        this.get_stats_gender();
        this.get_stats_age_gender();
        this.get_stats_age_gender2();
        this.get_lab_name();
        this.get_molecular_test();
        this.get_species();
    }
    // events
    chartClicked(e) {
        console.log(e);
    }
    chartHovered(e) {
        console.log(e);
    }
    get_stats() {
        this.patientservice.stats().subscribe(data => {
            this.xx = [];
            data.body.forEach(element => {
                this.splitted = element.split(",", 2);
                this.xx.push(this.splitted);
            });
            this.xx.forEach(element => {
                this.polarAreaChartLabels2.push(element[0]);
                this.polarAreaChartData2.push(Number(element[1]));
                // this.colors.push('#'+Math.floor(Math.random()*16777215).toString(16));
                do {
                    var o = Math.round, r = Math.random, s = 255;
                    var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');
                this.vv[0].backgroundColor.push(col);
            });
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_stats_gender() {
        this.statsservice.get_stats_gender().subscribe(data => {
            this.gender_stats_number.push(Number(data.body.Male));
            this.gender_stats_number.push(Number(data.body.Female));
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_stats_age_gender() {
        this.statsservice.get_gender_age().subscribe(data => {
            console.log(data);
            data.body.forEach(element => {
                this.barChartLabels.push(element[1]);
                this.barChartData[0].data.push(element[0]);
            });
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_stats_age_gender2() {
        this.statsservice.get_gender_age_2().subscribe(data => {
            console.log(data);
            var cc = [];
            var ll = [];
            data.body["age"].forEach(element => {
                this.barChartLabels2.push(element);
            });
            console.log("liste age ===  " + this.barChartLabels2);
            this.barChartLabels2.forEach(element => {
                cc.push(0);
            });
            data.body["Male"].forEach(element => {
                if (this.barChartLabels2.includes(element[1])) {
                    cc[this.barChartLabels2.indexOf(element[1])] = element[0];
                }
            });
            console.log(cc);
            this.barChartLabels2.forEach(element => {
                ll.push(0);
            });
            data.body["Female"].forEach(element => {
                if (this.barChartLabels2.includes(element[1])) {
                    ll[this.barChartLabels2.indexOf(element[1])] = element[0];
                }
            });
            console.log(ll);
            // this.barChartData2[2].data=n_a;
            this.barChartData2[0].data = ll;
            this.barChartData2[1].data = cc;
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_lab_name() {
        this.statsservice.lab_name().subscribe(data => {
            data.body.forEach(element => {
                this.lab_name.push(element[1]);
                this.lab_count.push(element[0]);
                do {
                    var o = Math.round, r = Math.random, s = 255;
                    var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');
                this.color_lab_name[0].backgroundColor.push(col);
            });
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_molecular_test() {
        this.statsservice.molecular_test().subscribe(data => {
            data.body.forEach(element => {
                this.doughnutChartLabels.push(element[1]);
                this.doughnutChartData.push(element[0]);
                do {
                    var o = Math.round, r = Math.random, s = 255;
                    var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');
                this.color_test[0].backgroundColor.push(col);
            });
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_species() {
        this.statsservice.species().subscribe(data => {
            data.body.forEach(element => {
                this.doughnutChartLabels2.push(element[1]);
                this.doughnutChartData2.push(element[0]);
                do {
                    var o = Math.round, r = Math.random, s = 255;
                    var col = 'rgba(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ',' + r().toFixed(1) + ')';
                } while (col == 'rgba(255,255,255,255)');
                this.color_species[0].backgroundColor.push(col);
            });
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.patientservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
};
DashboardComponent.ctorParameters = () => [
    { type: _services_patient_service__WEBPACK_IMPORTED_MODULE_3__["PatientService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] },
    { type: _services_stats_service__WEBPACK_IMPORTED_MODULE_5__["StatsService"] }
];
DashboardComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Component"])({
        template: _raw_loader_dashboard_component_html__WEBPACK_IMPORTED_MODULE_1__["default"]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_patient_service__WEBPACK_IMPORTED_MODULE_3__["PatientService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"], _services_stats_service__WEBPACK_IMPORTED_MODULE_5__["StatsService"]])
], DashboardComponent);



/***/ })

}]);
//# sourceMappingURL=views-dashboard-dashboard-module-es2015.js.map