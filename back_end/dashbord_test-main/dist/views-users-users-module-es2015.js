(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["views-users-users-module"],{

/***/ "QSsw":
/*!*********************************************!*\
  !*** ./src/app/views/users/users.module.ts ***!
  \*********************************************/
/*! exports provided: UsersModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UsersModule", function() { return UsersModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _users_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./users.component */ "xSMm");
/* harmony import */ var _users_routing_module__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./users-routing.module */ "VY+B");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ "SVse");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/forms */ "s7LF");
/* harmony import */ var ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ngx-bootstrap/alert */ "CNMR");







let UsersModule = class UsersModule {
};
UsersModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [
            _angular_common__WEBPACK_IMPORTED_MODULE_4__["CommonModule"],
            _users_routing_module__WEBPACK_IMPORTED_MODULE_3__["UsersRoutingModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_5__["ReactiveFormsModule"],
            ngx_bootstrap_alert__WEBPACK_IMPORTED_MODULE_6__["AlertModule"].forRoot(),
            _angular_forms__WEBPACK_IMPORTED_MODULE_5__["FormsModule"]
        ],
        declarations: [_users_component__WEBPACK_IMPORTED_MODULE_2__["UsersComponent"]]
    })
], UsersModule);



/***/ }),

/***/ "SmPd":
/*!**************************************************!*\
  !*** ./src/app/views/users/users.component.scss ***!
  \**************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("table, th, td {\n  border: 0.5px solid black;\n  border-collapse: collapse;\n}\n\nth {\n  background-color: #96D4D4;\n}\n\n.error {\n  color: red;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFx1c2Vycy5jb21wb25lbnQuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNJLHlCQUFBO0VBQ0EseUJBQUE7QUFDSjs7QUFDRTtFQUNFLHlCQUFBO0FBRUo7O0FBQ0U7RUFFRSxVQUFBO0FBQ0oiLCJmaWxlIjoidXNlcnMuY29tcG9uZW50LnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyJ0YWJsZSwgdGgsIHRkIHtcclxuICAgIGJvcmRlcjogMC41cHggc29saWQgYmxhY2s7XHJcbiAgICBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlO1xyXG4gIH1cclxuICB0aCB7XHJcbiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjOTZENEQ0O1xyXG4gIH1cclxuXHJcbiAgLmVycm9yXHJcbiAge1xyXG4gICAgY29sb3I6IHJlZDtcclxuICB9Il19 */");

/***/ }),

/***/ "VY+B":
/*!*****************************************************!*\
  !*** ./src/app/views/users/users-routing.module.ts ***!
  \*****************************************************/
/*! exports provided: UsersRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UsersRoutingModule", function() { return UsersRoutingModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _users_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./users.component */ "xSMm");




const routes = [
    {
        path: '',
        component: _users_component__WEBPACK_IMPORTED_MODULE_3__["UsersComponent"],
        data: {
            title: 'users'
        }
    }
];
let UsersRoutingModule = class UsersRoutingModule {
};
UsersRoutingModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"].forChild(routes)],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterModule"]]
    })
], UsersRoutingModule);



/***/ }),

