class Order {
  String cardTitle;
  String cardImagePath;
  double price;
  int quantity;

  Order({
    required this.cardTitle,
    required this.cardImagePath,
    required this.price,
    this.quantity = 1,
  });
}