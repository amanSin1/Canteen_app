import 'package:canteen_app/pages/contact_us_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print("DisplayName in ProfilePage: ${user?.displayName}");  // Debugging line

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/Dexter_Morgan.png'), // Replace with your image asset
            ),
            SizedBox(height: 16),
            Text(
              user?.displayName ?? 'Unknown',  // Displaying the displayName
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              user?.email ?? 'No Email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                child: Column(
                  children: [
                    ProfileInfoRow(title: 'Total Order', value: '0'),
                    Divider(color: Colors.grey[300]),
                    ProfileInfoRow(title: 'Order Completed', value: '0'),
                    Divider(color: Colors.grey[300]),
                    ProfileInfoRow(title: 'Order Cancelled', value: '0'),
                  ],
                ),
              ),
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                Get.to(ContactUsPage());
              },

              label: Text(
                'contact us',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
