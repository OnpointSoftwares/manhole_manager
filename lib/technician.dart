import 'package:flutter/material.dart';

class TechnicianPage extends StatefulWidget {
  const TechnicianPage({super.key});

  @override
  _TechnicianPageState createState() => _TechnicianPageState();
}

class _TechnicianPageState extends State<TechnicianPage> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Inspect Manhole 1', 'location': 'Main Street', 'status': 'Pending'},
    {'title': 'Repair Manhole 2', 'location': 'Elm Avenue', 'status': 'In Progress'},
    {'title': 'Install New Cover for Manhole 3', 'location': 'River Road', 'status': 'Completed'},
  ];

  // Method to update task status
  void _updateTaskStatus(int index, String status) {
    setState(() {
      _tasks[index]['status'] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technician Dashboard'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to completed tasks
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to account settings
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            child: ListTile(
              title: Text(task['title']),
              subtitle: Text('Location: ${task['location']}\nStatus: ${task['status']}'),
              leading: const Icon(Icons.work),
              trailing: task['status'] == 'Completed'
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                onPressed: () {
                  // Mark the task as completed
                  _updateTaskStatus(index, 'Completed');
                },
                child: const Text('Complete'),
              ),
              onTap: () {
                // Navigate to task details
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding new task or other functionality
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
