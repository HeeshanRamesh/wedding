import 'package:flutter/material.dart';
import '../screens/message.screen.dart'; // correct if message_screen.dart is in lib/screens/

// Ensure that the MessageScreen class is defined in message_screen.dart
 // <-- adjust path as needed

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFE6FFFF),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text(
              'Sherwin Fernando',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: GestureDetector(
              onTap: () {},
              child: Text(
                'View Profile',
                style: TextStyle(color: Color(0xFF00B8E4)),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
          _buildMenuItem(context, Icons.store, 'Vendor Bookings'),
          _buildMenuItem(context, Icons.chat, 'Chat'),
          _buildMenuItem(context, Icons.help_outline, 'Help & Support'),
          _buildMenuItem(context, Icons.privacy_tip, 'Privacy & Policy'),
          _buildMenuItem(context, Icons.security, 'Terms & Conditions'),
          _buildMenuItem(context, Icons.lock, 'Change Password'),
          _buildMenuItem(context, Icons.logout, 'Logout'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF007D8C)),
      title: Text(title, style: TextStyle(fontSize: 14)),
      onTap: () {
        if (title == 'Chat') {
          Navigator.pop(context); // Close the drawer first
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MessageScreen()),
          );
        }
      },
    );
  }
}
