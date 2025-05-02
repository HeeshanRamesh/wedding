// AddTaskScreen.dart

import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/checklist_screen.dart';
import 'package:wedding_planner/services/user_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  final _timelineController = TextEditingController();
  final _deadlineController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _taskController.dispose();
    _timelineController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _saveTask() async {
    final task = _taskController.text.trim();
    final timeline = _timelineController.text.trim();
    final deadline = _deadlineController.text.trim();

    if (task.isEmpty || timeline.isEmpty || deadline.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    setState(() => isLoading = true);

    final success = await UserService.addTask({
      "name": task,
      "timeline": timeline,
      "deadline": deadline,
    });

    setState(() => isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CheckListScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add task")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task name'),
            const SizedBox(height: 6),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Task',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Timeline'),
            const SizedBox(height: 6),
            TextField(
              controller: _timelineController,
              decoration: const InputDecoration(
                hintText: 'Before 6 months',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Deadline'),
            const SizedBox(height: 6),
            TextField(
              controller: _deadlineController,
              readOnly: true,
              onTap: _selectDeadline,
              decoration: const InputDecoration(
                hintText: '',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _saveTask,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
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
                                fontWeight: FontWeight.bold,
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
}
