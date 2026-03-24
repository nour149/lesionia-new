(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-dossier-dossier-module"],{

/***/ "1Psg":
/*!*********************************************!*\
  !*** ./src/app/services/dossier.service.ts ***!
  \*********************************************/
/*! exports provided: DossierService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DossierService", function() { return DossierService; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "IheW");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var ngx_cookie__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ngx-cookie */ "4pnn");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../environments/environment */ "AytR");





let DossierService = class DossierService {
    constructor(http, cookie) {
        this.http = http;
        this.cookie = cookie;
        this.baseurl = _environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].baseurl;
    }
    get_medical_checkup(patient_identifier) {
        return this.http.get(this.baseurl + "medical_checkup/all/" + patient_identifier, { observe: 'response' });
    }
    get_treatmenthistory(patient_identifier) {
        return this.http.get(this.baseurl + "treatmenthistory/all/" + patient_identifier, { observe: 'response' });
    }
    get_travel_residency(patient_identifier) {
        return this.http.get(this.baseurl + "travel_residency/get_all/" + patient_identifier, { observe: 'response' });
    }
    get_discrepancy(patient_identifier) {
        return this.http.get(this.baseurl + "discrepancy/all_my/" + patient_identifier, { observe: 'response' });
    }
    get_sample(patient_identifier) {
        return this.http.get(this.baseurl + "sample/all_my/" + patient_identifier, { observe: 'response' });
    }
    get_diognosis(idsample) {
        return this.http.get(this.baseurl + "diognosis/all_by_sample/" + idsample, { observe: 'response' });
    }
    clear() {
        this.cookie.remove('token');
    }
};
DossierService.ctorParameters = () => [
    { type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"] },
    { type: ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"] }
];
DossierService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"])({
        providedIn: 'root'
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], ngx_cookie__WEBPACK_IMPORTED_MODULE_3__["CookieService"]])
], DossierService);



/***/ }),

/***/ "KbmS":
/*!*********************************************************!*\
  !*** ./src/app/views/dossier/dossier-routing.module.ts ***!
  \*********************************************************/
/*! exports provided: DossierRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DossierRoutingModule", function() { return DossierRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _dossier_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./dossier.component */ "KcSb");




const routes = [
    {
        path: '',
        component: _dossier_component__WEBPACK_IMPORTED_MODULE_3__["DossierComponent"],
        data: {
            title: 'Dossier'
        }
    }
];
let DossierRoutingModule = class DossierRoutingModule {
};
DossierRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], DossierRoutingModule);



/***/ }),

/***/ "KcSb":
/*!****************************************************!*\
  !*** ./src/app/views/dossier/dossier.component.ts ***!
  \****************************************************/
/*! exports provided: DossierComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DossierComponent", function() { return DossierComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_dossier_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./dossier.component.html */ "NkEz");
/* harmony import */ var _dossier_component_css__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./dossier.component.css */ "R97u");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _services_dossier_service__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../services/dossier.service */ "1Psg");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/router */ "iInd");






let DossierComponent = class DossierComponent {
    constructor(dossierservice, router) {
        this.dossierservice = dossierservice;
        this.router = router;
        /* diognosis*/
        this.condition = false;
        this.text = "";
    }
    ngOnInit() {
        const id = localStorage.getItem('patientidentifier');
        this.get_all_medical_checkup(id);
        this.get_all_treatmenthistory(id);
        this.get_all_travel_residency(id);
        this.get_all_discrepancy(id);
        this.get_all_sample(id);
    }
    get_all_medical_checkup(patient_identifier) {
        this.dossierservice.get_medical_checkup(patient_identifier).subscribe(data => {
            if (data.status == 200) {
                this.medical_checkups = data.body;
                this.content_medical_checkup = true;
            }
            else if (data.status == 204) {
                this.content_medical_checkup = false;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
            }
        });
    }
    get_all_treatmenthistory(patient_identifier) {
        this.dossierservice.get_treatmenthistory(patient_identifier).subscribe(data => {
            if (data.status == 200) {
                this.treatmenthistorys = data.body;
                this.content_treatmenthistorys = true;
            }
            else if (data.status == 204) {
                this.content_treatmenthistorys = false;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
            }
        });
    }
    get_all_travel_residency(patient_identifier) {
        this.dossierservice.get_travel_residency(patient_identifier).subscribe(data => {
            if (data.status == 200) {
                this.travel_residencys = data.body;
                this.content_travel_residencys = true;
            }
            else if (data.status == 204) {
                this.content_travel_residencys = false;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
            }
        });
    }
    get_all_discrepancy(patient_identifier) {
        this.dossierservice.get_discrepancy(patient_identifier).subscribe(data => {
            if (data.status == 200) {
                this.content_discrepancy = true;
                this.discrepancys = data.body;
            }
            else if (data.status == 204) {
                this.content_discrepancy = false;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
            }
        });
    }
    get_all_sample(patient_identifier) {
        this.dossierservice.get_sample(patient_identifier).subscribe(data => {
            if (data.status == 200) {
                this.content_sample = true;
                this.samples = data.body;
            }
            else if (data.status == 204) {
                this.content_sample = false;
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
            }
        });
    }
    pass(idsample) {
        this.dossierservice.get_diognosis(idsample).subscribe(data => {
            if (data.status == 200) {
                this.diognosis = data.body;
                this.condition = true;
            }
            else if (data.status) {
                this.condition = false;
                this.text = "This sample hasent any diognosis";
            }
        }, (error) => {
            if (error) {
                console.log(error.message);
                console.log(error.status);
            }
        });
    }
};
DossierComponent.ctorParameters = () => [
    { type: _services_dossier_service__WEBPACK_IMPORTED_MODULE_4__["DossierService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_5__["Router"] }
];
DossierComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-dossier',
        template: _raw_loader_dossier_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_dossier_component_css__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_dossier_service__WEBPACK_IMPORTED_MODULE_4__["DossierService"], _angular_router__WEBPACK_IMPORTED_MODULE_5__["Router"]])
], DossierComponent);



