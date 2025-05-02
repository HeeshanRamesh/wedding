import 'package:flutter/material.dart';

class AddPackagesScreen extends StatefulWidget {
  const AddPackagesScreen({super.key});

  @override
  State<AddPackagesScreen> createState() => _AddPackagesScreenState();
}

class _AddPackagesScreenState extends State<AddPackagesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedPrice;

  final List<String> priceOptions = [
    'Rs 1000',
    'Rs 2500',
    'Rs 5000',
    'Rs 10000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Packages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildLabel('Package Name'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Package 1',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            _buildLabel('Package Price'),
            DropdownButtonFormField<String>(
              value: selectedPrice,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              hint: const Text('Select'),
              items:
                  priceOptions.map((price) {
                    return DropdownMenuItem(value: price, child: Text(price));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPrice = value;
                });
              },
            ),
            const SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Add logic to add more packages
                },
                child: const Text(
                  '+ Add more packages',
                  style: TextStyle(
                    color: Color(0xFF007D8C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save action
                },
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
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
