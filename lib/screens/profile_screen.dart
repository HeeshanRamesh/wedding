import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/edit_email_screen.dart';
import 'package:wedding_planner/screens/edit_name_page.dart';
import 'package:wedding_planner/screens/edit_phone_screen.dart';
import 'package:wedding_planner/screens/my_events_screen.dart';
import '../services/user_service.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


String email = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await UserService.getProfile();
    if (data != null && mounted) {
      setState(() {
        email = data['user']['email'] ?? '';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.topRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                ),
                Positioned(
                  top: 5,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              email.isNotEmpty ? email : 'Loading...',
              style: const TextStyle(color: Color(0xFF00B8E4)),
            ),

            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6FFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildProfileRow('Name', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditNameScreen())
                    );
                  }),
                  _buildProfileRow('Email', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditEmailScreen(),
                      ),
                    );
                  }),

                   _buildProfileRow('Phone Number', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditPhoneScreen(),
                      ),
                    );
                  }),
                  _buildProfileRow('Change password', () {
                    // TODO: Navigate to ChangePasswordPage
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MyEventsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'My Events',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: const Color(0xFF007D8C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Vendor'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Planning'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text(label),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
