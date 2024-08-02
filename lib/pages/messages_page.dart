import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  final String cardTitle;
  final String cardImagePath;
  final double price;

  MessagesPage({
    super.key,
    required this.cardTitle,
    required this.cardImagePath,
    required this.price,
  });

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int quantity = 1;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.price;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      totalPrice = widget.price * quantity;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = widget.price * quantity;
      });
    }
  }

  void _pay() {
    // Implement your pay functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment Successful!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "My Order",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    widget.cardImagePath,
                    height: 100.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 10),

                  Text(
                    widget.cardTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "UPI",
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Radio(
                        value: true,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _pay,
                    child: Text('Pay'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
