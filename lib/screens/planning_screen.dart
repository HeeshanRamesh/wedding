import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/checklist_screen.dart';
import 'package:wedding_planner/widgets/bottom_navbar.dart';
import 'package:wedding_planner/screens/guest_list_screen.dart';
// <-- Add this import if you have the CheckList screen
import 'package:wedding_planner/screens/invitation_template_screen.dart';
import 'package:wedding_planner/screens/choose_category_screen.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _planningCard('Budget', 'assets/images/budget.png'),
            _planningCard('Guest List', 'assets/images/guestlist.png'),
            _planningCard('Invitation', 'assets/images/invitation.png'),
            _planningCard('Check List', 'assets/images/checklist.png'),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _planningCard(String title, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          if (title == 'Guest List') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GuestListScreen()),
            );
          } else if (title == 'Check List') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckListScreen()),
            );
          } else if (title == 'Invitation') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const InvitationTemplateScreen(),
              ),
            );
          } else if (title == 'Budget') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChooseCategoryScreen()),
            );
          } else {
            // You can handle 'Budget' or 'Invitation' here too later
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
