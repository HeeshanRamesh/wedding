import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/shortlisted_vendors_screen.dart';
import 'package:wedding_planner/widgets/bottom_navbar.dart';
import 'package:wedding_planner/screens/booked_vendors_screen.dart';



class VendorDirectoryScreen extends StatefulWidget {
  const VendorDirectoryScreen({super.key});

  @override
  State<VendorDirectoryScreen> createState() => _VendorDirectoryScreenState();
}

class _VendorDirectoryScreenState extends State<VendorDirectoryScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / 3.5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Vendors', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search the vendors...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Booked & Shortlisted
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCard('Booked Vendors', '05', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookedVendorsScreen(),
                        ),
                      );
                    }),
                    _statCard('Shortlisted Vendors', '09', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShortListedVendorsScreen(),
                        ),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 20),

                // Category grid
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: GridView.builder(
                    itemCount: 15,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (constraints.maxWidth < 600) ? 3 : 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return _categoryCard(
                        icon: Icons.camera_alt,
                        label: 'Photography',
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String title, String count, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF00B8E4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _categoryCard({required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () {
        // Navigate to vendor list based on category
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Color(0xFF00B8E4)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