/***/ "tvqY":
/*!****************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/views/users/users.component.html ***!
  \****************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<div class=\"col-md-12 text-center\">\n  <button type=\"button\" class=\"btn btn-primary btn-center\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"50\" height=\"50\" fill=\"currentColor\" class=\"bi bi-person-plus-fill\"\n    viewBox=\"0 0 16 16\">\n    <path d=\"M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z\" />\n    <path fill-rule=\"evenodd\"\n      d=\"M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z\" />\n  </svg>\n  </button>\n</div>\n<br><br>\n<div *ngFor=\"let alert of alertsDismiss\">\n  <alert [type]=\"alert.type\" [dismissOnTimeout]=\"alert.timeout\">{{alert.msg}}</alert>\n</div>\n<div *ngIf=\"content\">\n  <table class=\" table table-responsive-xl\">\n    <thead>\n      <tr>\n        <th scope=\"col\">Loginuser</th>\n        <th scope=\"col\">Frominst</th>\n        <th scope=\"col\">Email</th>\n        <th scope=\"col\">Levelsecure</th>\n        <th scope=\"col\">Use_LOGINUSER</th>\n        <th scope=\"col\">More Details</th>\n        <th scope=\"col\">Update</th>\n        <th scope=\"col\">Delete</th>\n\n      </tr>\n    </thead>\n    <tbody *ngFor=\" let user of users\">\n      <tr>\n        <td>{{user.loginuser}}</td>\n        <td>{{user.frominst}}</td>\n        <td>{{user.email}}</td>\n        <td>{{user.levelsecure}}</td>\n        <td>{{user.use_LOGINUSER}}</td>\n        <td>\n          <div class=\"text-center\">\n          <button type=\"button\" class=\"btn btn-info\" data-toggle=\"modal\" data-target=\"#interrogator_informations\"\n            (click)=\"get_interrogator(user.loginuser)\">\n            <i class=\"cil-user\"></i>\n          </button>\n          </div>\n        </td>\n        <td>\n          <div class=\"text-center\">\n          <button class=\"text-center\" (click)=\"set(user)\" type=\"button\" data-toggle=\"modal\" data-target=\"#update_information\"\n              class=\"btn btn-outline-warning\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\"\n                  height=\"20\" fill=\"currentColor\" class=\"bi bi-pencil\" viewBox=\"0 0 16 16\">\n                  <path\n                      d=\"M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z\" />\n              </svg> </button>\n              </div>\n      </td>\n      <td><button class=\"btn btn-outline-danger center\" (click)=\"delete(user.loginuser)\">\n        <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"currentColor\"\n            class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\n            <path\n                d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\" />\n            <path fill-rule=\"evenodd\"\n                d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\" />\n        </svg>\n    </button></td>\n      </tr>\n\n    </tbody>\n  </table>\n\n\n\n  <!-- Modal -->\n  <div class=\"modal fade\" id=\"interrogator_informations\" tabindex=\"-1\" role=\"dialog\"\n    aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n    <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n      <div class=\"modal-content\">\n        <div class=\"modal-header\">\n          <h5 class=\"modal-title\" id=\"exampleModalLongTitle\">Informations</h5>\n          <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n            <span aria-hidden=\"true\">&times;</span>\n          </button>\n        </div>\n        <div class=\"modal-body\">\n          <div class=\"table-responsive-lg\">\n            <table class=\"table\">\n              <thead>\n                <tr>\n                  <th scope=\"col\">ID</th>\n                  <th scope=\"col\">First Name</th>\n                  <th scope=\"col\">Last Name</th>\n                  <th scope=\"col\">Quality</th>\n                </tr>\n              </thead>\n              <tbody>\n                <tr>\n                  <td> {{interrogator?.id_INTERROGATOR}}</td>\n                  <td>{{interrogator?.first_NAME_INTERROGATOR}}</td>\n                  <td>{{interrogator?.last_NAME_INTERROGATOR}} </td>\n                  <td> {{interrogator?.quality}}</td>\n                </tr>\n              </tbody>\n            </table>\n          </div>\n        </div>\n        \n      </div>\n    </div>\n  </div>\n\n  <div *ngIf=\"!content\">\n    <h2>Nothing</h2>\n  </div>\n\n  <br><br>\n \n  <!-- Modal -->\n  <div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\"\n    aria-hidden=\"true\">\n    <div class=\"modal-dialog\" role=\"document\">\n      <div class=\"modal-content\">\n        <div class=\"modal-header\">\n          <h5 class=\"modal-title\" id=\"exampleModalLabel\">New user</h5>\n          <button type=\"button\" class=\"close\" data-dismiss=\"modal\" (click)=\"cancel_add(form_add)\" aria-label=\"Close\">\n            <span aria-hidden=\"true\">&times; </span>\n          </button>\n        </div>\n        <div class=\"modal-body\">\n          <form #form_add='ngForm' (ngSubmit)=\"add(form_add)\">\n\n            <div class=\"form-group\">\n              <label for=\"loginuser\">Loginuser</label>\n              <input type=\"text\" id=\"loginuser\" input name=\"loginuser\" ngModel required #loginuser=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <span *ngIf=\"loginuser_existe\">\n              <h5 class=\"error\">This Loginuser  already exist</h5>\n            </span>\n            <div class=\"form-group\">\n              <label for=\"frominst\">Frominst</label>\n              <input type=\"text\" id=\"frominst\" input name=\"frominst\" ngModel required #frominst=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"email\">Email</label>\n              <input type=\"email\" id=\"email\" input name=\"email\" ngModel required #email class=\"form-control\"\n                minlength=\"3\">\n            </div>\n            <span *ngIf=\"email_existe\">\n              <h5 class=\"error\">This Email  already exist</h5>\n            </span>\n            <div class=\"form-group\">\n              <label for=\"firstname\">First name </label>\n              <input type=\"text\" id=\"firstname\" input name=\"firstname\" ngModel required #firstname=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"lastname\">Last name </label>\n              <input type=\"text\" id=\"lastname\" input name=\"lastname\" ngModel required #lastname=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"quality\">Quality </label>\n              <input type=\"text\" id=\"quality\" input name=\"quality\" ngModel required #quality=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"modal-footer\">\n              <button id=\"r\" type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\"\n                (click)=\"cancel_add(form_add)\">Cancel</button>\n              <button type=\"submit\" class=\"btn btn-primary\" [disabled]=\"form_add.invalid\">Save </button>\n            </div>\n          </form>\n        </div>\n\n\n\n      </div>\n    </div>\n  </div>\n</div>\n\n  <!-- Modal -->\n  <div class=\"modal fade\" id=\"update_information\" tabindex=\"-1\" role=\"dialog\"\n    aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n    <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n      <div class=\"modal-content\">\n        <div class=\"modal-header\">\n          <h5 class=\"modal-title\" id=\"exampleModalLongTitle\">Informations</h5>\n          <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n            <span aria-hidden=\"true\">&times;</span>\n          </button>\n        </div>\n        <div class=\"modal-body\">\n          <form #form_update='ngForm' (ngSubmit)=\"update(form_update,user_update)\">\n            <div class=\"form-group\">\n              <label for=\"frominst\">Frominst</label>\n              <input type=\"text\" id=\"frominst\" ngModel=\"{{user_update?.frominst}}\" input name=\"frominst\"  required #frominst=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"levelsecure\">Level secure </label>\n              <input type=\"text\" id=\"levelsecure\" ngModel=\"{{user_update?.levelsecure}}\" input name=\"levelsecure\"  required #levelsecure=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"firstname\">First name </label>\n              <input type=\"text\" id=\"firstname\" ngModel=\"{{interogator_update?.first_NAME_INTERROGATOR}}\" input name=\"firstname\"  required #firstname=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"lastname\">Last name </label>\n              <input type=\"text\" id=\"lastname\"  ngModel=\"{{interogator_update?.last_NAME_INTERROGATOR}}\" input name=\"lastname\"  required #lastname=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"form-group\">\n              <label for=\"quality\">Quality </label>\n              <input type=\"text\" id=\"quality\" ngModel=\"{{interogator_update?.quality}}\" input name=\"quality\"  required #quality=\"ngModel\"\n                class=\"form-control\" minlength=\"3\">\n            </div>\n            <div class=\"modal-footer\">\n              <button  type=\"button\" (click)=\"cancel_update(form_update,interogator_update,user_update)\" id=\"r2\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancel</button>\n              <button type=\"submit\" class=\"btn btn-primary\">Save </button>\n            </div>\n          </form>\n        </div>\n\n        \n      </div>\n    </div>\n  </div>");

/***/ }),

