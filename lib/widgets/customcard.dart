import 'package:flutter/material.dart';
import 'package:new_lesionia_project/patient_details.dart';
import '../Models/Patients.dart';
import '../services/patient_service.dart';
import '../services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late Future<Patient?> patientFuture;

  @override
  void initState() {
    super.initState();
    patientFuture = fetchPatient();
  }

  Future<Patient?> fetchPatient() async {
    // ✅ get patient ID saved in storage
    String patientId = await AuthService.getPatientID();
    print("the patient's id is :$patientId");
    var data = await Patient_Serivce.getpatientbyid(context);
    print(data);
    if (data != null) {
      return Patient.fromJson(data);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Patient?>(
      future: patientFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return getCardShimmer();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Patient not found'));
        } else {
          Patient patient = snapshot.data!;
          return getCard(patient, 0, context);
        }
      },
    );
  }
}

// ---------------------------
// Card UI
// ---------------------------
Widget getCard(Patient patient, int index, BuildContext context) {
  const mintleaft = Color(0xff042F39);
  const robineggblue = Color(0xff075264);
  const electronblue = Color(0xff0A758F);
  const exodusfruit = Color(0xff0A758F);

  return InkWell(
    onTap: () async {
      print(patient.patientIdentifier);
      await AuthService.setPatientID(patient.patientIdentifier);
      print("✅ Patient ID saved to storage: ${patient.patientIdentifier}");
      Navigator.push(
        context,
        MaterialPageRoute(

          //  builder: (context) => patientDetail(patientId: patient.patientIdentifier),
            builder: (context) =>patientDetail()
        ),
      );
    },
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.badge, color: robineggblue, size: 22),
                const SizedBox(width: 8),
                Text(
                  "ID: ${patient.patientIdentifier}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: robineggblue,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, color: electronblue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${patient.first_NAME} ${patient.last_NAME}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: mintleaft,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, color: exodusfruit, size: 20),
                const SizedBox(width: 8),
                Text(patient.phone_NUMBER,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.cake, color: electronblue, size: 20),
                const SizedBox(width: 8),
                Text(patient.birth_DATE,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.wc, color: robineggblue, size: 20),
                const SizedBox(width: 8),
                Text(patient.gender,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------
// Shimmer while loading
// ---------------------------
Widget getCardShimmer() {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 16, width: 100, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: double.infinity, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 14, width: 150, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 14, width: 120, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 14, width: 80, color: Colors.white),
          ],
        ),
      ),
    ),
  );
}