/***/ }),

/***/ "NkEz":
/*!********************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/dossier/dossier.component.html ***!
  \********************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<!-- Medical checkup-->\n<div *ngIf=\"content_medical_checkup\">\n<div class=\"row\">\n  <div class=\"col-lg-12\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        <i class=\"fa fa-align-justify\"></i> Medical checkup\n      </div>\n      <div class=\"card-body\">\n        <table class=\"table table-bordered table-striped  table-responsive-lg\">\n          <thead>\n            <tr>\n              <th>ID</th>\n              <th>Date med</th>\n              <th>Hospital</th>\n              <th>Clincal state</th>\n              <th>Gendesc</th>\n              <th>Animal around</th>\n              <th>Lesnum</th>\n              <th>lesposss</th>\n              <th>Link human hosts</th>\n              <th>Possible human hosts</th>\n              <th>Physician</th>\n              <th>Sampler</th>\n              <th>Loginuser</th>\n            </tr>\n          </thead>\n          <tbody *ngFor=\" let medical_checkup of medical_checkups \">\n            <tr>\n              <td>{{medical_checkup.idmed}}</td>\n              <td>{{medical_checkup.date_MED}}</td>\n              <td>{{medical_checkup.hospital}}</td>\n              <td>{{medical_checkup.clinical_STATE}}</td>\n              <td>{{medical_checkup.gendesc}}</td>\n              <td>{{medical_checkup.animal_AROUND}}</td>\n              <td>{{medical_checkup.lesnum}}</td>\n              <td>{{medical_checkup.lesposss}}</td>\n              <td>{{medical_checkup.link_HUMAN_HOSTS}}</td>\n              <td>{{medical_checkup.possible_HUMAN_HOSTS}}</td>\n              <td>{{medical_checkup.physician}}</td>\n              <td>{{medical_checkup.sampler}}</td>\n              <td>{{medical_checkup.loginuser}}</td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>\n  </div>\n  <!--/.col-->\n</div>\n</div>\n<div *ngIf=\"!content_medical_checkup\">\n  <h2>This patient  doesn't have any medical_checkup</h2>\n</div>\n\n<!--  trteament history -->\n<div *ngIf=\"content_treatmenthistorys\">\n<div class=\"row\">\n  <div class=\"col-lg-12\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        <i class=\"fa fa-align-justify\"></i> Treatment history\n      </div>\n      <div class=\"card-body\">\n        <table class=\"table table-bordered table-striped  table-responsive-lg\">\n          <thead>\n            <tr>\n              <th>ID</th>\n              <th>Start date</th>\n              <th>Treatement type</th>\n              <th>Prescribedfor</th>\n              <th>Posology</th>\n              <th>Durationn</th>\n              <th>Injection number</th>\n              <th> Helaing date</th>\n              <th>Admin route</th>\n            </tr>\n          </thead>\n          <tbody *ngFor=\" let treatement of treatmenthistorys\">\n            <tr>\n              <td>{{treatement.idtreatment}}</td>\n              <td>{{treatement.start_DATE}}</td>\n              <td>{{treatement.treatment_TYPE}}</td>\n              <td>{{treatement.prescribedfor}}</td>\n              <td>{{treatement.posology}}</td>\n              <td>{{treatement.durationn}}</td>\n              <td>{{treatement.healing_DATE}}</td>\n              <td>{{treatement.injection_NUMBER}}</td>\n              <td>{{treatement.adminroute}}</td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>\n  </div>\n  <!--/.col-->\n</div>\n</div>\n<div *ngIf=\"!content_treatmenthistorys\">\n <h2>This patient  doesn't have treatment history</h2>\n</div>\n\n<!-- travel residency -->\n<div *ngIf=\"content_travel_residencys\">\n<div class=\"row\">\n  <div class=\"col-lg-12\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        <i class=\"fa fa-align-justify\"></i> Travel residency\n      </div>\n      <div class=\"card-body\">\n        <table class=\"table table-bordered table-striped  table-responsive-lg\">\n          <thead>\n            <tr>\n              <th>ID</th>\n              <th>City</th>\n              <th>Residency</th>\n              <th>Type</th>\n              <th>Fromdate</th>\n              <th>To date</th>\n              <th>Bytenot</th>\n            </tr>\n          </thead>\n          <tbody *ngFor=\" let travel of travel_residencys\">\n            <tr>\n              <td>{{travel.idmvt}}</td>\n              <td>{{travel.city}}</td>\n              <td>{{travel.residency}}</td>\n              <td>{{travel.type}}</td>\n              <td>{{travel.fromdate}}</td>\n              <td>{{travel.todate}}</td>\n              <td>{{travel.bytenot}}</td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>\n  </div>\n  <!--/.col-->\n</div>\n</div>\n<div *ngIf=\"!content_travel_residencys\" >\n<h2> This patient  doesn't have any travel residency</h2>\n</div>\n\n\n<!-- discrepancys-->\n<div *ngIf=\"content_discrepancy\">\n<div class=\"row\">\n  <div class=\"col-lg-12\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        <i class=\"fa fa-align-justify\"></i> Discrepancy\n      </div>\n      <div class=\"card-body\">\n        <table class=\"table table-bordered table-striped  table-responsive-lg\">\n          <thead>\n            <tr>\n              <th>ID</th>\n              <th>Date mediacal checkup</th>\n              <th>Description</th>\n              <th>Date discrepancy</th>\n            </tr>\n          </thead>\n          <tbody *ngFor=\" let discrepancy of discrepancys\">\n            <tr>\n              <td>{{discrepancy.iddiscrepancy}}</td>\n              <td>{{discrepancy.datemed}}</td>\n              <td>{{discrepancy.description}}</td>\n              <td>{{discrepancy.date_disc |date :'dd/MM/yy HH:mm:ss':'GMT+1'}}</td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>\n  </div>\n  <!--/.col-->\n</div>\n</div>\n<div *ngIf=\"!content_discrepancy\">\n  <h2>This patient  doesn't have any discrepancy</h2>\n</div>\n<!-- sample -->\n\n<div *ngIf=\"content_sample\">\n<div class=\"row\">\n  <div class=\"col-lg-12\">\n    <div class=\"card\">\n      <div class=\"card-header\">\n        <i class=\"fa fa-align-justify\"></i> Samples\n      </div>\n      <div class=\"card-body\">\n        <table class=\"table table-bordered table-striped  table-responsive\">\n          <thead>\n            <tr>\n              <th>ID</th>\n              <th>date_First_Apeard</th>\n              <th>date_EXTRACTION</th>\n              <th>abudance_ON_THE_SMEAR</th>\n              <th>description</th>\n              <th>diametremax</th>\n              <th>diametremin</th>\n              <th>direct_EXAMINATION</th>\n              <th>hight</th>\n              <th>lesion_Age</th>\n              <th>lesion_SITE_SAMPLED</th>\n              <th>localisation</th>\n              <th>sampling_METHOD</th>\n              <th>species</th>\n              <th>type_OF_SAMPLE_SUPPORT_</th>\n              <th>check </th>\n            </tr>\n          </thead>\n          <tbody *ngFor=\" let sample of samples\">\n            <tr>\n              <td>{{sample.idsample}}</td>\n              <td>{{sample.date_First_Apeard}}</td>\n              <td>{{sample.date_EXTRACTION}}</td>\n              <td>{{sample.abudance_ON_THE_SMEAR}}</td>\n              <td>{{sample.description}}</td>\n              <td>{{sample.diametremax}}</td>\n              <td>{{sample.diametremin}}</td>\n              <td>{{sample.direct_EXAMINATION}}</td>\n              <td>{{sample.hight}}</td>\n              <td>{{sample.lesion_Age}}</td>\n              <td>{{sample.lesion_SITE_SAMPLED}}</td>\n              <td>{{sample.localisation}}</td>\n              <td>{{sample.sampling_METHOD}}</td>\n              <td>{{sample.species}}</td>\n              <td>{{sample.type_OF_SAMPLE_SUPPORT_}}</td>\n              <td> <button type=\"button\" class=\"btn btn-dark\" (click)=\"pass(sample.idsample)\"><i class=\"cil-folder\"></i>\n                </button></td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>\n  </div>\n  <!--/.col-->\n</div>\n</div>\n<div *ngIf=\"!content_sample\">\n  <h2>This patient  doesn't have any sample </h2>\n</div>\n\n<!-- diognosis -->\n<div *ngIf=\"condition; then thenBlock else elseBlock\"></div>\n<ng-template #thenBlock>\n  <div class=\"row\">\n    <div class=\"col-lg-12\">\n      <div class=\"card\">\n        <div class=\"card-header\">\n          <i class=\"fa fa-align-justify\"></i> Diognosis\n        </div>\n        <div class=\"card-body\">\n          <table class=\"table table-bordered table-striped  table-responsive-lg\">\n            <thead>\n              <tr>\n                <th>Id diagnosis</th>\n                <th>Diagnosis date</th>\n                <th>Laboratoryname</th>\n                <th>Leishsuspect</th>\n                <th>Quantite</th>\n                <th> Result</th>\n                <th>Test</th>\n              </tr>\n            </thead>\n            <tbody *ngFor=\" let dio of diognosis\">\n              <tr>\n                <td>{{dio.iddiagnosis}}</td>\n                <td>{{dio.diagnosisdate}}</td>\n                <td>{{dio.laboratoryname}}</td>\n                <td>{{dio.leishsuspect}}</td>\n                <td>{{dio.quantite}}</td>\n                <td>{{dio.result}}</td>\n                <td>test</td>\n              </tr>\n            </tbody>\n          </table>\n        </div>\n      </div>\n    </div>\n    <!--/.col-->\n  </div>\n\n</ng-template>\n<!--false -->\n<ng-template #elseBlock><h2>{{text}}</h2></ng-template>");

/***/ }),

