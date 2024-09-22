import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ManholesScreen(),
    TechniciansScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 20.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back navigation functionality if needed
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/man.png", height: 30, width: 30),
            const SizedBox(width: 10),
            const Text(
              "Admin Home",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  break;
                case 'Settings':
                  _onItemTapped(3);
                  break;
                case 'Logout':
                  Navigator.pushNamed(context, "login");
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Settings', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(value: choice, child: Text(choice));
              }).toList();
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Manholes"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: "Technicians"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dashboard Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            color: Colors.blueAccent,
            child: ListTile(
              title: const Text('Total Users'),
              trailing: const Text('1,250'),
              leading: Icon(Icons.group),
              onTap: () {},
            ),
          ),
          Card(
            color: Colors.greenAccent,
            child: ListTile(
              leading: Icon(Icons.engineering),
              title: const Text('Active Technicians'),
              trailing: const Text('45'),
              onTap: () {},
            ),
          ),
          Card(
            color: Colors.orangeAccent,
            child: ListTile(
              leading: Icon(Icons.transfer_within_a_station),
              title: const Text('Pending Manhole Inspections'),
              trailing: const Text('12'),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle report generation
            },
            child: const Text('Generate Reports'),
          ),
        ],
      ),
    );
  }
}

class ManholesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('manholes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No manholes found'));
        }

        final manholes = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Manhole(location: data['location'], status: data['status']);
        }).toList();

        return ListView.builder(
          itemCount: manholes.length,
          itemBuilder: (context, index) {
            final manhole = manholes[index];
            return Card(
              child: ListTile(
                title: Text(manhole.location),
                subtitle: Text('Status: ${manhole.status}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ManholeDetailScreen(manhole: manhole)));
                },
              ),
            );
          },
        );
      },
    );
  }
}

class Manhole {
  final String location;
  final String status;

  Manhole({required this.location, required this.status});
}

class ManholeDetailScreen extends StatelessWidget {
  final Manhole manhole;

  ManholeDetailScreen({required this.manhole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(manhole.location), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Manhole Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(child: ListTile(title: const Text('Location'), subtitle: Text(manhole.location))),
            Card(child: ListTile(title: const Text('Status'), subtitle: Text(manhole.status))),
            ElevatedButton(onPressed: () {}, child: const Text('Start Maintenance')),
            ElevatedButton(onPressed: () {}, child: const Text('Schedule Inspection')),
          ],
        ),
      ),
    );
  }
}

class TechniciansScreen extends StatefulWidget {
  @override
  _TechniciansScreenState createState() => _TechniciansScreenState();
}

class _TechniciansScreenState extends State<TechniciansScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Technicians'), backgroundColor: Colors.redAccent),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search Technicians',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('technicians').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No technicians found'));
                }

                final technicians = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return Technician(
                    id: doc.id,
                    name: data['name'],
                    experience: data['experience'],
                    status: data['status'],
                    tasks: List<String>.from(data['tasks']),
                  );
                }).toList();

                final filteredTechnicians = technicians.where((technician) {
                  return technician.name.toLowerCase().contains(searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  itemCount: filteredTechnicians.length,
                  itemBuilder: (context, index) {
                    return TechnicianCard(technician: filteredTechnicians[index], onTaskAssigned: _assignTaskToTechnician);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _assignTaskToTechnician(Technician technician, String task) {
    setState(() {
      technician.tasks.add(task);
      FirebaseFirestore.instance.collection('technicians').doc(technician.id).update({'tasks': technician.tasks});
    });
  }
}

class Technician {
  final String id;
  final String name;
  final String experience;
  String status;
  List<String> tasks;

  Technician({
    required this.id,
    required this.name,
    required this.experience,
    required this.status,
    required this.tasks,
  });
}

class TechnicianCard extends StatelessWidget {
  final Technician technician;
  final Function(Technician, String) onTaskAssigned;

  TechnicianCard({required this.technician, required this.onTaskAssigned});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(technician.name),
        subtitle: Text('Experience: ${technician.experience} \nStatus: ${technician.status}'),
        trailing: IconButton(
          icon: Icon(Icons.add_task),
          onPressed: () {
            // Example task assignment logic
            onTaskAssigned(technician, 'New Task');
          },
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool twoFactorAuthEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    DocumentSnapshot settingsDoc = await FirebaseFirestore.instance.collection('settings').doc('user_settings').get();
    if (settingsDoc.exists) {
      setState(() {
        notificationsEnabled = settingsDoc['notifications'] ?? true;
        twoFactorAuthEnabled = settingsDoc['twoFactorAuth'] ?? false;
      });
    }
  }

  void _updateSettings() {
    FirebaseFirestore.instance.collection('settings').doc('user_settings').set({
      'notifications': notificationsEnabled,
      'twoFactorAuth': twoFactorAuthEnabled,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: const Text('Enable Notifications'),
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
              _updateSettings();
            });
          },
        ),
        SwitchListTile(
          title: const Text('Enable Two-Factor Authentication'),
          value: twoFactorAuthEnabled,
          onChanged: (value) {
            setState(() {
              twoFactorAuthEnabled = value;
              _updateSettings();
            });
          },
        ),
      ],
    );
  }
}
