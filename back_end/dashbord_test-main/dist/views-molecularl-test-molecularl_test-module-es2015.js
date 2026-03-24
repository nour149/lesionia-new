(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-molecularl-test-molecularl_test-module"],{

/***/ "38P3":
/*!********************************************************************!*\
  !*** ./src/app/views/molecularl-test/molecularl-test.component.ts ***!
  \********************************************************************/
/*! exports provided: MolecularlTestComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MolecularlTestComponent", function() { return MolecularlTestComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_molecularl_test_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./molecularl-test.component.html */ "pX2F");
/* harmony import */ var _molecularl_test_component_scss__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./molecularl-test.component.scss */ "40rQ");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_molecularl_test_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/molecularl-test.service */ "sgwo");






let MolecularlTestComponent = class MolecularlTestComponent {
    constructor(moleculartestservice, router) {
        this.moleculartestservice = moleculartestservice;
        this.router = router;
        this.new_value = "";
        this.alertsDismiss = [];
    }
    ngOnInit() {
        this.get_all();
    }
    get_all() {
        this.moleculartestservice.get_all_molecularl_test().subscribe(data => {
            if (data.status == 200) {
                this.molecularl_tests = data.body;
                this.content_laboratory = true;
            }
            else if (data.status == 204) {
                this.content_laboratory = false;
            }
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.moleculartestservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    update(molecularl_test) {
        if (window.confirm('Are you sure')) {
            this.new_value = document.getElementById("molecularl_test_update.test_TYPE").value;
            molecularl_test.test_TYPE = this.new_value;
            this.moleculartestservice.update_molecularl_test(molecularl_test).subscribe((response) => {
                this.get_all();
                this.alert('Molecular test successfully updated', 'warning');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    set(molecularl_test) {
        this.molecularl_test_update = molecularl_test;
        document.getElementById("molecularl_test_update.test_TYPE").value = molecularl_test.test_TYPE;
    }
    delete(test) {
        if (window.confirm('Are you sure')) {
            this.moleculartestservice.delete_molecularl_test(test).subscribe((response) => {
                this.get_all();
                this.alert('Molecular test successfully deleted', 'danger');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    add(molecularl_test) {
        this.new_molecularl_test = molecularl_test.value;
        this.new_molecularl_test;
        this.new_molecularl_test.loginuser = localStorage.getItem("current_user_id");
        this.moleculartestservice.add_molecularl_test(this.new_molecularl_test).subscribe((response) => {
            if (response == "201") {
                this.existe = false;
                this.get_all();
                this.alert('Molecular test successfully added', 'primary');
                molecularl_test.resetForm();
                this.hide();
            }
            else if (response == "200") {
                this.existe = true;
            }
        }, (error) => {
            if (error) {
                if (error.status == 403) {
                    localStorage.clear();
                    this.moleculartestservice.clear();
                    this.router.navigateByUrl('/login');
                }
            }
        });
    }
    hide() {
        let element = document.getElementById('r');
        element.click();
    }
    cancel_add(molecularl_test) {
        molecularl_test.resetForm();
        this.existe = false;
    }
    alert(msg, type) {
        this.alertsDismiss.push({
            type: type,
            msg: msg,
            timeout: 2500
        });
    }
};
MolecularlTestComponent.ctorParameters = () => [
    { type: _services_molecularl_test_service__WEBPACK_IMPORTED_MODULE_5__["MolecularlTestService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }
];
MolecularlTestComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-molecularl-test',
        template: _raw_loader_molecularl_test_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_molecularl_test_component_scss__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_molecularl_test_service__WEBPACK_IMPORTED_MODULE_5__["MolecularlTestService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]])
], MolecularlTestComponent);



/***/ }),

/***/ "40rQ":
/*!**********************************************************************!*\
  !*** ./src/app/views/molecularl-test/molecularl-test.component.scss ***!
  \**********************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\n  border: 1px solid black;\n  border-collapse: collapse;\n}\n\nth {\n  background-color: #96D4D4;\n}\n\n.error {\n  color: red;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxtb2xlY3VsYXJsLXRlc3QuY29tcG9uZW50LnNjc3MiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQ0E7RUFDSSx1QkFBQTtFQUNBLHlCQUFBO0FBQUo7O0FBRUU7RUFDRSx5QkFBQTtBQUNKOztBQUVFO0VBRUUsVUFBQTtBQUFKIiwiZmlsZSI6Im1vbGVjdWxhcmwtdGVzdC5jb21wb25lbnQuc2NzcyIsInNvdXJjZXNDb250ZW50IjpbIlxyXG50YWJsZSwgdGgsIHRkIHtcclxuICAgIGJvcmRlcjogMXB4IHNvbGlkIGJsYWNrO1xyXG4gICAgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTtcclxuICB9XHJcbiAgdGgge1xyXG4gICAgYmFja2dyb3VuZC1jb2xvcjogIzk2RDRENDtcclxuICB9XHJcblxyXG4gIC5lcnJvclxyXG4gIHtcclxuICAgIGNvbG9yOiByZWQ7XHJcbiAgfSJdfQ== */");

/***/ }),

/***/ "6zyL":
/*!*************************************************************************!*\
  !*** ./src/app/views/molecularl-test/molecularl_test-routing.module.ts ***!
  \*************************************************************************/
/*! exports provided: MolecularlTestRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MolecularlTestRoutingModule", function() { return MolecularlTestRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _molecularl_test_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./molecularl-test.component */ "38P3");




const routes = [
    {
        path: '',
        component: _molecularl_test_component__WEBPACK_IMPORTED_MODULE_3__["MolecularlTestComponent"],
        data: {
            title: 'molecularl-test'
        }
    }
];
let MolecularlTestRoutingModule = class MolecularlTestRoutingModule {
};
MolecularlTestRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes),],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], MolecularlTestRoutingModule);



/***/ }),

/***/ "ipN1":
/*!*****************************************************************!*\
  !*** ./src/app/views/molecularl-test/molecularl_test.module.ts ***!
  \*****************************************************************/
/*! exports provided: MolecularlTestModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MolecularlTestModule", function() { return MolecularlTestModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var ngx_pagination__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-pagination */ "oOf3");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var _molecularl_test_routing_module__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./molecularl_test-routing.module */ "6zyL");
/* harmony import */ var _molecularl_test_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./molecularl-test.component */ "38P3");
/* harmony import */ var ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ngx-bootstrap/alert */ "CNMR");