/***/ "R97u":
/*!*****************************************************!*\
  !*** ./src/app/views/dossier/dossier.component.css ***!
  \*****************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\r\n    border: 0.5px solid black;\r\n    border-collapse: collapse;\r\n  }\r\n  th {\r\n    background-color: #96D4D4;\r\n  }\r\n  \r\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImRvc3NpZXIuY29tcG9uZW50LmNzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtJQUNJLHlCQUF5QjtJQUN6Qix5QkFBeUI7RUFDM0I7RUFDQTtJQUNFLHlCQUF5QjtFQUMzQiIsImZpbGUiOiJkb3NzaWVyLmNvbXBvbmVudC5jc3MiLCJzb3VyY2VzQ29udGVudCI6WyJ0YWJsZSwgdGgsIHRkIHtcclxuICAgIGJvcmRlcjogMC41cHggc29saWQgYmxhY2s7XHJcbiAgICBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlO1xyXG4gIH1cclxuICB0aCB7XHJcbiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjOTZENEQ0O1xyXG4gIH1cclxuICAiXX0= */");

/***/ }),

/***/ "n3jh":
/*!*************************************************!*\
  !*** ./src/app/views/dossier/dossier.module.ts ***!
  \*************************************************/
/*! exports provided: DossiertModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DossiertModule", function() { return DossiertModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _dossier_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./dossier.component */ "KcSb");
/* harmony import */ var _dossier_routing_module__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./dossier-routing.module */ "KbmS");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var ngx_pagination__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ngx-pagination */ "oOf3");






let DossiertModule = class DossiertModule {
};
DossiertModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_4__["CommonModule"],
            _dossier_routing_module__WEBPACK_IMPORTED_MODULE_3__["DossierRoutingModule"],
            ngx_pagination__WEBPACK_IMPORTED_MODULE_5__["NgxPaginationModule"]
        ],
        declarations: [_dossier_component__WEBPACK_IMPORTED_MODULE_2__["DossierComponent"]]
    })
], DossiertModule);



/***/ })

}]);
//# sourceMappingURL=views-dossier-dossier-module-es2015.js.map