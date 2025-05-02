import 'package:flutter/material.dart';
import 'package:wedding_planner/services/user_service.dart';

class VendorTasksScreen extends StatefulWidget {
  final int taskIndex; // receive index from parent

  const VendorTasksScreen({super.key, required this.taskIndex});

  @override
  State<VendorTasksScreen> createState() => _VendorTasksScreenState();
}

class _VendorTasksScreenState extends State<VendorTasksScreen> {
  List<Map<String, dynamic>> subtasks = [];
  String deadline = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubtasks();
  }

  Future<void> _fetchSubtasks() async {
    final result = await UserService.getSubtasks(widget.taskIndex);
    if (result != null) {
      setState(() {
        subtasks = List<Map<String, dynamic>>.from(result['subtasks']);
        deadline = result['deadline'] ?? '';
        isLoading = false;
      });
    }
  }

  void _addSubtask(String title) {
    setState(() {
      subtasks.add({'title': title, 'completed': false});
    });
    // Optional: Call backend to persist subtask
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sub Tasks")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text("Deadline: $deadline"),
                const SizedBox(height: 12),
                ...subtasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final task = entry.value;

                  return ListTile(
                    leading: Checkbox(
                      value: task['completed'],
                      onChanged: (value) {
                        setState(() {
                          subtasks[index]['completed'] = value!;
                        });
                        // Optional: Call API to update task completion
                      },
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: task['completed']
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          subtasks.removeAt(index);
                        });
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                Center(
                  child: TextButton.icon(
                    onPressed: () => _showAddSubTaskDialog(context),
                    icon: const Icon(Icons.add, color: Color(0xFF00B8E4)),
                    label: const Text('Add new task',
                        style: TextStyle(color: Color(0xFF00B8E4))),
                  ),
                )
              ],
            ),
    );
  }

  void _showAddSubTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Subtask'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                _addSubtask(text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
