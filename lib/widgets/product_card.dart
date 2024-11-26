import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;
  final VoidCallback onAddToCart;

  ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16)),
                Text('₺$price', style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.orange),
            onPressed: onAddToCart,
          ),
        ],
      ),
    );
  }
}
