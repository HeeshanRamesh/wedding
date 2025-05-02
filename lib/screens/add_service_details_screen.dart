import 'package:flutter/material.dart';
import 'package:wedding_planner/services/user_service.dart';

class AddServiceDetailsScreen extends StatefulWidget {
  const AddServiceDetailsScreen({super.key});

  @override
  State<AddServiceDetailsScreen> createState() =>
      _AddServiceDetailsScreenState();
}

class _AddServiceDetailsScreenState extends State<AddServiceDetailsScreen> {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController paymentPolicyController = TextEditingController();

  String? selectedServiceType;
  bool isLoading = false;

  final List<String> serviceTypes = ['Photography', 'Decoration', 'Catering'];

  Future<void> _submitServiceDetails() async {
    if (serviceNameController.text.trim().isEmpty ||
        selectedServiceType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    final success = await UserService.saveVendorService({
      "serviceName": serviceNameController.text.trim(),
      "type": selectedServiceType,
      "description": descriptionController.text.trim(),
      "paymentPolicy": paymentPolicyController.text.trim(),
    });

    setState(() => isLoading = false);

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to save service")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Add Service Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildLabel('Service Name'),
            _buildTextField(serviceNameController, hint: 'Service 1'),
            const SizedBox(height: 16),

            _buildLabel('Service Type'),
            _buildDropdown(),

            const SizedBox(height: 16),
            _buildLabel('Description'),
            _buildMultilineField(descriptionController),

            const SizedBox(height: 24),
            const Text(
              'Upload photos or Videos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _uploadBox(),

            const SizedBox(height: 24),
            _buildLabel('Payment Policy'),
            _buildMultilineField(paymentPolicyController),

            const SizedBox(height: 30),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitServiceDetails,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
      decoration: InputDecoration(
        hintText: hint ?? '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildMultilineField(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Type here",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedServiceType,
        isExpanded: true,
        hint: const Text("Select"),
        underline: const SizedBox(),
        items:
            serviceTypes.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
        onChanged: (value) {
          setState(() => selectedServiceType = value);
        },
      ),
    );
  }

  Widget _uploadBox() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF00B8E4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.cloud_upload, size: 30, color: Color(0xFF00B8E4)),
      ),
    );
  }
}
