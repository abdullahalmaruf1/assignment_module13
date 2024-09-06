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
    // Get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          children: [
            // Pullover item
            buildCartItem(
              'Pullover',
              'Black',
              'L',
              pulloverPrice,
              pulloverQty,
              pulloverImage,
                  (newQty) {
                setState(() {
                  pulloverQty = newQty;
                });
              },
              screenWidth,
            ),
            SizedBox(height: screenHeight * 0.01), // Responsive spacing
            // T-Shirt item
            buildCartItem(
              'T-Shirt',
              'Gray',
              'L',
              tShirtPrice,
              tShirtQty,
              tShirtImage,
                  (newQty) {
                setState(() {
                  tShirtQty = newQty;
                });
              },
              screenWidth,
            ),
            SizedBox(height: screenHeight * 0.01), // Responsive spacing
            // Sport Dress item
            buildCartItem(
              'Sport Dress',
              'Black',
              'M',
              sportDressPrice,
              sportDressQty,
              sportDressImage,
                  (newQty) {
                setState(() {
                  sportDressQty = newQty;
                });
              },
              screenWidth,
            ),
            const Spacer(),
            // Total amount and Checkout button
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Responsive padding
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount:',
                        style: TextStyle(fontSize: screenWidth * 0.045), // Responsive font size
                      ),
                      Text(
                        '\$$totalAmount',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02), // Responsive spacing
                  // Responsive Checkout button
                  SizedBox(
                    width: double.infinity, // Full width
                    height: screenHeight * 0.07, // Responsive height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Rounded edges
                        ),
                      ),
                      onPressed: () {
                        // Show snack bar on pressing Checkout
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Congratulations on your purchase!'),
                          ),
                        );
                      },
                      child: Text(
                        'CHECK OUT',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Responsive font size
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to build each cart item with card layout
  Widget buildCartItem(String name, String color, String size, int price,
      int quantity, String imageUrl, Function(int) onQuantityChanged, double screenWidth) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image for the item
            Image.asset(
              imageUrl,
              width: screenWidth * 0.2, // Responsive image size
              height: screenWidth * 0.2,
              fit: BoxFit.cover,
            ),
            SizedBox(width: screenWidth * 0.04), // Responsive spacing
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
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Three-dot icon without any action
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.01), // Responsive spacing
                  // Color and Size in a row
                  Row(
                    children: [
                      Text(
                        'Color: $color',
                        style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[700]),
                      ),
                      SizedBox(width: screenWidth * 0.02), // Responsive spacing
                      Text(
                        'Size: $size',
                        style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.03), // Responsive spacing
                  // Quantity, price in a row
                  Row(
                    children: [
                      buildQuantityButton(Icons.remove, () {
                        if (quantity > 1) {
                          onQuantityChanged(quantity - 1);
                        }
                      }),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // Responsive spacing
                        child: Text(
                          '$quantity',
                          style: TextStyle(fontSize: screenWidth * 0.045), // Responsive font size
                        ),
                      ),
                      buildQuantityButton(Icons.add, () {
                        onQuantityChanged(quantity + 1);
                      }),
                      const Spacer(),
                      Text(
                        '\$${price * quantity}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
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
