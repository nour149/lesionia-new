import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_lesionia_project/services/myuser_service.dart'; // Assuming this path is correct
import 'package:new_lesionia_project/pages/users_list_page.dart'; // Import the new UsersListPage

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminProfilePanelState();
}

class _AdminProfilePanelState extends State<AdminPage> {
  String email = '';
  String name = ''; // Corresponds to Loginuser
  String firstname = '';
  String lastname = '';
  String quality = '';
  String frominst = 'IPT'; // Default if not fetched
  String levelsecure = 'admin'; // Default if not fetched

  bool loading = true;
  int _selectedIndex = 1; // 'Users' is selected by default as per cons profil admin.png

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('id') ?? 'N/A';

    try {
      final data = await Myuser_Service.getUser(context);
      final userEmailData = await Myuser_Service.getEmailbyUser(context);

      setState(() {
        firstname = data?['first_NAME_INTERROGATOR'] ?? 'N/A';
        lastname = data?['last_NAME_INTERROGATOR'] ?? 'N/A';
        quality = data?['quality'] ?? 'N/A';
        email = userEmailData?['email'] ?? 'N/A';
        // You might fetch frominst and levelsecure from data if they are dynamic
        // frominst = data?['frominst'] ?? 'IPT';
        // levelsecure = data?['levelsecure'] ?? 'admin';
        loading = false;
      });
    } catch (e) {
      print("Error loading profile data: $e");
      setState(() {
        loading = false;
        firstname = 'N/A';
        lastname = 'N/A';
        quality = 'N/A';
        email = 'N/A';
      });
    }
  }

  /// Helper to build profile info field (Label above Input)
  Widget _buildProfileInputField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333), // Dark grey label text
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: TextEditingController(text: value),
            readOnly: true,
            style: const TextStyle(color: Color(0xFF333333)), // Ensure text is dark grey
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFECF9FB), // Light blue background for inputs
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xFF3498DB)), // Blue border on focus
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for sidebar items (DRY)
  Widget _buildSidebarItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent, // Active background
        border: isSelected
            ? const Border(left: BorderSide(color: Color(0xFF3498DB), width: 3)) // Active border
            : null,
      ),
      child: Material(
        color: Colors.transparent, // Ensures InkWell ripple is visible
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });

            // If on mobile, close the drawer BEFORE navigating
            if (MediaQuery.of(context).size.width < 700) {
              Navigator.pop(context); // Close the drawer FIRST
            }

            // Perform navigation based on the selected index
            if (index == 1) { // This is the "Users" item
              print('Navigating to UsersListPage via named route...');
              Navigator.pushNamed(context, '/userslist').then((_) {
                print('Returned from UsersListPage.');
              });
            } else if (index == 0) { // Example: "Stats"
              // If Stats is the current AdminPage content, no explicit navigation might be needed
              // or navigate to a dedicated Stats page:
              // Navigator.pushNamed(context, '/stats');
              print('Sidebar item tapped: Stats. Staying on AdminPage (or navigate to a dedicated Stats page).');
            }
            // Add more else if blocks for other navigation items as needed for dedicated pages
            // else if (index == 2) { /* navigate to Molecular Test page */ }
            // else if (index == 3) { /* navigate to Laboratory page */ }


            print('Sidebar item tapped: $title (Index: $index)');
          },
          child: Padding(
            padding: EdgeInsets.only(left: isSelected ? 17 : 20, top: 12, bottom: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper to build the actual sidebar content (used by both fixed sidebar and Drawer)
  Widget _buildSidebarContent() {
    return Container(
      width: 250, // This width will be used for fixed sidebar
      color: const Color(0xFF34495E), // Dark blue-grey for sidebar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Header (Lesimnia Logo and Collaps/Expand Icon for desktop, or just logo for mobile drawer)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lesimnia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22, // Slightly reduced font size to prevent cutoff
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Only show chevron on wide screens for desktop collapse/expand
                if (MediaQuery.of(context).size.width >= 700) // Check width to show icon
                  const Icon(
                    Icons.chevron_left, // Changed icon to represent collapsing/expanding
                    color: Colors.white,
                    size: 28,
                  ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 10),

          // Sidebar Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSidebarItem(Icons.bar_chart, "Stats", 0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    'SECTIONS',
                    style: TextStyle(
                      color: Color(0xFFBDC3C7), // Light grey for section titles
                      fontSize: 12,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _buildSidebarItem(Icons.group, "Users", 1), // Users (active)
                _buildSidebarItem(Icons.science, "Molecular Test", 2),
                _buildSidebarItem(Icons.local_hospital, "Laboratory", 3),
                _buildSidebarItem(Icons.bug_report, "leishmania-species", 4),
                _buildSidebarItem(Icons.masks, "disease classes", 5),
                _buildSidebarItem(Icons.person, "Patients", 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build the main content area (profile form)
  Widget _buildMainContent() {
    return loading
        ? const Center(child: CircularProgressIndicator()) // Show loading indicator
        : Container(
      color: const Color(0xFFECF0F1), // Light background for main content
      padding: const EdgeInsets.all(20), // Overall padding for the content area
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Right Hamburger Icon (only on wide screens as AppBar handles it on mobile)
          if (MediaQuery.of(context).size.width >= 700)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Padding below the header
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
                    Icons.menu, // Top right hamburger icon
                    color: Color(0xFF555555),
                    size: 28,
                  ),
                ),
              ),
            ),
          // Profile Form (Card-like appearance)
          Expanded( // Use Expanded to ensure form takes available space and allows scrolling
            child: Center( // Center the form horizontally
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0), // Padding is managed by parent Container
                child: Container(
                  padding: const EdgeInsets.all(30.0), // Inner padding of the form card
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the form card
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxWidth: 600), // Max width for the form card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Takes minimum space vertically
                    children: [
                      _buildProfileInputField("Loginuser", name),
                      _buildProfileInputField("First Name", firstname),
                      _buildProfileInputField("Last Name", lastname),
                      _buildProfileInputField("Email", email),
                      _buildProfileInputField("Quality", quality),
                      _buildProfileInputField("Frominst", frominst),
                      _buildProfileInputField("Level Secure", levelsecure),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/verifypw');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3498DB), // Blue button
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(200, 50), // Ensure minimum size as per image
                          ),
                          child: const Text(
                            "Change password", // Text as per cons profil admin.png
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Main UI Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using LayoutBuilder for responsive design
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            // === Mobile Layout (Narrow Screen) ===
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFFECF0F1), // Matches main content background
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black54), // Color of the drawer icon
                title: const Text(
                  'Admin Dashboard', // A more generic title for the mobile AppBar
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              drawer: Drawer(child: _buildSidebarContent()), // Sidebar as a Drawer
              body: _buildMainContent(), // Main content (profile form or other selected view)
            );
          } else {
            // === Desktop/Tablet Layout (Wide Screen) ===
            return Row(
              children: [
                // Fixed Left Sidebar
                _buildSidebarContent(),
                // Right Content Area
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}