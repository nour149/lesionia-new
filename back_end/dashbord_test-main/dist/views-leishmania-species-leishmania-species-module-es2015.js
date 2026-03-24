(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-leishmania-species-leishmania-species-module"],{

/***/ "F/8w":
/*!********************************************************!*\
  !*** ./src/app/services/leishmania-species.service.ts ***!
  \********************************************************/
/*! exports provided: LeishmaniaSpeciesService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LeishmaniaSpeciesService", function() { return LeishmaniaSpeciesService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let LeishmaniaSpeciesService = class LeishmaniaSpeciesService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_all_species() {
        return this.http.get(this.baseurl + "leishmania_species/all", { observe: 'response' });
    }
    delete_species(name) {
        return this.http.delete(this.baseurl + "leishmania_species/?id=" + name, { responseType: 'text' });
    }
    add_species(leishmania_species) {
        return this.http.post(this.baseurl + "leishmania_species/save", leishmania_species, { responseType: 'text' });
    }
    update_species(leishmania_species) {
        return this.http.post(this.baseurl + "leishmania_species/update", leishmania_species, { responseType: 'text' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
LeishmaniaSpeciesService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
LeishmaniaSpeciesService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], LeishmaniaSpeciesService);



/***/ }),

/***/ "P3/D":
/*!**************************************************************************!*\
  !*** ./src/app/views/leishmania-species/leishmania-species.component.ts ***!
  \**************************************************************************/
/*! exports provided: LeishmaniaSpeciesComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LeishmaniaSpeciesComponent", function() { return LeishmaniaSpeciesComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_leishmania_species_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./leishmania-species.component.html */ "sjtO");
/* harmony import */ var _leishmania_species_component_scss__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./leishmania-species.component.scss */ "cxfv");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_leishmania_species_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/leishmania-species.service */ "F/8w");






let LeishmaniaSpeciesComponent = class LeishmaniaSpeciesComponent {
    constructor(LeishmaniaSpeciesService, router) {
        this.LeishmaniaSpeciesService = LeishmaniaSpeciesService;
        this.router = router;
        this.new_value = "";
        this.alertsDismiss = [];
    }
    ngOnInit() {
        this.get_leishmania_species();
    }
    get_leishmania_species() {
        this.LeishmaniaSpeciesService.get_all_species().subscribe(data => {
            if (data.status == 200) {
                this.speciess = data.body;
                this.content_speciess = true;
            }
            else if (data.status == 204) {
                this.content_speciess = false;
            }
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.LeishmaniaSpeciesService.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    update(species) {
        if (window.confirm('Are you sure')) {
            this.new_value = document.getElementById("species_update_information").value;
            species.information = this.new_value;
            this.LeishmaniaSpeciesService.update_species(species).subscribe((response) => {
                this.get_leishmania_species();
                this.alert('Leishmania species successfully updated', 'warning');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    set(species) {
        this.species_update = species;
        document.getElementById("species_update_information").value = species.information;
    }
    hide() {
        let element = document.getElementById('r');
        element.click();
    }
    cancel_add(species) {
        species.resetForm();
        this.existe = false;
    }
    delete(species) {
        if (window.confirm('Are you sure')) {
            this.LeishmaniaSpeciesService.delete_species(species).subscribe((response) => {
                this.get_leishmania_species();
                this.alert('Leishmania species successfully deleted', 'danger');
            }, (error) => {
                if (error) {
                    console.log(error.message);
                    console.log(error.status);
                }
            });
        }
    }
    add(leishmania_species) {
        console.log(leishmania_species.value);
        this.LeishmaniaSpeciesService.add_species(leishmania_species.value).subscribe((response) => {
            if (response == "201") {
                this.existe = false;
                this.get_leishmania_species();
                this.alert('Leishmania species successfully added', 'primary');
                leishmania_species.resetForm();
                this.hide();
            }
            else if (response == "200") {
                this.existe = true;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
                console.log(error.status);
            }
        });
    }
    alert(msg, type) {
        this.alertsDismiss.push({
            type: type,
            msg: msg,
            timeout: 2500
        });
    }
};
LeishmaniaSpeciesComponent.ctorParameters = () => [
    { type: _services_leishmania_species_service__WEBPACK_IMPORTED_MODULE_5__["LeishmaniaSpeciesService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }
];
LeishmaniaSpeciesComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-leishmania-species',
        template: _raw_loader_leishmania_species_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_leishmania_species_component_scss__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_leishmania_species_service__WEBPACK_IMPORTED_MODULE_5__["LeishmaniaSpeciesService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]])
], LeishmaniaSpeciesComponent);



/***/ }),

/***/ "Sz2J":
/*!*******************************************************************************!*\
  !*** ./src/app/views/leishmania-species/leishmania_species-routing.module.ts ***!
  \*******************************************************************************/
/*! exports provided: leishmaniaSpeciesRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "leishmaniaSpeciesRoutingModule", function() { return leishmaniaSpeciesRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _leishmania_species_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./leishmania-species.component */ "P3/D");




const routes = [
    {
        path: '',
        component: _leishmania_species_component__WEBPACK_IMPORTED_MODULE_3__["LeishmaniaSpeciesComponent"],
        data: {
            title: 'leishmania-species'
        }
    }
];
let leishmaniaSpeciesRoutingModule = class leishmaniaSpeciesRoutingModule {
};
leishmaniaSpeciesRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], leishmaniaSpeciesRoutingModule);



/***/ }),

/***/ "THWx":
/*!***********************************************************************!*\
  !*** ./src/app/views/leishmania-species/leishmania-species.module.ts ***!
  \***********************************************************************/
/*! exports provided: LeishmaniaSpeciesModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LeishmaniaSpeciesModule", function() { return LeishmaniaSpeciesModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var ngx_pagination__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-pagination */ "oOf3");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var _leishmania_species_routing_module__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./leishmania_species-routing.module */ "Sz2J");
/* harmony import */ var _leishmania_species_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./leishmania-species.component */ "P3/D");
/* harmony import */ var ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ngx-bootstrap/alert */ "CNMR");








