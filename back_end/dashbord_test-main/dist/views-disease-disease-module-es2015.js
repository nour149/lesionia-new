(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-disease-disease-module"],{

/***/ "+RqI":
/*!*********************************************************!*\
  !*** ./src/app/views/disease/disease-routing.module.ts ***!
  \*********************************************************/
/*! exports provided: DiseaseRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DiseaseRoutingModule", function() { return DiseaseRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _disease_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./disease.component */ "WWby");




const routes = [
    {
        path: '',
        component: _disease_component__WEBPACK_IMPORTED_MODULE_3__["DiseaseComponent"],
        data: {
            title: 'Disease'
        }
    }
];
let DiseaseRoutingModule = class DiseaseRoutingModule {
};
DiseaseRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], DiseaseRoutingModule);



/***/ }),

/***/ "AdbA":
/*!*************************************************!*\
  !*** ./src/app/views/disease/disease.module.ts ***!
  \*************************************************/
/*! exports provided: DiseaseModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DiseaseModule", function() { return DiseaseModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _disease_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./disease.component */ "WWby");
/* harmony import */ var _disease_routing_module__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./disease-routing.module */ "+RqI");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var ngx_pagination__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ngx-pagination */ "oOf3");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ngx-bootstrap/alert */ "CNMR");








let DiseaseModule = class DiseaseModule {
};
DiseaseModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_4__["CommonModule"],
            _disease_routing_module__WEBPACK_IMPORTED_MODULE_3__["DiseaseRoutingModule"],
            ngx_pagination__WEBPACK_IMPORTED_MODULE_5__["NgxPaginationModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_6__["ReactiveFormsModule"],
            ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__["AlertModule"].forRoot(),
            _angular_forms__WEBPACK_IMPORTED_MODULE_6__["FormsModule"]
        ],
        declarations: [_disease_component__WEBPACK_IMPORTED_MODULE_2__["DiseaseComponent"]]
    })
], DiseaseModule);



/***/ }),

/***/ "Qp58":
/*!********************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/disease/disease.component.html ***!
  \********************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<div class=\"col-md-12 text-center\">\n    <button type=\"button\" class=\"btn btn-primary btn-center\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n        Add new disease\n    </button>\n</div>\n<br>\n<div *ngFor=\"let alert of alertsDismiss\">\n    <alert [type]=\"alert.type\" [dismissOnTimeout]=\"alert.timeout\">{{alert.msg}}</alert>\n</div>\n<div *ngIf=\"content_disease\">\n<div class=\"table-responsive -sm\">\n    <table class=\"table\">\n        <thead class=\"thead-primary \">\n            <tr>\n                <th scope=\"col\">Class Id</th>\n                <th scope=\"col\">Class Name</th>\n                <th scope=\"col\">Edit</th>\n                <th scope=\"col\">Delete</th>\n            </tr>\n        </thead>\n        \n        <tbody *ngFor=\" let disease of diseases\">\n            <tr>\n                <td>{{disease.classid}}</td>\n                <td>{{disease.classname}}</td>\n              \n              <td>\n                <div class=\"text-center\">\n                <button (click)=\"set(disease)\" type=\"button\" data-toggle=\"modal\" data-target=\"#edit\"\n                    class=\"btn btn-outline-warning\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\"\n                        fill=\"currentColor\" class=\"bi bi-pencil\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z\" />\n                    </svg> </button>\n                    </div>\n            </td>\n            \n            <td>\n                <div class=\"text-center\">\n                <button class=\"btn btn-outline-danger center\" (click)=\"delete(disease.classid)\">\n                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"currentColor\"\n                        class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\" />\n                        <path fill-rule=\"evenodd\"\n                            d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\" />\n                    </svg>\n                </button>\n            </div></td>\n            </tr>\n           \n          </tbody>\n    </table>\n</div>  \n</div>\n<div *ngIf=\"!content_disease\">\n    <h2>There is no disease found yet\n  </h2>\n  </div>\n\n  <div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\"\n    aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">New disease</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <form #form_add='ngForm' (ngSubmit)=\"add_disease(form_add)\">\n\n                    <div class=\"form-group\">\n                        <label for=\"classname\">Class id</label>\n                        <input type=\"text\" id=\"classid\" input name=\"classid\" ngModel required\n                            #classid=\"ngModel\" class=\"form-control\" minlength=\"1\">\n                    </div>\n                    <span *ngIf=\"existe\">\n                        <h5 class=\"error\">This Class id already exist</h5>\n                    </span>\n                    <div class=\"form-group\">\n                        <label for=\"classname\">Class Name</label>\n                        <input type=\"text\" id=\"classname\" input name=\"classname\" ngModel required #classname=\"ngModel\"\n                            class=\"form-control\" minlength=\"1\">\n                    </div>\n                    <div class=\"modal-footer\">\n                        <button id=\"r\" type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\">Cancel</button>\n                        <button type=\"submit\" class=\"btn btn-primary\" [disabled]=\"form_add.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>\n\n\n<div class=\"modal fade\" id=\"edit\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">Update</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <div class=\"form-group\">\n                    <label for=\"disease_classid\">Class Id</label>\n                    <input type=\"text\" id=\"disease_update_classid\" ngModel={{disease_update?.classid}}\n                        class=\"form-control\" readonly>\n                </div>\n                <form #form='ngForm'>\n                    <div class=\"form-group\">\n                        <label for=\"disease_update_classname\">Class Name</label>\n                        <input type=\"text\" id=\"disease_update_classename\" ngModel={{disease_update?.classname}}\n                            class=\"form-control\" required minlength=\"2\">\n                    </div>\n\n\n                    <div class=\"modal-footer\">\n                        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n                        <button type=\"submit\" (click)=\"update(disease_update)\" class=\"btn btn-primary\" data-dismiss=\"modal\"\n                            [disabled]=\"form.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>");

/***/ }),

