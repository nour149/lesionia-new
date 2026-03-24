(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-laboratory-laboratory-module"],{

/***/ "4d1g":
/*!**********************************************************!*\
  !*** ./src/app/views/laboratory/laboratory.component.ts ***!
  \**********************************************************/
/*! exports provided: LaboratoryComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LaboratoryComponent", function() { return LaboratoryComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_laboratory_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./laboratory.component.html */ "utYX");
/* harmony import */ var _laboratory_component_scss__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./laboratory.component.scss */ "yy4e");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_laboratory_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/laboratory.service */ "h953");






let LaboratoryComponent = class LaboratoryComponent {
    constructor(laboratoryservice, router) {
        this.laboratoryservice = laboratoryservice;
        this.router = router;
        this.new_value = "";
        this.alertsDismiss = [];
    }
    ngOnInit() {
        this.get_all();
    }
    get_all() {
        this.laboratoryservice.get_all_laboratory().subscribe(data => {
            if (data.status == 200) {
                this.laboratorys = data.body;
                this.content_laboratory = true;
            }
            else if (data.status == 204) {
                this.content_laboratory = false;
            }
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.laboratoryservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    update(laboratory) {
        if (window.confirm('Are you sure')) {
            this.new_value = document.getElementById("laboratory_update_country").value;
            laboratory.country = this.new_value;
            this.laboratoryservice.update_laboratory(laboratory).subscribe((response) => {
                this.get_all();
                this.alert('Laboratory successfully updated', 'warning');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    set(laboratory) {
        this.laboratory_update = laboratory;
        document.getElementById("laboratory_update_country").value = laboratory.country;
    }
    delete(laboratoryname) {
        if (window.confirm('Are you sure')) {
            this.laboratoryservice.delete_laboratory(laboratoryname).subscribe((response) => {
                this.get_all();
                this.alert('Laboratory successfully deleted', 'danger');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    add_laboratory(laboratory) {
        this.new_laboratory = laboratory.value;
        this.new_laboratory.loginuser = localStorage.getItem("current_user_id");
        this.laboratoryservice.add_laboratory(this.new_laboratory).subscribe((response) => {
            if (response == "201") {
                this.existe = false;
                this.get_all();
                this.alert('Laboratory successfully added', 'primary');
                laboratory.resetForm();
                this.hide();
            }
            else if (response == "200") {
                this.existe = true;
            }
        }, (error) => {
            if (error) {
                if (error.status == 403) {
                    localStorage.clear();
                    this.laboratoryservice.clear();
                    this.router.navigateByUrl('/login');
                }
            }
        });
    }
    hide() {
        let element = document.getElementById('r');
        element.click();
    }
    cancel_add(laboratory) {
        laboratory.resetForm();
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
LaboratoryComponent.ctorParameters = () => [
    { type: _services_laboratory_service__WEBPACK_IMPORTED_MODULE_5__["LaboratoryService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }
];
LaboratoryComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-laboratory',
        template: _raw_loader_laboratory_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_laboratory_component_scss__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_laboratory_service__WEBPACK_IMPORTED_MODULE_5__["LaboratoryService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]])
], LaboratoryComponent);



/***/ }),

/***/ "8AtP":
/*!*******************************************************!*\
  !*** ./src/app/views/laboratory/laboratory.module.ts ***!
  \*******************************************************/
/*! exports provided: LaboratoryModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LaboratoryModule", function() { return LaboratoryModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _laboratory_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./laboratory.component */ "4d1g");
/* harmony import */ var _laboratory_routing_module__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./laboratory-routing.module */ "9Dpk");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var ngx_pagination__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ngx-pagination */ "oOf3");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ngx-bootstrap/alert */ "CNMR");








let LaboratoryModule = class LaboratoryModule {
};
LaboratoryModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_4__["CommonModule"],
            _laboratory_routing_module__WEBPACK_IMPORTED_MODULE_3__["LaboratoryRoutingModule"],
            ngx_pagination__WEBPACK_IMPORTED_MODULE_5__["NgxPaginationModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_6__["ReactiveFormsModule"],
            ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__["AlertModule"].forRoot(),
            _angular_forms__WEBPACK_IMPORTED_MODULE_6__["FormsModule"]
        ],
        declarations: [_laboratory_component__WEBPACK_IMPORTED_MODULE_2__["LaboratoryComponent"]]
    })
], LaboratoryModule);



/***/ }),

/***/ "9Dpk":
/*!***************************************************************!*\
  !*** ./src/app/views/laboratory/laboratory-routing.module.ts ***!
  \***************************************************************/
/*! exports provided: LaboratoryRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LaboratoryRoutingModule", function() { return LaboratoryRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _laboratory_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./laboratory.component */ "4d1g");




const routes = [
    {
        path: '',
        component: _laboratory_component__WEBPACK_IMPORTED_MODULE_3__["LaboratoryComponent"],
        data: {
            title: 'laboratory'
        }
    }
];
let LaboratoryRoutingModule = class LaboratoryRoutingModule {
};
LaboratoryRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], LaboratoryRoutingModule);



