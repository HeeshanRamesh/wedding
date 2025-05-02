import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/bottom_navbar.dart';
import 'package:wedding_planner/widgets/rating_dialog%20.dart';


class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Booking Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const RatingDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B8E4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add Rating',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking ID : #1253',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/profilepic.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Wedding Photography',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'John Doe, 45 Elm Street, Los Angeles, USA',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '9 April 2023 07.00 Am',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const Row(
            children: [
              Text(
                'Date & Time : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text('9 April 2025, 7.00 am\n10 April 2025, 7.00 pm'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text(
                'Amount paid : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text('2500.00'),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address : ', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Expanded(child: Text('196/6 Panchikawatte Road, 10')),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Packages Selected',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic package',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00B8E4),
                  ),
                ),
                SizedBox(height: 4),
                Text('Rs. 500.00'),
                SizedBox(height: 8),
                Text(
                  'Basic Package includes Wedding photography which is a specialty in photography that is primarily focused on the photography of events and activities.',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Payment Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Sub Total'), Text('Rs. 6,896')],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Addon on Service'), Text('Rs. 0.00')],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('GST%'), Text('Rs. 200')],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Offer'), Text('Rs. 1,000')],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs. 6,696',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
