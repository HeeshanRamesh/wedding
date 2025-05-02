import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/guest_service.dart';

class AddGuestScreen extends StatefulWidget {
  const AddGuestScreen({super.key});

  @override
  State<AddGuestScreen> createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedSide = 'Bride';
  List<String> selectedCategories = [];

  Future<void> handleAddGuest() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty || selectedCategories.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all required fields");
      return;
    }

    final success = await GuestService.addGuest(
      name: name,
      phone: phone,
      side: selectedSide,
      category: selectedCategories.first, // assuming only one selected
    );

    if (success) {
      Fluttertoast.showToast(msg: "Guest added successfully");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Failed to add guest");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add guest', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("What's name of the guest"),
            const SizedBox(height: 6),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Select the side'),
            const SizedBox(height: 6),
            Row(
              children:
                  ['Bride', 'Groom'].map((side) {
                    final selected = side == selectedSide;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(side),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            selectedSide = side;
                          });
                        },
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Phone number'),
            const SizedBox(height: 6),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Code...',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            const Text('Select Category'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children:
                  ['Friends', 'Colleagues', 'Family'].map((category) {
                    final selected = selectedCategories.contains(category);
                    return FilterChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (val) {
                        setState(() {
                          if (val) {
                            selectedCategories.add(category);
                          } else {
                            selectedCategories.remove(category);
                          }
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: handleAddGuest,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('or'),
                ),
                Expanded(child: Divider()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
