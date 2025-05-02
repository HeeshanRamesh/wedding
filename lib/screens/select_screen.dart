import 'package:flutter/material.dart';
import 'signup_screen.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  _SelectRoleScreenState createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  String selectedRole = '';

  void selectRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Select Role',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _roleCard(
                  'customer',
                  'assets/icons/customer.png',
                  selectedRole == 'customer',
                ),
                const SizedBox(width: 20),
                _roleCard(
                  'vendor',
                  'assets/icons/vendor.png',
                  selectedRole == 'vendor',
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00E7AC), Color(0xFF047284)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed:
                      selectedRole.isEmpty
                          ? null
                          : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        SignUpScreen(role: selectedRole),

                              ),
                            );

                          },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(String role, String imagePath, bool isSelected) {
    return GestureDetector(
      onTap: () => selectRole(role),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              role[0].toUpperCase() + role.substring(1),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