let LeishmaniaSpeciesModule = class LeishmaniaSpeciesModule {
};
LeishmaniaSpeciesModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_2__["CommonModule"],
            _leishmania_species_routing_module__WEBPACK_IMPORTED_MODULE_5__["leishmaniaSpeciesRoutingModule"],
            ngx_pagination__WEBPACK_IMPORTED_MODULE_3__["NgxPaginationModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_4__["ReactiveFormsModule"],
            ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_7__["AlertModule"].forRoot(),
            _angular_forms__WEBPACK_IMPORTED_MODULE_4__["FormsModule"]
        ],
        declarations: [_leishmania_species_component__WEBPACK_IMPORTED_MODULE_6__["LeishmaniaSpeciesComponent"]]
    })
], LeishmaniaSpeciesModule);



/***/ }),

/***/ "cxfv":
/*!****************************************************************************!*\
  !*** ./src/app/views/leishmania-species/leishmania-species.component.scss ***!
  \****************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\n  border: 1px solid black;\n  border-collapse: collapse;\n}\n\nth {\n  background-color: #96D4D4;\n}\n\n.error {\n  color: red;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxsZWlzaG1hbmlhLXNwZWNpZXMuY29tcG9uZW50LnNjc3MiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQ0E7RUFDSSx1QkFBQTtFQUNBLHlCQUFBO0FBQUo7O0FBRUU7RUFDRSx5QkFBQTtBQUNKOztBQUVFO0VBRUUsVUFBQTtBQUFKIiwiZmlsZSI6ImxlaXNobWFuaWEtc3BlY2llcy5jb21wb25lbnQuc2NzcyIsInNvdXJjZXNDb250ZW50IjpbIlxyXG50YWJsZSwgdGgsIHRkIHtcclxuICAgIGJvcmRlcjogMXB4IHNvbGlkIGJsYWNrO1xyXG4gICAgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTtcclxuICB9XHJcbiAgdGgge1xyXG4gICAgYmFja2dyb3VuZC1jb2xvcjogIzk2RDRENDtcclxuICB9XHJcblxyXG4gIC5lcnJvclxyXG4gIHtcclxuICAgIGNvbG9yOiByZWQ7XHJcbiAgfSJdfQ== */");

/***/ }),