/***/ }),

/***/ "h953":
/*!************************************************!*\
  !*** ./src/app/services/laboratory.service.ts ***!
  \************************************************/
/*! exports provided: LaboratoryService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LaboratoryService", function() { return LaboratoryService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let LaboratoryService = class LaboratoryService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_all_laboratory() {
        return this.http.get(this.baseurl + "laboratory/all", { observe: 'response' });
    }
    delete_laboratory(laboratoryname) {
        return this.http.delete(this.baseurl + "laboratory/?LABORATORYNAME=" + laboratoryname, { responseType: 'text' });
    }
    add_laboratory(laboratory) {
        return this.http.post(this.baseurl + "laboratory/save", laboratory, { responseType: 'text' });
    }
    update_laboratory(laboratory) {
        return this.http.post(this.baseurl + "laboratory/update", laboratory, { responseType: 'text' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
LaboratoryService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
LaboratoryService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], LaboratoryService);



/***/ }),

/***/ "utYX":
/*!**************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/laboratory/laboratory.component.html ***!
  \**************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<!-- Button trigger modal -->\n<div class=\"col-md-12 text-center\">\n    <button type=\"button\" class=\"btn btn-primary btn-center\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n        Add new laboratory\n    </button>\n</div>\n<br>\n<div *ngFor=\"let alert of alertsDismiss\">\n    <alert [type]=\"alert.type\" [dismissOnTimeout]=\"alert.timeout\">{{alert.msg}}</alert>\n</div>\n<div *ngIf=\"content_laboratory\">\n<div class=\"table-responsive -sm\">\n    <table class=\"table\">\n        <thead class=\"thead-primary \">\n            <tr>\n                <th scope=\"col\">Laboratory name</th>\n                <th scope=\"col\">Country</th>\n                <th scope=\"col\">Edit</th>\n                <th scope=\"col\">Delete</th>\n            </tr>\n        </thead>\n\n        <tbody *ngFor=\" let laboratory of laboratorys\">\n            <tr>\n                <td>{{laboratory.laboratoryname}}</td>\n                <td>{{laboratory.country}}</td>\n               \n                <td>\n                    <div class=\"text-center\">\n                    <button (click)=\"set(laboratory)\" type=\"button\" data-toggle=\"modal\" data-target=\"#edit\"\n                        class=\"btn btn-outline-warning\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\"\n                            fill=\"currentColor\" class=\"bi bi-pencil\" viewBox=\"0 0 16 16\">\n                            <path\n                                d=\"M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z\" />\n                        </svg> </button>\n                        </div>\n                </td>\n                \n                <td>\n                    <div class=\"text-center\">\n                    <button class=\"btn btn-outline-danger center\" (click)=\"delete(laboratory.laboratoryname)\">\n                        <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"currentColor\"\n                            class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\n                            <path\n                                d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\" />\n                            <path fill-rule=\"evenodd\"\n                                d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\" />\n                        </svg>\n                    </button>\n                </div></td>\n                \n        </tbody>\n    </table>\n</div>\n</div>\n<div *ngIf=\"!content_laboratory\">\n  <h2>There is no laboratory found yet\n</h2>\n</div>\n\n<!-- Modal -->\n<div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\"\n    aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">New laboratory</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <form #form_add='ngForm' (ngSubmit)=\"add_laboratory(form_add)\">\n\n                    <div class=\"form-group\">\n                        <label for=\"laboratoryname\">Laboratoryname</label>\n                        <input type=\"text\" id=\"laboratoryname\" input name=\"laboratoryname\" ngModel required\n                            #laboratoryname=\"ngModel\" class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <span *ngIf=\"existe\">\n                        <h5 class=\"error\">This laboratoryname already exist</h5>\n                    </span>\n                    <div class=\"form-group\">\n                        <label for=\"country\">Country</label>\n                        <input type=\"text\" id=\"country\" input name=\"country\" ngModel required #country=\"ngModel\"\n                            class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <div class=\"modal-footer\">\n                        <button id=\"r\" type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\">Cancel</button>\n                        <button type=\"submit\" class=\"btn btn-primary\" [disabled]=\"form_add.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>\n  \n<!-- Modal -->\n\n<div class=\"modal fade\" id=\"edit\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">Update</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <div class=\"form-group\">\n                    <label for=\"laboratory_update_name\">Laboratoryname</label>\n                    <input type=\"text\" id=\"laboratory_update_name\" ngModel={{laboratory_update?.laboratoryname}}\n                        class=\"form-control\" readonly>\n                </div>\n                <form #form='ngForm'>\n                    <div class=\"form-group\">\n                        <label for=\"laboratory_update_country\">Country</label>\n                        <input type=\"text\" id=\"laboratory_update_country\" ngModel={{laboratory_update?.country}}\n                            class=\"form-control\" required minlength=\"3\">\n                    </div>\n\n\n                    <div class=\"modal-footer\">\n                        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n                        <button type=\"submit\" (click)=\"update(laboratory_update)\" class=\"btn btn-primary\" data-dismiss=\"modal\"\n                            [disabled]=\"form.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>");

/***/ }),