let MolecularlTestModule = class MolecularlTestModule {
};
MolecularlTestModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_2__["CommonModule"],
            _molecularl_test_routing_module__WEBPACK_IMPORTED_MODULE_5__["MolecularlTestRoutingModule"],
            ngx_pagination__WEBPACK_IMPORTED_MODULE_3__["NgxPaginationModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_4__["ReactiveFormsModule"],
            ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__["AlertModule"].forRoot(),
            _angular_forms__WEBPACK_IMPORTED_MODULE_4__["FormsModule"]
        ],
        declarations: [_molecularl_test_component__WEBPACK_IMPORTED_MODULE_6__["MolecularlTestComponent"]],
    })
], MolecularlTestModule);



/***/ }),

/***/ "pX2F":
/*!************************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/molecularl-test/molecularl-test.component.html ***!
  \************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<!-- Button trigger modal -->\n<div class=\"col-md-12 text-center\">\n    <button type=\"button\" class=\"btn btn-primary btn-center\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n        Add new Molecular test\n    </button>\n</div>\n<br>\n\n<div *ngFor=\"let alert of alertsDismiss\">\n    <alert [type]=\"alert.type\" [dismissOnTimeout]=\"alert.timeout\">{{alert.msg}}</alert>\n  </div>\n<div *ngIf=\"content_laboratory\">\n    <div class=\"table-responsive -sm\">\n        <table class=\"table\">\n            <thead class=\"thead-primary \">\n                <tr>\n                    <th scope=\"col\">Test</th>\n                    <th scope=\"col\">Test Type</th>\n                    <th scope=\"col\">Edit</th>\n                    <th scope=\"col\">Delete</th>\n                </tr>\n            </thead>\n\n            <tbody *ngFor=\" let molecularl_test of molecularl_tests\">\n                <tr>\n                    <td>{{molecularl_test.test}}</td>\n                    <td>{{molecularl_test.test_TYPE}}</td>\n                    <td>\n                        <div class=\"text-center\">\n                        <button (click)=\"set(molecularl_test)\" type=\"button\" data-toggle=\"modal\" data-target=\"#edit\"\n                            class=\"btn btn-outline-warning\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\"\n                                height=\"20\" fill=\"currentColor\" class=\"bi bi-pencil\" viewBox=\"0 0 16 16\">\n                                <path\n                                    d=\"M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z\" />\n                            </svg> </button>\n                            </div>\n                    </td>\n                    <td>\n                        <div class=\"text-center\">\n                        <button class=\"btn btn-outline-danger center\" (click)=\"delete(molecularl_test.test)\">\n                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"currentColor\"\n                                class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\n                                <path\n                                    d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\" />\n                                <path fill-rule=\"evenodd\"\n                                    d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\" />\n                            </svg>\n                        </button>\n                        </div>\n                    </td>\n            </tbody>\n        </table>\n    </div>\n</div>\n<div *ngIf=\"!content_laboratory\">\n    <h2>There is no molecularl test found yet\n    </h2>\n</div>\n<!-- Modal -->\n<div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\"\n    aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">New molecularl test</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\"\n                    aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <form #form_add='ngForm' (ngSubmit)=\"add(form_add)\">\n\n                    <div class=\"form-group\">\n                        <label for=\"test\">Test</label>\n                        <input type=\"text\" id=\"test\" input name=\"test\" ngModel required #test=\"ngModel\"\n                            class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <span *ngIf=\"existe\">\n                        <h5 class=\"error\">This Test already exist</h5>\n                    </span>\n                    <div class=\"form-group\">\n                        <label for=\"test_TYPE\">Test Type</label>\n                        <input type=\"text\" id=\"test_TYPE\" input name=\"test_TYPE\" ngModel required #test_TYPE=\"ngModel\"\n                            class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <div class=\"modal-footer\">\n                        <button id=\"r\" type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\"\n                            (click)=\"cancel_add(form_add)\">Cancel</button>\n                        <button type=\"submit\" class=\"btn btn-primary\" [disabled]=\"form_add.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>\n\n<!-- Modal -->\n<div class=\"modal fade\" id=\"edit\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">Update</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <div class=\"form-group\">\n                    <label for=\"molecularl_test_update_test\">Laboratoryname</label>\n                    <input type=\"text\" id=\"molecularl_test_update_test\" ngModel={{molecularl_test_update?.test}}\n                        class=\"form-control\" readonly>\n                </div>\n                <form #form='ngForm'>\n                    <div class=\"form-group\">\n                        <label for=\"molecularl_test_update.test_TYPE\">Country</label>\n                        <input type=\"text\" id=\"molecularl_test_update.test_TYPE\"\n                            ngModel={{molecularl_test_update?.test_TYPE}} class=\"form-control\" required minlength=\"3\">\n                    </div>\n\n\n                    <div class=\"modal-footer\">\n                        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n                        <button type=\"submit\" (click)=\"update(molecularl_test_update)\" class=\"btn btn-primary\"\n                            data-dismiss=\"modal\" [disabled]=\"form.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>");

/***/ }),

/***/ "sgwo":
/*!*****************************************************!*\
  !*** ./src/app/services/molecularl-test.service.ts ***!
  \*****************************************************/
/*! exports provided: MolecularlTestService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MolecularlTestService", function() { return MolecularlTestService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let MolecularlTestService = class MolecularlTestService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_all_molecularl_test() {
        return this.http.get(this.baseurl + "molecularl_test/all", { observe: 'response' });
    }
    delete_molecularl_test(id) {
        return this.http.delete(this.baseurl + "molecularl_test/?id=" + id, { responseType: 'text' });
    }
    add_molecularl_test(molecularl_test) {
        return this.http.post(this.baseurl + "molecularl_test/save", molecularl_test, { responseType: 'text' });
    }
    update_molecularl_test(molecularl_test) {
        return this.http.post(this.baseurl + "molecularl_test/update", molecularl_test, { responseType: 'text' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
MolecularlTestService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
MolecularlTestService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], MolecularlTestService);



/***/ })

}]);
//# sourceMappingURL=views-molecularl-test-molecularl_test-module-es2015.js.map