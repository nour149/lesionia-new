import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/patient_service.dart';
import 'package:new_lesionia_project/services/stats_service.dart';
import 'package:new_lesionia_project/widgets/navigation_drawer_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Retained for now, though not strictly needed here

// --- NEW DATA MODEL FOR THE CHART (Retained as it was used for the deleted chart) ---
class PatientUserCountData {
  const PatientUserCountData(this.loginUser, this.patientCount);
  final String loginUser;
  final int patientCount;
}
// ------------------------------------

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<LesioniaData> _chartData = [];

  // To hold patient count per user data (Retained, but not used now)
  // List<PatientUserCountData> _patientUserChartData = [];

  late TooltipBehavior _tooltipBehavior3;
  // late TooltipBehavior _tooltipBehavior4; // Removed unused tooltip

  late int date;
  Timer? _timer;

  // 🚨 NEW HELPER FUNCTION TO GET LOGIN USER (Retained, but not used now) 🚨
  Future<String?> _getCurrentUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('USER_LOGIN_KEY');
  }

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    date = now.year;

    _tooltipBehavior3 = TooltipBehavior(enable: true);
    // _tooltipBehavior4 = TooltipBehavior(enable: true); // Removed unused tooltip

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      // --- DATA FETCHING FOR THE REMAINING CHART (Bar Chart) ---

      // 1. Removed: Logic to fetch and set _patientUserChartData is gone.

      // 2. Existing logic for the second chart (Bar Chart: Check-ups, Samples, etc.)
      var patients = await Patient_Serivce.getallpatients(context);
      var travels = await Stats.getalltravelsbyid(context);
      var checkups = await Stats.getallcheckupsbyid(context);
      var samples = await Stats.getallsamplesbyid(context);

      if (patients != null &&
          travels != null &&
          checkups != null &&
          samples != null) {

        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          _chartData =
              getChartData(patients.length, checkups, travels, samples);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // FIX: Replace deprecated WillPopScope with PopScope
    return PopScope(
        canPop: false, // Prevents popping if back button is pressed
        onPopInvoked: (didPop) async {
          if (!didPop) {
            // Logic to handle back navigation (same as WillPopScope)
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (Color(0xff088274)),
                      Colors.greenAccent,
                    ],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
              title: const Center(child: Text("Lesionia")),
              backgroundColor: const Color(0xFF077064),
            ),
            drawer: NavigationDrawerWidget(),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                    children: [
                      // 1. Removed: The first SfCartesianChart (Patient Count by User) and its surrounding Container/Divider are gone.

                      // 2. Existing SfCartesianChart (Bar chart)
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 40,
                            interval: 10,
                          ),
                          tooltipBehavior: _tooltipBehavior3,
                          series: <CartesianSeries>[
                            BarSeries<LesioniaData, String>(
                                dataSource: _chartData,
                                xValueMapper: (LesioniaData data, _) =>
                                data.continent,
                                dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                                yValueMapper: (LesioniaData data, _) => data.values,
                                name: '',
                                width: 0.6,
                                spacing: 0.3)
                          ])
                    ],
                  )),
            )));
  }

  List<LesioniaData> getChartData(patient, checkup, travel, sample) {
    final List<LesioniaData> chartData = [
      // Assuming 'patient' count is the total patients, which is not charted here.
      LesioniaData('Medical Check-ups', checkup),
      LesioniaData('Travel Residencies', travel),
      LesioniaData('Samples', sample),
    ];
    return chartData;
  }
}

class LesioniaData {
  const LesioniaData(this.continent, this.values); // Added const
  final String continent;
  final int values;
}