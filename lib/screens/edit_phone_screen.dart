import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/user_service.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  final TextEditingController phoneController =
      TextEditingController(); // ✅ Fixed

  @override
  void initState() {
    super.initState();
    fetchPhone();
  }

  Future<void> fetchPhone() async {
    final data = await UserService.getProfile();
    if (data != null) {
      setState(() {
        phoneController.text = data['user']['phone'] ?? '';
      });
    } else {
      Fluttertoast.showToast(msg: "Failed to load phone");
    }
  }

  Future<void> updatePhone() async {
    final success = await UserService.updatePhone(phoneController.text.trim());
    if (success) {
      Fluttertoast.showToast(msg: "Phone updated successfully");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Failed to update phone");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Phone")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone, // ✅ Fixed
              decoration: const InputDecoration(labelText: "Your Phone"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updatePhone, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
