import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/verifyEMAIL.dart';
import 'package:new_lesionia_project/widgets/custom_page_route.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}
  class _LoginPageState extends State <LoginPage> {
    final username = TextEditingController();
    final password = TextEditingController();
    Timer? _timer;
    final _formKey = GlobalKey<FormState>();


    @override
    void initState() {
      super.initState();
      EasyLoading.addStatusCallback((status){

        print('EasyloadingStatus $status');

        if(status== EasyLoadingStatus.dismiss)
          {
            _timer?.cancel();
          }

         });

          }


    Future<bool?> showWarning(BuildContext context) async => showDialog(

    context:context,
     builder:(context) => AlertDialog (
         title: Text("DO YOU WANT TO EXIT THE APP"),
         actions:[

           TextButton(
              onPressed: ()  => Navigator.pop(context,false),
             child:Text( "NO" )

           ),

           TextButton(

               onPressed: () => SystemNavigator.pop(), child: Text("YES"))
         ]

    )
    );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },


      child: Scaffold(

       body: SingleChildScrollView(

         child:Form(
           key:_formKey,
           child: Column(

             children: [

               Container(

                 height: 370,
                 decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90)),



                gradient: LinearGradient(
                      colors: [
                        (new Color(0xff088274)),
                        Colors.greenAccent
                      ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                 ),
                child:Center(

                child:Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                    margin:EdgeInsets.only(top:50),
                    child: Image.asset(  "assets/logo_IPT.png",
                      height: 89,
                    ),
                )  ,

                   Container(

                     width:360,
                     margin:EdgeInsets.only(top:10),
                     child:Image.asset("assets/logo_MEEP.png"),


                   ),

             ],
           )),
       ),
        Container(

        alignment: Alignment.center,
         margin:EdgeInsets.only(top:50,left:20,right:10) ,
         padding:EdgeInsets.only(top:50,left:10),
         height:54,

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(50),
          color:Colors.grey[200],

          boxShadow:
          [
            BoxShadow(
               offset:Offset(0,20),
               blurRadius: 5,
               color:Colors.purple,
          )]
        ),

          child: TextFormField(

            cursorColor: Color(0xff241e20),
             controller:username,
            decoration: InputDecoration(

              icon:Icon(
                Icons.person,
                color:Colors.grey
              ),

              hintText: "Enter username",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,

            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill in this field';
              }
              return null;
            },
          ),
        ),


      Container(
        margin:
        EdgeInsets.symmetric(horizontal:20,vertical:20  ),
        alignment: Alignment.centerRight,
        child:GestureDetector(
          onTap: (){
            Navigator.of(context)
                .push(CustomPageRoute(child: verifyemail()));

          },
          child:Text(
            "Forgot password",
            style:
              TextStyle
                (fontSize: 15,fontWeight:FontWeight.bold
              )
          ),


        ),

      ),
               GestureDetector(

          onTap: (){
            if(_formKey.currentState!.validate())
              {
                AuthService.login(username.text, password.text, context);

              }
          },

                   child:Container(

                     alignment:Alignment.center,
                     margin:EdgeInsets.only(left:20,right:50,top:70),
                     padding:EdgeInsets.only(left:20,right:50),
                     height:54,
            decoration: BoxDecoration(

                   gradient: LinearGradient(
                     colors: [
                       (new Color(0xFF6DD6CA)),
                       new Color(0xff088274)
                     ],

         begin: Alignment.centerRight,
        end:Alignment.centerRight
),
borderRadius:BorderRadius.circular(50),
color:Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
                     child: Text(
                       "LOGIN",
                       style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold),
                     ),
                   ),
               ),
             ],
           )))),
    );
  }
  }















  






