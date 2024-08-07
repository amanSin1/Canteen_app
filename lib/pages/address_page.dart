import 'package:canteen_app/pages/payment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'address_page_textfield.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController altPhController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController houseController = TextEditingController();

  final TextEditingController colonyController = TextEditingController();

  Future<void> saveAddress() async {
    try {
      // Create a map of the address data
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

      // Get a reference to the Firestore collection
      final addressCollection = FirebaseFirestore.instance.collection('addresses');

      // Add the address to Firestore
      await addressCollection.add(addressData);

      // Optionally, show a success message or navigate to another page
      print('Address saved successfully!');
      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
    } catch (e) {
      // Handle any errors that occur
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
                      hintText: 'Add alt phone no. (Required)*',
                      controller: altPhController,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: AddressPageTextfield(
                      hintText: 'State (Required)*',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: saveAddress,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 15,
            ),
          ),
          child: const Text(
            'Save Address',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
