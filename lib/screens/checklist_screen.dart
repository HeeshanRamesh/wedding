import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/add_task_screen.dart';
import 'package:wedding_planner/screens/vendor_task_screen.dart';
import 'package:wedding_planner/services/user_service.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final fetchedTasks = await UserService.getTasks();
    setState(() {
      tasks = fetchedTasks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddTaskScreen()),
              ).then((_) => _loadTasks()); // Refresh after return
            },
            icon: const Icon(Icons.add, color: Color(0xFF00B8E4)),
            label: const Text(
              'Add new task',
              style: TextStyle(color: Color(0xFF00B8E4)),
            ),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : tasks.isEmpty
              ? const Center(child: Text('No tasks found'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final title = task['name'] ?? 'Untitled';
                  final timeline = task['timeline'] ?? '';
                  return _checkItemCard(context, title, 'Timeline: $timeline');
                },
              ),
    );
  }

  Widget _checkItemCard(BuildContext context, String title, String subtitle) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => VendorTasksScreen(
                  taskIndex: tasks.indexWhere((t) => t['name'] == title),
                ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.edit, color: Color(0xFF00B8E4)),
        ),
      ),
    );
  }
}