/***/ "yy4e":
/*!************************************************************!*\
  !*** ./src/app/views/laboratory/laboratory.component.scss ***!
  \************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\n  border: 1px solid black;\n  border-collapse: collapse;\n}\n\nth {\n  background-color: #96D4D4;\n}\n\n.error {\n  color: red;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxsYWJvcmF0b3J5LmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUVBO0VBQ0ksdUJBQUE7RUFDQSx5QkFBQTtBQURKOztBQUdFO0VBQ0UseUJBQUE7QUFBSjs7QUFHRTtFQUVFLFVBQUE7QUFESiIsImZpbGUiOiJsYWJvcmF0b3J5LmNvbXBvbmVudC5zY3NzIiwic291cmNlc0NvbnRlbnQiOlsiXHJcblxyXG50YWJsZSwgdGgsIHRkIHtcclxuICAgIGJvcmRlcjogMXB4IHNvbGlkIGJsYWNrO1xyXG4gICAgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTtcclxuICB9XHJcbiAgdGgge1xyXG4gICAgYmFja2dyb3VuZC1jb2xvcjogIzk2RDRENDtcclxuICB9XHJcblxyXG4gIC5lcnJvclxyXG4gIHtcclxuICAgIGNvbG9yOiByZWQ7XHJcbiAgfSJdfQ== */");

/***/ })

}]);
//# sourceMappingURL=views-laboratory-laboratory-module-es2015.js.map