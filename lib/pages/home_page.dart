import 'package:flutter/material.dart';
import 'package:simple_app/screens/cart_screen.dart';
import 'package:simple_app/screens/favorite_screen.dart';
import 'package:simple_app/screens/home_screen.dart';

import '../screens/profile_sceen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  static const List<Widget> page = <Widget>[
    HomeScreen(),
    // CartScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedItemColor: Colors.deepPurple,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/home.png',
              height: 20,
              color: Colors.deepPurple,
            ),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/cart.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/cart.png',
              height: 20,
              color: Colors.deepPurple,
            ),
            label: "Giỏ hàng",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/nofav.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/nofav.png',
              height: 20,
              color: Colors.deepPurple,
            ),
            label: "Yêu thích",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/account.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/account.png',
              height: 20,
              color: Colors.deepPurple,
            ),
            label: "Tài khoản",
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
