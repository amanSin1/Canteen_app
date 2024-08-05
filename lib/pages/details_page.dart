import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String cardTitle;
  final String cardImagePath;
  final double price;

  DetailsPage({
    super.key,
    required this.cardTitle,
    required this.cardImagePath,
    required this.price,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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

  void _add() {
    // Implement your pay functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            widget.cardImagePath,
                            height: 70,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.delete),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cardTitle,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Row(
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
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _add,
                    child: Text('Add to my Order'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
