import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/user_service.dart';

class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({super.key});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEmail();
  }

  Future<void> fetchEmail() async {
    final data = await UserService.getProfile();
    if (data != null) {
      setState(() {
        emailController.text = data['user']['email'] ?? '';
      });
    } else {
      Fluttertoast.showToast(msg: "Failed to load email");
    }
  }

  Future<void> updateEmail() async {
    final success = await UserService.updateEmail(emailController.text.trim());
    if (success) {
      Fluttertoast.showToast(msg: "Email updated successfully");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Failed to update email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Email")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Your Email"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateEmail, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
