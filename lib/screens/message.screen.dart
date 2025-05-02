import 'package:flutter/material.dart';
import 'chat_detail_screen.dart'; // <-- Import this

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(12),
        itemBuilder:
            (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatDetailScreen()),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/vender.png'),
                ),
                title: Text('Dream Bells - Photography'),
                subtitle: Text('Okay thanks for your time'),
                trailing: Text('21.15'),
              ),
            ),
      ),
    );
  }
}