/***/ "sjtO":
/*!******************************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/leishmania-species/leishmania-species.component.html ***!
  \******************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<!-- Button trigger modal -->\n<div class=\"col-md-12 text-center\">\n    <button type=\"button\" class=\"btn btn-primary btn-center\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n        Add new Leishmania species\n    </button>\n</div>\n<br>\n<div *ngFor=\"let alert of alertsDismiss\">\n    <alert [type]=\"alert.type\" [dismissOnTimeout]=\"alert.timeout\">{{alert.msg}}</alert>\n  </div>\n<div *ngIf=\"content_speciess\">\n    <div class=\"table-responsive -sm\">\n        <table class=\"table\">\n            <thead class=\"thead-primary \">\n                <tr>\n                    <th scope=\"col\">Species</th>\n                    <th scope=\"col\">Information</th>\n                    <th scope=\"col\">Edit</th>\n                    <th scope=\"col\">Delete</th>\n                </tr>\n            </thead>\n\n            <tbody *ngFor=\" let species of speciess\">\n                <tr>\n                    <td>{{species.species}}</td>\n                    <td>{{species.information}}</td>\n                    <td>\n                        <div class=\"text-center\">\n                        <button (click)=\"set(species)\" type=\"button\" data-toggle=\"modal\" data-target=\"#edit\"\n                            class=\"btn btn-outline-warning\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\"\n                                height=\"20\" fill=\"currentColor\" class=\"bi bi-pencil\" viewBox=\"0 0 16 16\">\n                                <path\n                                    d=\"M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z\" />\n                            </svg> </button>\n                            </div>\n                    </td>\n                    <td>\n                        <div class=\"text-center\">\n                        <button class=\"btn btn-outline-danger center\" (click)=\"delete(species.species)\">\n                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"currentColor\"\n                                class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\n                                <path\n                                    d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\" />\n                                <path fill-rule=\"evenodd\"\n                                    d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\" />\n                            </svg>\n                        </button>\n                        </div>\n                    </td>\n            </tbody>\n        </table>\n    </div>\n</div>\n<div *ngIf=\"!content_speciess\">\n    <h2>There is no species found yet\n    </h2>\n</div>\n\n<!-- Modal -->\n<div class=\"modal fade\" id=\"edit\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">Update</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <div class=\"form-group\">\n                    <label for=\"species_update.species\">Species</label>\n                    <input type=\"text\" id=\"species_update.species\" ngModel={{species_update?.species}}\n                        class=\"form-control\" readonly>\n                </div>\n                <form #form='ngForm'>\n                    <div class=\"form-group\">\n                        <label for=\"species_update?.information}\">Information</label>\n                        <input type=\"text\" id=\"species_update_information\" ngModel={{species_update?.information}}\n                            class=\"form-control\" required minlength=\"3\">\n                    </div>\n                    <div class=\"modal-footer\">\n                        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n                        <button type=\"submit\" (click)=\"update(species_update)\" class=\"btn btn-primary\"\n                            data-dismiss=\"modal\" [disabled]=\"form.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>\n\n\n<!-- Modal -->\n<div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\"\n    aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n        <div class=\"modal-content\">\n            <div class=\"modal-header\">\n                <h5 class=\"modal-title\" id=\"exampleModalLabel\">New Leishmania species</h5>\n                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\" aria-label=\"Close\">\n                    <span aria-hidden=\"true\">&times; </span>\n                </button>\n            </div>\n            <div class=\"modal-body\">\n                <form #form_add='ngForm' (ngSubmit)=\"add(form_add)\">\n\n                    <div class=\"form-group\">\n                        <label for=\"species\">Species</label>\n                        <input type=\"text\" id=\"species\" input name=\"species\" ngModel required\n                            #species=\"ngModel\" class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <span *ngIf=\"existe\">\n                        <h5 class=\"error\">This Species already exist</h5>\n                    </span>\n                    <div class=\"form-group\">\n                        <label for=\"information\">Information</label>\n                        <input type=\"text\" id=\"information\" input name=\"information\" ngModel required #information=\"ngModel\"\n                            class=\"form-control\" minlength=\"3\">\n                    </div>\n                    <div class=\"modal-footer\">\n                        <button id=\"r\" type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\">Cancel</button>\n                        <button type=\"submit\" class=\"btn btn-primary\" [disabled]=\"form_add.invalid\">Save </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>");

/***/ })

}]);
//# sourceMappingURL=views-leishmania-species-leishmania-species-module-es2015.js.map