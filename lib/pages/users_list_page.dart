// lib/pages/users_list_page.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Assuming your Myuser_Service is here, adjust path if necessary
import 'package:new_lesionia_project/services/myuser_service.dart';
import 'package:new_lesionia_project/widgets/add_user_form.dart';
import 'package:http/http.dart' as http;

class UsersListPage extends StatefulWidget {

  const UsersListPage({super.key});
  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  bool _showform =false;
  bool x = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _deleteUser(String loginuser) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete user'),
        content: Text('Are you sure you want to delete “$loginuser” ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed != true) return;          // user cancelled

    try {
      // ← adjust route if your backend uses /api/user/delete or needs a query param
      final uri = Uri.parse('http://192.168.114.31:7000/api/user/$loginuser');
      final res  = await http.delete(uri);

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User “$loginuser” deleted.')),
        );
        await _loadUsers();                 // refresh table
      } else {
        throw Exception('HTTP ${res.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }


  Future<void> _updateUSER(String loginuser,String Currentloginuser,String Currentfrominst) async {
    final TextEditingController loginuser1 = TextEditingController(text: Currentloginuser);
    final TextEditingController frominst = TextEditingController(text: Currentfrominst);
    final updating = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure you want to update the user?'),
        content:
        //const Text("This will update the user's information."),
        Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
             TextField(
               controller:loginuser1,
               decoration: InputDecoration(labelText: 'username'),
             ),
            TextField(
            controller:frominst,
            decoration: InputDecoration(labelText:'Institution'),
            )
          ],
        )
         ,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Modify'),
          ),
        ],
      ),
    );
    if (updating == true) {
      final uri = Uri.parse('http://192.168.114.31:7000/modify/$loginuser');
      try {
        final res = await http.put(uri);
       await http.put(uri,
           headers:{'Content-type':'application/json'
       },
        body:jsonEncode({
        'loginuser':loginuser1.text,
         'frominst':frominst.text
        })
       );

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Utilisateur modifié avec succès'),
              duration: const Duration(seconds: 1),
              action: SnackBarAction(
                label: 'ACTION',
                onPressed: () {},
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur serveur : ${res.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur réseau : $e')),
        );
      }
    }
  }



  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Replace this mock data with your actual API call from Myuser_Service.getUsersList(context);
      // For now, using mock data that matches usssss.png structure
      // await Future.delayed(const Duration(seconds: 1)); // You commented this out, which is fine for immediate loading
      //final List<Map<String, dynamic>> fetchedUsers = [
        //{'Loginuser': 'super', 'Frominst': 'ipt', 'Email': 'super', 'Levelsecure': 'super', 'Use_LOGINUSER': 'super'},
        //{'Loginuser': 'emna', 'Frominst': 'IPT', 'Email': 'emna', 'Levelsecure': 'normal', 'Use_LOGINUSER': 'super'},
        //{'Loginuser': 'zeineb', 'Frominst': 'IPT', 'Email': 'zeineb', 'Levelsecure': 'normal', 'Use_LOGINUSER': 'super'},
        //{'Loginuser': 'maaaoui', 'Frominst': 'ISI', 'Email': 'maaaoui', 'Levelsecure': 'normal', 'Use_LOGINUSER': 'super'},
        //{'Loginuser': 'hejer', 'Frominst': 'IPT', 'Email': 'hejer', 'Levelsecure': 'normal', 'Use_LOGINUSER': 'super'},
        //{'Loginuser': 'new_one_1', 'Frominst': 'ipt', 'Email': 'mohamed.ferjani@istic.ucar.tn', 'Levelsecure': 'admin', 'Use_LOGINUSER': 'admin'},
        //{'Loginuser': 'wissem', 'Frominst': 'ipt', 'Email': 'wissem.benmansour@gmail.com', 'Levelsecure': 'secure', 'Use_LOGINUSER': 'admin'},
        //{'Loginuser': 'new_one', 'Frominst': 'ipt', 'Email': 'wissem.benmansour@istic.ucar.tn', 'Levelsecure': 'secure', 'Use_LOGINUSER': 'admin'},
      //];


      final uri =Uri.parse('http://192.168.114.154:7000/api/user/all');
      final response = await http.get(uri,headers:
      {'Accept':'application/json'},
      );
      if(response.statusCode==200) {
        final List<dynamic> raw = jsonDecode(response.body);


      setState(() {
        // Cast every element to Map<String, dynamic>
        _users = raw.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    }
    } catch (e) {
      print("Error loading users: $e");
      setState(() {
        _isLoading = false;
        // Optionally show an error message on the UI if data loading fails
      });
    }
  }

  /// Helper to build a styled cell for text data in the table.
  DataCell _buildTextCell(String text) {
    return DataCell(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Text(text),
      ),
    );
  }

  /// Helper to build action icon buttons within the table cells (More Details, Update, Delete).
  DataCell _buildActionButtonCell(IconData icon, Color color, VoidCallback onPressed) {
    return DataCell(
      Container(
        width: 36, // Fixed width for the button container to make it square/compact
        height: 36, // Fixed height for the button container
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0), // Rounded corners for the button background
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 18),
          onPressed: onPressed,// White icon, 18px size
          // visualDensity: VisualDensity.compact, // Make button smaller, often good for tables
          padding: EdgeInsets.zero, // Remove default padding of IconButton to fill container
          constraints: const BoxConstraints(), // Remove default constraints of IconButton
        ),
      ),
    );
  }

 // Widget build1(BuildContext context )


  ////{

   // return Column(

    //);

  //}

    @override
  Widget build(BuildContext context) {
    // The screen should have a similar light background as the profile page
    return Scaffold(

      backgroundColor: const Color(0xFFECF0F1),
      // Light background color for the page
      // For mobile, this page will also have an app bar (which enables drawer access)
      appBar: MediaQuery.of(context).size.width < 700
          ? AppBar(
        backgroundColor: const Color(0xFFECF0F1), // AppBar background color
        elevation: 0, // No shadow under the AppBar
        iconTheme: const IconThemeData(color: Colors.black54), // Color of leading icon (hamburger)
        title: const Text(
          'Users List', // Title for the AppBar
          style: TextStyle(color: Colors.black87),
        ),
      )
          : null, // No AppBar for wide screens as it's meant to be part of the Row layout with AdminPage

      body: LayoutBuilder(
        builder: (context, constraints) {
          // This top-right hamburger is only shown on wider screens (desktop/tablet)
          // because on mobile, the AppBar handles the drawer toggle.
          return ListView(
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── either show the form or the “Add user” button ─────────────────────────
              _showform
                  ? AddUserForm(
                // ↓ this map is exactly what /api/patient/save expects
                onSave: (newUser) async {
                  final url = Uri.parse('http://192.168.114.31:7000/api/user/save');
                  try {
                    final response = await http.post(
                      url,
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode(newUser),
                    );
                    if (response.statusCode == 200 || response.statusCode == 201) {
                      await _loadUsers();          // refresh list from server
                      setState(() => _showform = false);
                    } else {
                      // handle error (Snackbar, dialog, etc.)
                      debugPrint('Create failed → ${response.statusCode}');
                    }
                  } catch (e) {
                    debugPrint('Create failed → $e');
                  }
                },
                onCancel: () => setState(() => _showform = false),
              )
                  : ElevatedButton(
                onPressed: () => setState(() => _showform = true),
                child: const Text('Add user'),
              ),

              if (constraints.maxWidth >= 700)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10), // Adjust top padding for desktop view
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.menu, // Top right hamburger icon for desktop
                        color: Color(0xFF555555),
                        size: 28,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator() // Show loading spinner
                      : Container(
                    padding: const EdgeInsets.all(20.0), // Padding inside the table card
                    margin: const EdgeInsets.all(20.0), // Margin around the table card
                    decoration: BoxDecoration(
                      color: Colors.white, // White background for the table card
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Subtle shadow
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxWidth: 1200), // Max width for the table
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Allow horizontal scrolling for table if content overflows
                      child: DataTable(
                        columnSpacing: 25.0, // Space between columns
                        dataRowMinHeight: 40, // Minimum height for data rows
                        dataRowMaxHeight: 60, // Maximum height for data rows
                        headingRowColor: MaterialStateProperty.all(const Color(0xFFECF9FB)), // Header background color [matches image]
                        columns: const [
                          // DataColumn definitions for table headers
                          DataColumn(label: Text('loginuser', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('frominst', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('email', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('levelsecure', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('use_LOGINUSER', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('More Details', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Update', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: _users.map((user) {
                          // DataRow for each user in the _users list
                          return DataRow(
                            cells: [
                              _buildTextCell(user['loginuser'] ?? 'N/A'), // Use N/A if data is null
                              _buildTextCell(user['frominst'] ?? 'N/A'),
                              _buildTextCell(user['email'] ?? 'N/A'),
                              _buildTextCell(user['levelsecure'] ?? 'N/A'),
                              _buildTextCell(user['use_LOGINUSER'] ?? 'N/A'),
                              // Action buttons for More Details, Update, Delete
                              _buildActionButtonCell(Icons.info_outline, const Color(0xFF3498DB), () { // Blue button [matches image]
                                print('More details for ${user['Loginuser']}');
                                // TODO: Implement navigation to user detail page or show dialog
                              }),
                              _buildActionButtonCell(Icons.edit, const Color(0xFFF39C12), () { // Orange button [matches image]
                                _updateUSER(user ['loginuser'],user['Currentloginuser'],user['Currentfromins']);
                                // TODO: Implement navigation to update user form
                              }),
                              _buildActionButtonCell(Icons.delete, const Color(0xFFE74C3C), // Red button [matches image]
                                    () => _deleteUser(user['loginuser']),
                                // TODO: Implement delete confirmation dialog and actual delete logic
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}