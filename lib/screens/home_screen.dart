import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/bottom_navbar.dart';
import '../widgets/side_menu_drawer.dart';
import 'notification_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Home', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 280,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/frame.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Liza & Shefan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00B8E4),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCountdownTile('150', 'Days'),
                        _buildCountdownTile('05', 'Hours'),
                        _buildCountdownTile('05', 'Mins'),
                        _buildCountdownTile('05', 'Secs'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Until Our Wedding',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '08/04/2025',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _sectionHeader('Book Vendors', onViewAll: () {}),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _iconCard(icon: Icons.photo_camera, label: 'Photography'),
                  SizedBox(width: 12),
                  _iconCard(icon: Icons.music_note, label: 'Music'),
                  SizedBox(width: 12),
                  _iconCard(icon: Icons.fastfood, label: 'Catering'),
                  SizedBox(width: 12),
                  _iconCard(icon: Icons.card_giftcard, label: 'Gifts'),
                ],
              ),
            ),
            SizedBox(height: 20),
            _sectionHeader('Premium Vendors', onViewAll: () {}),
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 140,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/proposalImage.png',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wedding Photography',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Los Angeles, USA.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            _customInfoCard(
              title: 'Tasks',
              icon: Icons.check_box,
              leftValue: '05',
              leftLabel: 'Booked Vendors',
              rightValue: '05',
              rightLabel: 'Shortlisted Vendors',
            ),
            SizedBox(height: 10),
            _customInfoCard(
              title: 'Vendors',
              icon: null,
              leftValue: '05',
              leftLabel: 'Booked Vendors',
              rightValue: '05',
              rightLabel: 'Shortlisted Vendors',
            ),
            SizedBox(height: 10),
            _customInfoCard(
              title: 'Total guest',
              icon: null,
              leftValue: '150',
              leftLabel: '',
              rightItems: [
                {
                  'icon': Icons.mail_outline,
                  'label': 'give an Invitations',
                  'value': '50',
                },
                {
                  'icon': Icons.verified,
                  'label': 'Confirmed attendance',
                  'value': '50',
                },
              ],
            ),
            SizedBox(height: 10),
            _customInfoCard(
              title: 'Budget',
              icon: Icons.savings,
              leftValue: '05',
              leftLabel: 'Booked Vendors',
              rightValue: '05',
              rightLabel: 'Shortlisted Vendors',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF007D8C)),
      title: Text(title, style: TextStyle(fontSize: 14)),
      onTap: () {},
    );
  }

  Widget _buildCountdownTile(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text('View All', style: TextStyle(color: Colors.teal)),
        ),
      ],
    );
  }

  Widget _iconCard({required IconData icon, required String label}) {
    return Container(
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Color(0xFF007D8C)),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _customInfoCard({
    required String title,
    IconData? icon,
    String? leftValue,
    String? leftLabel,
    String? rightValue,
    String? rightLabel,
    List<Map<String, dynamic>>? rightItems,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                if (icon != null) ...[
                  SizedBox(width: 6),
                  Icon(icon, color: Colors.teal, size: 18),
                ],
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leftValue ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007D8C),
                      ),
                    ),
                    if (leftLabel != null && leftLabel.isNotEmpty)
                      Text(leftLabel, style: TextStyle(color: Colors.black54)),
                  ],
                ),
                Container(height: 35, width: 1, color: Colors.grey[300]),
                if (rightItems == null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        rightValue ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007D8C),
                        ),
                      ),
                      if (rightLabel != null)
                        Text(
                          rightLabel,
                          style: TextStyle(color: Colors.black54),
                        ),
                    ],
                  ),
                ] else ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        rightItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  item['icon'],
                                  size: 16,
                                  color: Colors.teal,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  item['label'],
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  item['value'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
