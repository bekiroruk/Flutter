import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/favorites_page.dart';
import '../screens/cart_page.dart';
import '../utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavBar({required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoriler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Sepet',
        ),
      ],
    );
  }
}
