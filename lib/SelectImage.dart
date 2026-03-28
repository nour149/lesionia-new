import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/image_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  // --- VARIABLES D'ÉTAT ---
  List idsample = [];
  String? value2; // Selected Sample ID
  String? value;  // Auto-selected latest Check-up Date
  File? image;
  String? bbox;   // Coordonnées du cadre rouge
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (!mounted) return;

      var allDates = await Checkup_Service.getallcheckupsdate(context);
      var data2 = await Sample_Service.getSampleID(context);

      if (mounted) {
        if (allDates != null && allDates.isNotEmpty) {
          setState(() => value = allDates.last);
        }
        if (data2 != null) {
          setState(() => idsample = data2);
        }
        EasyLoading.dismiss();
      }
    });
  }

  // --- FONCTIONS UTILITAIRES ---
  Map<String, double> parseBbox(String bboxString) {
    try {
      List<String> parts = bboxString.split(',');
      if (parts.length != 4) return {'x': 0, 'y': 0, 'w': 0, 'h': 0};
      return {
        'x': double.parse(parts[0].trim()),
        'y': double.parse(parts[1].trim()),
        'w': double.parse(parts[2].trim()),
        'h': double.parse(parts[3].trim()),
      };
    } catch (e) {
      debugPrint("Erreur parsing bbox: $e");
      return {'x': 0, 'y': 0, 'w': 0, 'h': 0};
    }
  }

  Future pickGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        image = File(pickedFile.path);
        bbox = null; // Reset le cadre si on change d'image
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image : $e');
    }
  }

  Future pickCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      setState(() {
        image = File(pickedFile.path);
        bbox = null;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image : $e');
    }
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('Changes on this page will not be saved !'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/patientsDetail'),
              child: const Text("Discard"))
        ],
      ));

  Widget buildButton({required String title, required IconData icon, required VoidCallback onClicked}) =>
      Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 5),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: const BorderSide(color: Colors.black38)),
                minimumSize: const Size.fromHeight(56),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: onClicked,
            child: Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 20),
                Text(title),
              ],
            )),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (image != null || value != null || value2 != null) {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        } else {
          Navigator.pushReplacementNamed(context, '/patientsDetail');
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // --- AFFICHAGE IMAGE + CADRE ---
                  image != null
                      ? Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(image!, width: 160, height: 160, fit: BoxFit.cover),
                      ),
                      if (bbox != null && bbox != "0,0,0,0")
                        Positioned.fill(
                          child: Builder(builder: (context) {
                            var coords = parseBbox(bbox!);
                            double size = 160.0;
                            return Stack(
                              children: [
                                Positioned(
                                  left: (coords['x']! * size) / 100,
                                  top: (coords['y']! * size) / 100,
                                  child: Container(
                                    width: (coords['w']! * size) / 100,
                                    height: (coords['h']! * size) / 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                    ],
                  )
                      : Container(
                    padding: const EdgeInsets.all(50),
                    width: 140,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(image: AssetImage("assets/noimage.png"), fit: BoxFit.cover),
                    ),
                  ),

                  const SizedBox(height: 10),
                  buildButton(title: 'Pick Gallery', icon: Icons.image_outlined, onClicked: () => pickGallery()),
                  const SizedBox(height: 24),
                  buildButton(title: 'Pick Camera', icon: Icons.camera_alt_outlined, onClicked: () => pickCamera()),
                  const SizedBox(height: 15),

                  // --- DATE ---
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black, width: 4)),
                      child: Column(
                        children: [
                          const Text("Selected Check-up Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(value ?? 'Loading date...', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // --- SAMPLE ID ---
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black, width: 4)),
                      child: DropdownButtonFormField<String>(
                          hint: const Center(child: Text("Select sample ID", style: TextStyle(fontWeight: FontWeight.bold))),
                          value: value2,
                          isExpanded: true,
                          items: idsample.map((item) {
                            return DropdownMenuItem(value: item.toString(), child: Center(child: Text(item, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))));
                          }).toList(),
                          validator: (val) => val == null ? 'Choose a sample ID!' : null,
                          onChanged: (newValue2) => setState(() => value2 = newValue2)),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- BOUTON UPLOAD ---
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate() && value != null && image != null) {
                        EasyLoading.show(status: 'Analyzing...');
                        // Note: Modifiez votre service pour qu'il retourne l'objet contenant la bbox
                        var response = await Image_Service.Upload(image, context, value.toString(), value2.toString());

                        // Si votre backend renvoie la bbox dans la réponse :
                        if(response != null && response.bbox != null) {
                          setState(() => bbox = response.bbox);
                        }
                        EasyLoading.dismiss();
                      } else {
                        EasyLoading.showError('Please select an image and Sample ID!');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 54,
                      width: 175,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF6DD6CA), Color(0xff088274)]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text("Upload", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} // Fin de la classe