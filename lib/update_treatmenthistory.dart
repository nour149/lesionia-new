import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/treatment_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';
import 'package:dropdown_search/dropdown_search.dart';

class UpdateTreatmentHistory extends StatefulWidget {
  const UpdateTreatmentHistory({super.key});

  @override
  State<UpdateTreatmentHistory> createState() => _UpdateTreatmentHistoryState();
}

enum Prescribed { other, leishmania, na }

class _UpdateTreatmentHistoryState extends State<UpdateTreatmentHistory> {
  String idtreatment = '';
  String send = '';
  String prescribedfor = "";
  List<Map<String, dynamic>> selectedTreatment = [];
  final number = TextEditingController();
  final other = TextEditingController();
  final other2 = TextEditingController();
  final numberofinjection = TextEditingController();
  final posology = TextEditingController();
  final adminroot = TextEditingController();
  Prescribed? _prescribed = Prescribed.na;
  late DateTime pickedDate;
  late DateTime pickedDate2;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime(1900);
    pickedDate2 = DateTime(1900);
    _loadData();
  }

  Future<void> _loadData() async {
    idtreatment = await AuthService.getTreatmentID();
    data = await Treatment_Service.gettreatmentbyid(context);
    if (data != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    setState(() {
      posology.text = data?['posology'] ?? '';
      adminroot.text = data?['adminroute'] ?? '';
      number.text = data?['durationn']?.toString() ?? '';
      numberofinjection.text = data?['injection_NUMBER']?.toString() ?? '';

      pickedDate = _parseDate(data?['start_DATE']) ?? pickedDate;
      pickedDate2 = _parseDate(data?['healing_DATE']) ?? pickedDate2;

      prescribedfor = data?['prescribedfor'] ?? '';
      if (prescribedfor != "N/A" && prescribedfor != "Leishmania") {
        _prescribed = Prescribed.other;
        other2.text = prescribedfor;
        prescribedfor = "Other";
      }

      final treatmentStr = data?['treatment_TYPE'] ?? '';
      final treatmentList = treatmentStr
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final known = listToSearchHTT1.map((e) => e['name'] as String).toSet();
      final others = <String>[];
      final valid = <String>[];

      for (var t in treatmentList) {
        if (known.contains(t)) {
          valid.add(t);
        } else if (t.isNotEmpty) {
          others.add(t);
        }
      }

      if (others.isNotEmpty) {
        other.text = others.join(', ');
        valid.add('Other');
      }
      final listToSearch = listToSearchHTT.cast<Map<String, dynamic>>();
      selectedTreatment = valid
      .map((e) => listToSearch.firstWhere(
      (item) => item['name'] == e,
      // 💡 FIX: Explicitly cast the map literal returned by orElse
      orElse: () => {'name': e} as Map<String, dynamic>,
      ))
          .toList();
      send = valid.join(',');
    });

    _updateRadio();
  }

  DateTime? _parseDate(dynamic date) {
    if (date == null || date.toString().isEmpty) return null;
    return DateTime.tryParse(date.toString());
  }

  void _updateRadio() {
    setState(() {
      _prescribed = switch (prescribedfor) {
        "N/A" => Prescribed.na,
        "Leishmania" => Prescribed.leishmania,
        _ => Prescribed.other,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/treatmenthistory');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff088274), Colors.greenAccent],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          title: Center(child: Text(idtreatment)),
          backgroundColor: const Color(0xFF077064),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, '/treatmenthistory'),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Historical Treatment Type'),
              const SizedBox(height: 15),

              // DROPDOWN – MULTI SELECTION
              DropdownSearch<Map<String, dynamic>>.multiSelection(
// Fixed line by casting to the expected type
                items: listToSearchHTT.cast<Map<String, dynamic>>(),                selectedItems: selectedTreatment,
                itemAsString: (item) => item['name'] as String,
                dropdownBuilder: (context, selectedItems) {
                  if (selectedItems.isEmpty) {
                    return const Text("Treatment Type", style: TextStyle(color: Colors.grey));
                  }
                  return Text(
                    selectedItems.map((e) => e['name']).join(", "),
                    style: const TextStyle(fontSize: 16),
                  );
                },
                popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                  showSearchBox: true,
                  title: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Select Treatment Types",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Search Treatment Type...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                dropdownButtonProps: const DropdownButtonProps(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                ),
                onChanged: (List<Map<String, dynamic>> values) {
                  setState(() {
                    selectedTreatment = values;
                    send = values.map((e) => e['name'] as String).join(', ');
                  });
                },
              ),

              // Other field
              if (send.contains('Other')) ...[
                const SizedBox(height: 15),
                _title('If other, please specify'),
                const SizedBox(height: 20),
                _buildTextField(other, "Specify treatment...", multiline: true),
              ],

              // Prescribed for – RadioGroup
              const SizedBox(height: 15),
              _title('Prescribed for'),
              const SizedBox(height: 15),
              RadioGroup<Prescribed>(
                items: [
                  RadioItem(Prescribed.leishmania, 'Leishmania'),
                  RadioItem(Prescribed.other, 'Other'),
                  RadioItem(Prescribed.na, 'N/A'),
                ],
                groupValue: _prescribed,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _prescribed = value;
                      prescribedfor = switch (value) {
                        Prescribed.leishmania => 'Leishmania',
                        Prescribed.other => 'Other',
                        Prescribed.na => 'N/A',
                      };
                    });
                  }
                },
              ),

              if (prescribedfor == 'Other') ...[
                const SizedBox(height: 15),
                _title('If other, please specify'),
                const SizedBox(height: 20),
                _buildTextField(other2, "Specify condition...", multiline: true),
              ],

              // Dates
              _buildDateField('Treatment start date', pickedDate, _pickDate),
              _buildDateField('Healing date', pickedDate2, _pickDate2),

              // Text fields
              _buildNumberField('Treatment Duration', number, 'Number of Weeks'),
              _buildTextFieldWithTitle('Posology', posology, 'Posology', multiline: true),
              _buildTextFieldWithTitle('Administration Root', adminroot, 'Enter Administration Root', multiline: true),
              _buildNumberField('Number of injections', numberofinjection, 'Number of Injections'),

              // Update button
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _confirmUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff088274),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  child: const Text("UPDATE", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === UI HELPERS ===
  Widget _title(String text) => Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21));

  Widget _buildDateField(String title, DateTime date, Function(BuildContext) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        _title(title),
        ListTile(
          title: Center(child: Text("${date.day}-${date.month}-${date.year}")),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => onTap(context),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool multiline = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
      maxLines: multiline ? null : 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.green)),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildTextFieldWithTitle(String title, TextEditingController controller, String hint, {bool multiline = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _title(title),
        const SizedBox(height: 10),
        _buildTextField(controller, hint, multiline: multiline),
      ],
    );
  }

  Widget _buildNumberField(String title, TextEditingController controller, String hint) {
    return _buildTextFieldWithTitle(title, controller, hint);
  }

  void _pickDate(BuildContext ctx) async {
    final d = await showDatePicker(
      context: ctx,
      initialDate: pickedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      locale: const Locale('fr', 'FR'),
    );
    if (d != null) {
      setState(() => pickedDate = d);
    }
  }

  void _pickDate2(BuildContext ctx) async {
    final d = await showDatePicker(
      context: ctx,
      initialDate: pickedDate2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      locale: const Locale('fr', 'FR'),
    );
    if (d != null) {
      setState(() => pickedDate2 = d);
    }
  }

  Future<void> _confirmUpdate() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Warning!'),
        content: const Text("Are you sure you want to update this information?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
        ],
      ),
    );

    if (confirm == true) {
      await EasyLoading.show(status: 'Mise à jour...', maskType: EasyLoadingMaskType.black);
      await Treatment_Service.updateTreatmentHistory(
        OtherFunction(send, other.text),
        OtherFunction2(prescribedfor, other2.text),
        correctlyFormattedDateTime(pickedDate),
        number.text,
        posology.text,
        adminroot.text,
        numberofinjection.text,
        context,
      );
      await EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    number.dispose();
    other.dispose();
    other2.dispose();
    numberofinjection.dispose();
    posology.dispose();
    adminroot.dispose();
    super.dispose();
  }
}

// === RADIO GROUP WIDGET (PUBLIC) ===
class RadioGroup<T> extends StatelessWidget {
  final List<RadioItem<T>> items;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  const RadioGroup({super.key, required this.items, this.groupValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items
          .map((item) => Row(
        children: [
          Radio<T>(
            value: item.value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(item.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ))
          .toList(),
    );
  }
}

// === PUBLIC ITEM CLASS ===
class RadioItem<T> {
  final T value;
  final String label;
  const RadioItem(this.value, this.label);
}