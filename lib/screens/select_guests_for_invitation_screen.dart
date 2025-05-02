import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/guest_service.dart';

class SelectGuestsForInvitationScreen extends StatefulWidget {
  const SelectGuestsForInvitationScreen({super.key});

  @override
  State<SelectGuestsForInvitationScreen> createState() =>
      _SelectGuestsForInvitationScreenState();
}

class _SelectGuestsForInvitationScreenState
    extends State<SelectGuestsForInvitationScreen> {
  List<Map<String, dynamic>> guests = [];
  Set<String> selectedGuestIds = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchGuests();
  }

  Future<void> fetchGuests() async {
    final data = await GuestService.getGuests();
    setState(() => guests = data);
  }

  Future<void> sendInvitations() async {
    setState(() => isLoading = true);
    final success = await GuestService.sendInvitations(
      selectedGuestIds.toList(),
    );
    setState(() => isLoading = false);

    if (success) {
      Fluttertoast.showToast(msg: 'Invitations sent!');
      Navigator.pop(context, true); // Return to previous screen
    } else {
      Fluttertoast.showToast(msg: 'Failed to send invitations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Guests'), leading: BackButton()),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  ListTile(
                    leading: Checkbox(
                      value: selectedGuestIds.length == guests.length,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedGuestIds =
                                guests.map((g) => g['_id'] as String).toSet();
                          } else {
                            selectedGuestIds.clear();
                          }
                        });
                      },
                    ),
                    title: const Text("Select All"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: guests.length,
                      itemBuilder: (_, index) {
                        final guest = guests[index];
                        final id = guest['_id'];
                        return CheckboxListTile(
                          title: Text(guest['name']),
                          subtitle: Text(
                            '(${guest['side']}) - ${guest['category']}',
                          ),
                          value: selectedGuestIds.contains(id),
                          onChanged: (val) {
                            setState(() {
                              val == true
                                  ? selectedGuestIds.add(id)
                                  : selectedGuestIds.remove(id);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            selectedGuestIds.isEmpty ? null : sendInvitations,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
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
                              'Send Invitations',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
    );
  }
}