/***/ "xSMm":
/*!************************************************!*\
  !*** ./src/app/views/users/users.component.ts ***!
  \************************************************/
/*! exports provided: UsersComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UsersComponent", function() { return UsersComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "mrSG");
/* harmony import */ var _raw_loader_users_component_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! raw-loader!./users.component.html */ "tvqY");
/* harmony import */ var _users_component_scss__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./users.component.scss */ "SmPd");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ "8Y7J");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "iInd");
/* harmony import */ var _services_user_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../services/user.service */ "qfBg");






let UsersComponent = class UsersComponent {
    constructor(userservice, router) {
        this.userservice = userservice;
        this.router = router;
        this.alertsDismiss = [];
        this.users = [];
        this.email_existe = false;
        this.loginuser_existe = false;
    }
    ngOnInit() {
        this.get_users();
    }
    add_sucess(msg, type) {
        this.alertsDismiss.push({
            type: type,
            msg: msg,
            timeout: 2500
        });
    }
    get_users() {
        this.users = [];
        this.userservice.get_all_users().subscribe(data => {
            if (data.status == 200) {
                this.users_fetch = data.body;
                this.users_fetch.forEach(element => {
                    if (element.loginuser != localStorage.getItem('current_user_id')) {
                        this.users.push(element);
                    }
                });
                this.content = true;
            }
            else if (data.status == 204) {
                this.content = false;
            }
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.userservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    get_interrogator(loginuser) {
        this.userservice.get_interrogator(loginuser).subscribe(data => {
            this.interrogator = data;
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.userservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    add(x) {
        this.loginuser = localStorage.getItem('current_user_id');
        x.value.levelsecure = "secure";
        this.userservice.save(this.loginuser, x.value).subscribe((response) => {
            this.result = response.body.result;
            if (this.result == "email existe") {
                this.email_existe = true;
                this.loginuser_existe = false;
            }
            else {
                if (this.result == "loginuser existe") {
                    this.email_existe = false;
                    this.loginuser_existe = true;
                }
                else {
                    if (this.result == "user saved successfully") {
                        this.add_sucess(this.result, "primary");
                        this.email_existe = false;
                        this.loginuser_existe = false;
                        this.hide();
                        x.reset();
                        this.get_users();
                    }
                }
            }
        }, (error) => {
            console.log(error);
            if (error.status == 403) {
                localStorage.clear();
                this.userservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    cancel_add(x) {
        x.resetForm();
        this.email_existe = false;
        this.loginuser_existe = false;
    }
    hide() {
        let element = document.getElementById('r');
        element.click();
    }
    hide2() {
        let element = document.getElementById('r2');
        element.click();
    }
    set(user) {
        this.user_update = user;
        this.userservice.get_interrogator(user.loginuser).subscribe(data => {
            this.interogator_update = data;
        }, (error) => {
            if (error.status == 403) {
                localStorage.clear();
                this.userservice.clear();
                this.router.navigateByUrl('/login');
            }
        });
    }
    cancel_update(y, i, u) {
        y.setValue({ "frominst": u.frominst, "levelsecure": u.levelsecure, "firstname": i.first_NAME_INTERROGATOR,
            "lastname": i.last_NAME_INTERROGATOR, "quality": i.quality });
    }
    update(x, y) {
        if (window.confirm('Are you sure')) {
            x.value.loginuser = y.loginuser;
            this.userservice.update(x.value).subscribe(data => {
                this.result = data.body.result;
                this.add_sucess(data.body.result, "warning");
                this.get_users();
                this.hide2();
            }, (error) => {
                if (error.status == 403) {
                    localStorage.clear();
                    this.userservice.clear();
                    this.router.navigateByUrl('/login');
                }
            });
        }
    }
    delete(loginuser) {
        if (window.confirm('Are you sure')) {
            console.log(loginuser);
            this.userservice.delete(loginuser).subscribe(data => {
                this.result = data.body.result;
                this.add_sucess(data.body.result, "danger");
                this.get_users();
            }, (error) => {
                if (error.status == 403) {
                    localStorage.clear();
                    this.userservice.clear();
                    this.router.navigateByUrl('/login');
                }
            });
        }
    }
};
UsersComponent.ctorParameters = () => [
    { type: _services_user_service__WEBPACK_IMPORTED_MODULE_5__["UserService"] },
    { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }
];
UsersComponent.propDecorators = {
    email: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_3__["ViewChild"], args: ["email",] }]
};
UsersComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_3__["Component"])({
        selector: 'app-users',
        template: _raw_loader_users_component_html__WEBPACK_IMPORTED_MODULE_1__["default"],
        styles: [_users_component_scss__WEBPACK_IMPORTED_MODULE_2__["default"]]
    }),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [_services_user_service__WEBPACK_IMPORTED_MODULE_5__["UserService"], _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]])
], UsersComponent);



/***/ })

}]);
//# sourceMappingURL=views-users-users-module-es2015.js.map