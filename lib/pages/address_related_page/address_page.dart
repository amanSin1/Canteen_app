

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/razorpay_payment.dart';


import 'address_page_textfield.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user?.uid;
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController altPhController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController colonyController = TextEditingController();

  Future<void> saveAddress(String userId) async {
    if (nameController.text.isEmpty ||
        phController.text.isEmpty ||
        pinController.text.isEmpty ||
        cityController.text.isEmpty ||
        houseController.text.isEmpty ||
        colonyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields', style: TextStyle(color: Colors.blueGrey))),
      );
      return;
    }

    try {
      final addressData = {
        'name': nameController.text,
        'phone': phController.text,
        'pincode': pinController.text,
        'city': cityController.text,
        'altPhone': altPhController.text,
        'state': stateController.text,
        'houseNo': houseController.text,
        'colony': colonyController.text,
      };

      // Save address under the user's document
      final userAddressCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('addresses');

      await userAddressCollection.add(addressData);
      print('Address saved successfully!');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RazorPayPage()),
      );
    } catch (e) {
      print('Failed to save address: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add delivery address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddressPageTextfield(
                hintText: 'Full Name (Required)*',
                controller: nameController,
                obscureText: false,
              ),
              SizedBox(height: 25),
              AddressPageTextfield(
                hintText: 'Phone number (Required)*',
                controller: phController,
                obscureText: false,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: AddressPageTextfield(
                      hintText: 'Pincode (Required)*',
                      controller: pinController,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: AddressPageTextfield(
                      hintText: 'City (Required)*',
                      controller: cityController,
                      obscureText: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: AddressPageTextfield(
                      hintText: 'Add alt phone no.',
                      controller: altPhController,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: AddressPageTextfield(
                      hintText: 'State',
                      controller: stateController,
                      obscureText: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              AddressPageTextfield(
                hintText: 'House No., Building Name (Required)*',
                controller: houseController,
                obscureText: false,
              ),
              SizedBox(height: 30),
              AddressPageTextfield(
                hintText: 'Road name, Area, Colony (Required)*',
                controller: colonyController,
                obscureText: false,
              ),
              SizedBox(height: 20), // Added spacing to separate from the button
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (userId != null) {
            saveAddress(userId!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not logged in')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // No border radius
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
