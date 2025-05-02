import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wedding_planner/services/user_service.dart';

class VendorProfileSetupScreen extends StatefulWidget {
  const VendorProfileSetupScreen({super.key});

  @override
  State<VendorProfileSetupScreen> createState() =>
      _VendorProfileSetupScreenState();
}

class _VendorProfileSetupScreenState extends State<VendorProfileSetupScreen> {
  final TextEditingController vendorNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();

  bool isLoading = false;
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    fetchVendorProfile();
  }

  Future<void> fetchVendorProfile() async {
    final profile = await UserService.getProfile();
    if (profile != null) {
      final user = profile['user'];
      vendorNameController.text = user['name'] ?? '';
      businessNameController.text = user['businessName'] ?? '';
      phoneController.text = user['phone'] ?? '';
      emailController.text = user['email'] ?? '';
      addressController.text = user['address'] ?? '';
      instagramController.text = user['socialLinks']?['instagram'] ?? '';
      facebookController.text = user['socialLinks']?['facebook'] ?? '';
      youtubeController.text = user['socialLinks']?['youtube'] ?? '';
    }
    setState(() => isFetching = false);
  }

  Future<void> saveProfile() async {
    setState(() => isLoading = true);
    final success = await UserService.updateVendorSetup({
      "name": vendorNameController.text.trim(),
      "businessName": businessNameController.text.trim(),
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "address": addressController.text.trim(),
      "instagram": instagramController.text.trim(),
      "facebook": facebookController.text.trim(),
      "youtube": youtubeController.text.trim(),
    });
    setState(() => isLoading = false);

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body:
          isFetching
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Profile Setup',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Please complete your profile',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Vendor Name', vendorNameController),
                  _buildTextField('Business Name', businessNameController),
                  _buildTextField('Phone Number', phoneController),
                  _buildTextField('Email-id', emailController),
                  _buildTextField('Address', addressController),
                  const SizedBox(height: 24),
                  const Text(
                    'Add Social Media Accounts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _socialField(
                    FontAwesomeIcons.instagram,
                    'Instagram URL',
                    instagramController,
                  ),
                  _socialField(
                    FontAwesomeIcons.facebook,
                    'Facebook URL',
                    facebookController,
                  ),
                  _socialField(
                    FontAwesomeIcons.youtube,
                    'Youtube URL',
                    youtubeController,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B8E4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
                ],
              ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _socialField(
    IconData icon,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18),
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
