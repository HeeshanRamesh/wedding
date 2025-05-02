import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/screens/add_guest_screen.dart';
import '../services/guest_service.dart';
import 'package:wedding_planner/screens/set_invitation_screen.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  List<Map<String, dynamic>> guests = [];

  @override
  void initState() {
    super.initState();
    fetchGuests();
  }

  Future<void> fetchGuests() async {
    final data = await GuestService.getGuests();
    setState(() {
      guests = data;
    });
  }

  Future<void> launchWhatsapp(String phone, String message) async {
    final formattedPhone = phone.replaceAll(RegExp(r'[^\\d]'), '');

    if (formattedPhone.isEmpty || formattedPhone.length < 10) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid phone number")));
      return;
    }

    final url =
        'https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Guests', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddGuestScreen()),
              );
              fetchGuests();
            },
            icon: const Icon(Icons.add, color: Color(0xFF00B8E4)),
            label: const Text('Add new', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _guestStats(),
            const SizedBox(height: 16),
            _invitationBanner(),
            const SizedBox(height: 16),
            _searchAndFilter(),
            const SizedBox(height: 12),
            if (guests.isEmpty)
              const Center(child: Text("No guests found"))
            else
              ...guests.map((g) => _guestCard(g)),
          ],
        ),
      ),
    );
  }

  Widget _guestStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _countTile('Total guest', guests.length.toString()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _circleGradientIcon(Icons.mark_email_read),
                  const SizedBox(width: 6),
                  const Text('give an Invitations'),
                  const SizedBox(width: 6),
                  Text(
                    guests
                        .where((g) => g['invitationSent'] == true)
                        .length
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007D8C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.verified, color: Color(0xFF007D8C)),
                  SizedBox(width: 6),
                  Text('Confirmed attendance'),
                  SizedBox(width: 6),
                  Text(
                    '0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007D8C),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _invitationBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6FFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Invitation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Send invitation to your guest before 10 - 15 days of marriage',
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SetInvitationScreen(),
                  ),
                );
                if (result == true) fetchGuests();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchAndFilter() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search guests...',
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            _chip('All', isSelected: true),
            _chip('Friends'),
            _chip('Family'),
          ],
        ),
      ],
    );
  }

  Widget _guestCard(Map<String, dynamic> guest) {
    final name = guest['name'] ?? '';
    final side = guest['side'] ?? '';
    final category = guest['category'] ?? '';
    final phone = guest['phone'] ?? '';
    final invitationSent = guest['invitationSent'] ?? false;
    final invitationLink = guest['invitationLink'] ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (invitationSent) ...[
                        const SizedBox(width: 6),
                        const Text(
                          ' (invitation sent)',
                          style: TextStyle(
                            color: Color(0xFF00E7AC),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    '(${side[0].toUpperCase()}${side.substring(1)} side)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(category),
                    backgroundColor: Colors.grey[200],
                    labelStyle: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap:
                      () => launchWhatsapp(
                        phone,
                        'You are invited to the wedding!',
                      ),
                  child: _circleGradientIcon(Icons.phone),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (invitationLink.isNotEmpty) {
                      Clipboard.setData(ClipboardData(text: invitationLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Link copied to clipboard"),
                        ),
                      );
                    }
                  },
                  child: _circleGradientIcon(Icons.link),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse(invitationLink);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Could not open invitation link"),
                        ),
                      );
                    }
                  },
                  child: _circleGradientIcon(Icons.open_in_browser),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _countTile(String label, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF007D8C),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _chip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? const Color(0xFF00B8E4) : Colors.grey[200],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 13,
      ),
    );
  }

  Widget _circleGradientIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
        ),
      ),
      child: Center(child: Icon(icon, color: Colors.white, size: 20)),
    );
  }
}
