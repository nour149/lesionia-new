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

  // State for Sample ID dropdown
  List idsample = [];
  String? value2; // Selected Sample ID (manual selection)

  // State for Check-up Date (automatic selection)
  String? value; // Auto-selected latest Check-up Date

  File? image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (!mounted) {
        return;
      }

      // Fetch data for both fields
      var allDates = await Checkup_Service.getallcheckupsdate(context);
      var data2 = await Sample_Service.getSampleID(context);

      if (mounted) {
        // 1. Check-up Date: Auto-select latest date
        if (allDates != null && allDates.isNotEmpty) {
          setState(() {
            value = allDates.last;
          });
        }

        // 2. Sample ID: Populate list for manual selection
        if (data2 != null) {
          setState(() {
            idsample = data2;
            // Optionally set value2 = data2.last to have a default selection,
            // but for manual selection, leaving it null is safer until the user picks.
          });
        }

        EasyLoading.dismiss();
      }
    });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('Changes on this page will not be saved !'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/patientsDetail',
              ),
              child: const Text("Discard"))
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check image, auto-selected date (value), and manually selected Sample ID (value2)
        if (image != null || value != null || value2 != null) {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        } else {
          Navigator.pushReplacementNamed(
            context,
            '/patientsDetail',
          );
          return true;
        }
      },
      child: Container(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              image != null
                  ? Image.file(
                image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              )
                  : Container(
                padding: const EdgeInsets.all(50),
                width: 140,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage("assets/noimage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildButton(
                  title: 'Pick Gallery',
                  icon: Icons.image_outlined,
                  onClicked: () => pickGallery()),
              const SizedBox(
                height: 24,
              ),
              buildButton(
                  title: 'Pick Camera',
                  icon: Icons.camera_alt_outlined,
                  onClicked: () => pickCamera()),
              const SizedBox(height: 15),

              // --- Check-up Date: Auto-Selected, Read-Only Display ---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: Column(
                    children: [
                      const Text(
                          "Selected Check-up Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      // Displays the auto-selected latest date
                      Text(
                        value ?? 'Loading date...',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // --- Sample ID: RESTORED Dropdown for Manual Selection ---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        errorStyle:
                        TextStyle(height: 1, fontWeight: FontWeight.bold),
                      ),
                      hint: const Center(
                          child: Text(
                            "Select sample ID",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      value: value2,
                      iconSize: 36,
                      isExpanded: true,
                      items: idsample.map((item) {
                        return DropdownMenuItem(
                          child: Center(
                            child: Text(item,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                          value: item.toString(),
                        );
                      }).toList(),
                      // Validation forces the user to pick an item
                      validator: (value2) =>
                      value2 == null ? 'Choose a sample ID!' : null,
                      onChanged: (newValue2) async {
                        setState(() {
                          this.value2 = newValue2;
                        });
                      }),
                ),
              ),

              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () async {
                  // Validate form (checks Sample ID) and ensure date (value) and image are not null
                  if (_formKey.currentState!.validate() && value != null && image != null) {
                    // Use auto-selected date (value) and manually selected Sample ID (value2)
                    await Image_Service.Upload(
                        image,
                        context,
                        value.toString(),
                        value2.toString());
                  } else {
                    EasyLoading.showError('Please select an image and Sample ID!');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 54,
                  width: 175,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xFF6DD6CA)),
                      Color(0xff088274)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: const Text(
                    "Upload",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future pickGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      dynamic imageTemporary = File(image.path);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image : $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      dynamic imageTemporary = File(image.path);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image : $e');
    }
  }
}

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.black38)),
              minimumSize: const Size.fromHeight(56),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: onClicked,
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(title),
            ],
          )),
    );