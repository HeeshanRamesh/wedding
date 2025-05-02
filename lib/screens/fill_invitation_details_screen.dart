import 'package:flutter/material.dart';

class FillInvitationDetailsScreen extends StatefulWidget {
  const FillInvitationDetailsScreen({super.key});

  @override
  State<FillInvitationDetailsScreen> createState() =>
      _FillInvitationDetailsScreenState();
}

class _FillInvitationDetailsScreenState
    extends State<FillInvitationDetailsScreen> {
  final _brideNameController = TextEditingController();
  final _groomNameController = TextEditingController();
  final _weddingDateController = TextEditingController();
  final _timeController = TextEditingController();
  final _venueController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _weddingDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fill details of invitation',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Bride Name'),
            _buildInputField(
              controller: _brideNameController,
              hint: 'Bride Name',
            ),
            const SizedBox(height: 16),

            _buildLabel('Groom Name'),
            _buildInputField(
              controller: _groomNameController,
              hint: 'Groom Name',
            ),
            const SizedBox(height: 16),

            _buildLabel('Wedding Date'),
            _buildInputField(
              controller: _weddingDateController,
              hint: 'Wedding Date',
              readOnly: true,
              suffixIcon: Icons.calendar_today,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),

            _buildLabel('Time'),
            _buildInputField(
              controller: _timeController,
              hint: 'Time',
              readOnly: true,
              suffixIcon: Icons.access_time,
              onTap: _selectTime,
            ),
            const SizedBox(height: 16),

            _buildLabel('Wedding Venue'),
            _buildInputField(
              controller: _venueController,
              hint: 'Wedding Venue',
              suffixIcon: Icons.location_on,
            ),
            const SizedBox(height: 16),

            _buildLabel('Your Message'),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save logic
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600, // Slightly bolder than w500
        fontSize: 15, // Optional: slightly increase size too
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    IconData? suffixIcon,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon:
            suffixIcon != null ? Icon(suffixIcon, color: Colors.teal) : null,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
