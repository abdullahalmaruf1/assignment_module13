import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  // Define quantities and prices for each item
  int pulloverQty = 1;
  int tShirtQty = 1;
  int sportDressQty = 1;

  final int pulloverPrice = 51;
  final int tShirtPrice = 30;
  final int sportDressPrice = 43;

  // Image paths from assets
  final String pulloverImage = 'assets/images/t-shirt1.png';
  final String tShirtImage = 'assets/images/t-shirt2.png';
  final String sportDressImage = 'assets/images/t-shirt3.png';

  // Calculate total amount
  int get totalAmount {
    return (pulloverQty * pulloverPrice) +
        (tShirtQty * tShirtPrice) +
        (sportDressQty * sportDressPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Bag',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pullover item
            buildCartItem('Pullover', 'Black', 'L', pulloverPrice, pulloverQty,
                pulloverImage, (newQty) {
                  setState(() {
                    pulloverQty = newQty;
                  });
                }),
            const SizedBox(height: 10),
            // T-Shirt item
            buildCartItem('T-Shirt', 'Gray', 'L', tShirtPrice, tShirtQty,
                tShirtImage, (newQty) {
                  setState(() {
                    tShirtQty = newQty;
                  });
                }),
            const SizedBox(height: 10),
            // Sport Dress item
            buildCartItem('Sport Dress', 'Black', 'M', sportDressPrice,
                sportDressQty, sportDressImage, (newQty) {
                  setState(() {
                    sportDressQty = newQty;
                  });
                }),
            const Spacer(),
            // Total amount and Checkout button
            // Total amount and Checkout button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total amount:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '\$${totalAmount}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Updated Checkout button
                  SizedBox(
                    width: double.infinity,  // Make button full width
                    height: 50,              // Fixed height for the button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,  // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),  // Rounded edges
                        ),
                      ),
                      onPressed: () {
                        // Show snackbar on pressing Checkout
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Congratulations on your purchase!'),
                          ),
                        );
                      },
                      child: const Text(
                        'CHECK OUT',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,  // Text color
                        ),
                      ),
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

  // Function to build each cart item with card layout
  Widget buildCartItem(String name, String color, String size, int price,
      int quantity, String imageUrl, Function(int) onQuantityChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image for the item
            Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // Three-dot icon without any action
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Color and Size in a row
                  Row(
                    children: [
                      Text(
                        'Color: $color',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Size: $size',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Quantity, price in a row
                  Row(
                    children: [
                      buildQuantityButton(Icons.remove, () {
                        if (quantity > 1) {
                          onQuantityChanged(quantity - 1);
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      buildQuantityButton(Icons.add, () {
                        onQuantityChanged(quantity + 1);
                      }),
                      const Spacer(),
                      Text(
                        '\$${price * quantity}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom rounded button for quantity
  Widget buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
