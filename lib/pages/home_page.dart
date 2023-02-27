import 'package:flutter/material.dart';
import 'package:simple_app/screens/cart_screen_controller.dart';
import 'package:simple_app/screens/category_screen.dart';
import 'package:simple_app/screens/favorite_screen_controller.dart';
import 'package:simple_app/screens/home_screen.dart';

import '../screens/profile_sceen_controller.dart';

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
    CategoryScreen(),
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
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Colors.teal,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/home_slt.png',
                color: Colors.teal,
                height: 20,
              ),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/category.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/category_slt.png',
                color: Colors.teal,
                height: 20,
              ),
              label: "Danh mục",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/cart_slt.png',
                color: Colors.teal,
                height: 20,
              ),
              label: "Giỏ hàng",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/fav.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/fav_slt.png',
                color: Colors.teal,
                height: 20,
              ),
              label: "Yêu thích",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/profile.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/profile_slt.png',
                color: Colors.teal,
                height: 20,
              ),
              label: "Tài khoản",
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
