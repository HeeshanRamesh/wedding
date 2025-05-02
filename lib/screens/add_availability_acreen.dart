import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_planner/services/user_service.dart';

class AddAvailabilityScreen extends StatefulWidget {
  const AddAvailabilityScreen({super.key});

  @override
  State<AddAvailabilityScreen> createState() => _AddAvailabilityScreenState();
}

class _AddAvailabilityScreenState extends State<AddAvailabilityScreen> {
  final Set<DateTime> _selectedDates = {};
  bool isLoading = false;

  Future<void> saveAvailability() async {
    setState(() => isLoading = true);

    // Convert dates to ISO format
    final dates = _selectedDates.map((date) => date.toIso8601String()).toList();

    final success = await UserService.updateAvailability(dates);

    setState(() => isLoading = false);

    if (success) {
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update availability")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Availability',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate:
                  (day) => _selectedDates.any(
                    (d) =>
                        d.year == day.year &&
                        d.month == day.month &&
                        d.day == day.day,
                  ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDates.contains(selectedDay)
                      ? _selectedDates.remove(selectedDay)
                      : _selectedDates.add(selectedDay);
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFF00E7AC),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No of days selected "),
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E7AC),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 6),
              Text("${_selectedDates.length} Unavailable"),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveAvailability,
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
                      colors: [Color(0xFF00E7AC), Color(0xFF00B8E4)],
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
          ),
        ],
      ),
    );
  }
}
