import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/user_service.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  Future<void> fetchName() async {
    final data = await UserService.getProfile();
    if (data != null) {
      setState(() {
        nameController.text = data['user']['name'] ?? '';
      });
    } else {
      Fluttertoast.showToast(msg: "Failed to load name");
    }
  }

  Future<void> updateName() async {
    final success = await UserService.updateName(nameController.text.trim());
    if (success) {
      Fluttertoast.showToast(msg: "Name updated successfully");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Failed to update name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Name")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Your Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateName, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
