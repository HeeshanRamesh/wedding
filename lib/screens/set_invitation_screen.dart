import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/invitation_service.dart';
import 'select_guests_for_invitation_screen.dart';

class SetInvitationScreen extends StatefulWidget {
  const SetInvitationScreen({super.key});

  @override
  State<SetInvitationScreen> createState() => _SetInvitationScreenState();
}

class _SetInvitationScreenState extends State<SetInvitationScreen> {
  final TextEditingController daysController = TextEditingController();
  DateTime? selectedWeddingDate;

  Future<void> handleSave() async {
    final days = int.tryParse(daysController.text.trim());
    if (days == null || selectedWeddingDate == null) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return;
    }

    final formattedDate = selectedWeddingDate!.toIso8601String();
    final success = await InvitationService.saveInvitationSettings(
      weddingDate: formattedDate,
      sendBeforeDays: days,
    );

    if (success) {
      Fluttertoast.showToast(msg: "Settings saved");

      // Navigate to guest selector after saving
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SelectGuestsForInvitationScreen(),
        ),
      );

      if (result == true) {
        Fluttertoast.showToast(msg: "Invitations sent to selected guests");
        Navigator.pop(context); // return to previous screen
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to save");
    }
  }

  Future<void> pickWeddingDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        selectedWeddingDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Set Invitation',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set invitation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'How many days before the wedding should we send the request',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: daysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Type amount of days',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: pickWeddingDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedWeddingDate != null
                          ? "${selectedWeddingDate!.toLocal()}".split(' ')[0]
                          : "Select Wedding Date",
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
}