/***/ "WWby":
/*!****************************************************!*\
  !*** ./src/app/views/disease/disease.component.ts ***!
  \****************************************************/
/*! exports provided: DiseaseComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DiseaseComponent", function() { return DiseaseComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_disease_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./disease.component.html */ "Qp58");
/* harmony import */ var _disease_component_scss__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./disease.component.scss */ "Yer5");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_disease_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/disease.service */ "aldN");






let DiseaseComponent = class DiseaseComponent {
    constructor(DiseaseService, router) {
        this.DiseaseService = DiseaseService;
        this.router = router;
        this.alertsDismiss = [];
        this.new_value = "";
    }
    ngOnInit() {
        this.get_all();
    }
    get_all() {
        this.DiseaseService.get_all_disease().subscribe(data => {
            if (data.status == 200) {
                this.diseases = data.body;
                this.content_disease = true;
            }
            else if (data.status == 204) {
                this.content_disease = false;
            }
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.DiseaseService.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    add_disease(disease) {
        this.new_disease = disease.value;
        this.DiseaseService.add(this.new_disease).subscribe((response) => {
            if (response == "201") {
                this.existe = false;
                this.get_all();
                this.alert('Disease successfully added', 'primary');
                disease.resetForm();
                this.hide();
            }
            else if (response == "200") {
                this.existe = true;
            }
        }, (error) => {
            if (error) {
                if (error.status == 403) {
                    localStorage.clear();
                    this.DiseaseService.clear();
                    this.router.navigateByUrl('/login');
                }
            }
        });
    }
    hide() {
        let element = document.getElementById('r');
        element.click();
    }
    cancel_add(disease) {
        disease.resetForm();
        this.existe = false;
    }
    alert(msg, type) {
        this.alertsDismiss.push({
            type: type,
            msg: msg,
            timeout: 2500
        });
    }
    delete(classid) {
        if (window.confirm('Are you sure')) {
            this.DiseaseService.delete(classid).subscribe((response) => {
                this.get_all();
                this.alert('Disease successfully deleted', 'danger');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    update(disease) {
        if (window.confirm('Are you sure')) {
            this.new_value = document.getElementById("disease_update_classename").value;
            disease.classname = this.new_value;
            this.DiseaseService.update(disease).subscribe((response) => {
                this.get_all();
                this.alert('Disease successfully updated', 'warning');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    set(disease) {
        this.disease_update = disease;
        document.getElementById("disease_update_classename").value = disease.classname;
    }
};
DiseaseComponent.ctorParameters = () => [
    { type: _services_disease_service__WEBPACK_IMPORTED_MODULE_5__["DiseaseService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }
];
DiseaseComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-disease',
        template: _raw_loader_disease_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_disease_component_scss__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_disease_service__WEBPACK_IMPORTED_MODULE_5__["DiseaseService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]])
], DiseaseComponent);



/***/ }),

/***/ "Yer5":
/*!******************************************************!*\
  !*** ./src/app/views/disease/disease.component.scss ***!
  \******************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\n  border: 1px solid black;\n  border-collapse: collapse;\n}\n\nth {\n  background-color: #96D4D4;\n}\n\n.error {\n  color: red;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxkaXNlYXNlLmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0VBQ0ksdUJBQUE7RUFDQSx5QkFBQTtBQUNKOztBQUNFO0VBQ0UseUJBQUE7QUFFSjs7QUFDRTtFQUVFLFVBQUE7QUFDSiIsImZpbGUiOiJkaXNlYXNlLmNvbXBvbmVudC5zY3NzIiwic291cmNlc0NvbnRlbnQiOlsidGFibGUsIHRoLCB0ZCB7XHJcbiAgICBib3JkZXI6IDFweCBzb2xpZCBibGFjaztcclxuICAgIGJvcmRlci1jb2xsYXBzZTogY29sbGFwc2U7XHJcbiAgfVxyXG4gIHRoIHtcclxuICAgIGJhY2tncm91bmQtY29sb3I6ICM5NkQ0RDQ7XHJcbiAgfVxyXG5cclxuICAuZXJyb3JcclxuICB7XHJcbiAgICBjb2xvcjogcmVkO1xyXG4gIH0iXX0= */");

/***/ }),

/***/ "aldN":
/*!*********************************************!*\
  !*** ./src/app/services/disease.service.ts ***!
  \*********************************************/
/*! exports provided: DiseaseService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DiseaseService", function() { return DiseaseService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let DiseaseService = class DiseaseService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_all_disease() {
        return this.http.get(this.baseurl + "disease/all", { observe: 'response' });
    }
    delete(classid) {
        return this.http.delete(this.baseurl + "disease/?id=" + classid, { responseType: 'text' });
    }
    add(disease) {
        return this.http.post(this.baseurl + "disease/save", disease, { responseType: 'text' });
    }
    update(disease) {
        return this.http.post(this.baseurl + "disease/update", disease, { responseType: 'text' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
DiseaseService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
DiseaseService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], DiseaseService);



/***/ })

}]);
//# sourceMappingURL=views-disease-disease-module-es2015.js.map