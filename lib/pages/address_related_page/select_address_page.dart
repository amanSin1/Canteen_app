import 'package:canteen_app/model/razorpay_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'address_page.dart'; // Import the AddressPage

class SelectAddressPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems; // Accept cart items
  final List<Map<String, dynamic>> addresses; // Accept addresses

  const SelectAddressPage({super.key, required this.cartItems, this.addresses = const []});

  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  int _selectedAddressIndex = -1; // To keep track of the selected address
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Address"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.blue),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => AddressPage()), // Navigate to AddressPage with cartItems
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      textStyle: TextStyle(fontSize: 20.0),
                    ),
                    child: Text('Add a new address'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.addresses.length,
              itemBuilder: (context, index) {
                final address = widget.addresses[index];
                return ListTile(
                  leading: Radio(
                    value: index,
                    groupValue: _selectedAddressIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedAddressIndex = value!;
                      });
                    },
                  ),
                  title: Text(address['name']),
                  subtitle: Text('${address['houseNo']}, ${address['colony']}, ${address['city']}, ${address['state']}, ${address['pincode']}'),
                  trailing: Text(address['phone']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _selectedAddressIndex == -1
                  ? null
                  : () {
                // Navigate to the RazorPayPage
                Get.to(() => RazorPayPage());

                // Handle the "deliver here" action if needed
                // Example: processSelectedAddress(_selectedAddressIndex);
              },

              child: Text("DELIVER HERE"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Some border radius
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
