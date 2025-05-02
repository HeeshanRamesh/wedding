import 'package:flutter/material.dart';
import 'package:wedding_planner/services/user_service.dart';

class AddVendorPackageScreen extends StatefulWidget {
  const AddVendorPackageScreen({super.key});

  @override
  State<AddVendorPackageScreen> createState() => _AddVendorPackageScreenState();
}

class _AddVendorPackageScreenState extends State<AddVendorPackageScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  Future<void> submitPackage() async {
    final success = await UserService.addVendorPackage({
      'packageName': nameController.text.trim(),
      'packagePrice': priceController.text.trim(),
      'description': descriptionController.text.trim(),
    });

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to add package')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Add Package', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildLabel('Package Name'),
            _buildTextField(nameController, hint: 'Enter package name'),
            const SizedBox(height: 16),
            _buildLabel('Price'),
            _buildTextField(priceController, hint: 'Enter price'),
            const SizedBox(height: 16),
            _buildLabel('Description'),
            _buildTextArea(descriptionController),
            const SizedBox(height: 30),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitPackage,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00B8E4), Color(0xFF00E7AC)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w500));
  }

  Widget _buildTextField(TextEditingController controller, {String? hint}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Type here",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
