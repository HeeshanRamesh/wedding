import 'package:flutter/material.dart';
 // Make sure this exists

class VendorChatsScreen extends StatefulWidget {
  const VendorChatsScreen({super.key});

  @override
  State<VendorChatsScreen> createState() => _VendorChatsScreenState();
}

class _VendorChatsScreenState extends State<VendorChatsScreen> {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Message',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
     
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return _chatTile();
        },
      ),
    );
  }

  Widget _chatTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/images/profilepic.jpg',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Alexa Jain',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Okay thanks for your time',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Text(
            '21.15',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
