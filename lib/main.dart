import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// === IMPORTS DE VOS PAGES ===
import 'package:new_lesionia_project/NewPassword.dart';
import 'package:new_lesionia_project/SelectImage.dart';
import 'package:new_lesionia_project/Stats.dart';
import 'package:new_lesionia_project/VerifyCode.dart';
import 'package:new_lesionia_project/add_checkup.dart';
import 'package:new_lesionia_project/add_diagnosis.dart';
import 'package:new_lesionia_project/add_discrepancy.dart';
import 'package:new_lesionia_project/add_patient.dart';
import 'package:new_lesionia_project/add_sample.dart';
import 'package:new_lesionia_project/add_travel_residency.dart';
import 'package:new_lesionia_project/add_treatment_history.dart';
import 'package:new_lesionia_project/all_patients.dart';
import 'package:new_lesionia_project/changepw.dart';
import 'package:new_lesionia_project/diagnosis.dart';
import 'package:new_lesionia_project/discrepancy.dart';
import 'package:new_lesionia_project/home.dart';
import 'package:new_lesionia_project/login.dart';
import 'package:new_lesionia_project/medical_checkup.dart';
import 'package:new_lesionia_project/news.dart';
import 'package:new_lesionia_project/pages/users_list_page.dart';
import 'package:new_lesionia_project/patient_details.dart';
import 'package:new_lesionia_project/patient_profile.dart';
import 'package:new_lesionia_project/patients.dart' hide SelectImage;
import 'package:new_lesionia_project/sample.dart';
import 'package:new_lesionia_project/travelresidency.dart';
import 'package:new_lesionia_project/treatementhistory.dart';
import 'package:new_lesionia_project/update_checkup.dart';
import 'package:new_lesionia_project/update_diagnosis.dart';
import 'package:new_lesionia_project/update_discrepancy.dart';
import 'package:new_lesionia_project/update_sample.dart';
import 'package:new_lesionia_project/update_travel_residency.dart';
import 'package:new_lesionia_project/update_treatmenthistory.dart';
import 'package:new_lesionia_project/user_profile.dart';
import 'package:new_lesionia_project/verifyEMAIL.dart';
import 'package:new_lesionia_project/verifyID.dart';
import 'package:new_lesionia_project/verifypw.dart';
import 'package:new_lesionia_project/adminhome.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lesionia Project',
      debugShowCheckedModeBanner: false,

      // SUPPORT FRANÇAIS + DÉLÉGUÉS
      locale: const Locale('fr', 'FR'),
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),

      // === TOUTES VOS ROUTES ===
      routes: {
        '/adminhome': (context) => const AdminPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/patients': (context) => const PatientPage(),
        '/patientProfile': (context) => const patientProfile(),
        //{
          // Safely cast the argument to String. If nothing is passed,
          // it should default to a reasonable value (like '').
         // final String patientId = ModalRoute.of(context)?.settings.arguments as String? ?? '';
        //  return patientProfile(patientId: patientId);

    //    },
        '/verifyid': (context) => const VerifyPage(),
        '/addpatient': (context) => const AddPatient(),
        '/profile': (context) => const UserProfile(),
        '/changepw': (context) => const Changepw(),
        '/verifypw': (context) => const Verifypw(),
        '/patientsDetail': (context) =>const patientDetail(),
    //{
        //  final String patientId = ModalRoute.of(context)?.settings.arguments as String? ?? '';
        //  return patientDetail(patientId: patientId);
      //  },
        '/checkup': (context) => const medical_checkup(),
        '/addcheckup': (context) => const add_checkup(),
        '/updatecheckup': (context) =>  update_checkup(),
        '/travelresidency': (context) => travelResidency(),
    //{
    //final String patientId = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    //return travelResidency(patientId: patientId);
    //},
        '/addtravel': (context) => const add_travel_residency(),
        '/updatetravel':(context) {
         final String  idtravel = ModalRoute.of(context)?.settings.arguments as String ?? '';
          return update_travel(idtravel, index: 0);
        },
        '/verifyemail': (context) => const verifyemail(),
        '/verifycode': (context) => const Otp(),
        '/newpw': (context) => const NewPassword(),
        '/image': (context) => const SelectImage(),
        '/allpatients': (context) => const all_patients(),
        '/treatmenthistory': (context) => const TreatementHistory(),
        '/addtreatment': (context) => const add_treatment_history(),
        '/updatetreatment': (context) => const UpdateTreatmentHistory(),
        '/stats': (context) => const Statistics(),
        '/sample': (context) => const Sample(),
        //{
         // final String patientId = ModalRoute.of(context)?.settings.arguments as String ?? '';
          //return Sample(patientId:' ');
      //  },

        '/addsample': (context) => const add_sample(),
        '/diagnosis': (context) => const Diagnosis(),
        '/adddiagnosis': (context) => const add_diagnosis(),
        '/updatediagnosis': (context) => const update_diagnosis(),
        '/discrepancy': (context) => const Discrepancy(),
        '/adddiscrepancy': (context) => const add_discrepancy(),
        '/updatediscrepancy': (context) => const update_discrepancy(),
        '/updatesample': (context) => const update_sample(),
        '/news': (context) => const News(),
        '/userslist': (context) => const UsersListPage(),
      },

      // SPLASH SCREEN
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/logoo.png'),
        splashIconSize: 300,
        nextScreen: const LoginPage(),
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
        duration: 3000,
      ),

      builder: EasyLoading.init(),
    );
  }
}

// CONFIGURATION EASYLOADING
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}