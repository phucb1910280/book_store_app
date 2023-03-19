// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_app/screens/category_screen.dart';
import 'package:simple_app/screens/favorite_screen_controller.dart';
import 'package:simple_app/screens/home_screen.dart';

import '../models/cart_provider.dart';
import '../screens/profile_sceen_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({
    int? outFromIndex,
    super.key,
  }) {
    if (outFromIndex != null) {
      myIndex = outFromIndex;
    } else {
      myIndex = 0;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  late final int myIndex;
}

class HomePageState extends State<HomePage> {
  SharedPreferences? prefs;
  int selectedIndex = 0;
  static const List<Widget> page = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void loadRef() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var cartCounter = Provider.of<CartProvider>(context, listen: false);
      if (FirebaseAuth.instance.currentUser != null) {
        // cartCounter.getCartData();
        cartCounter.updateCartCount();
        cartCounter.updateCartTotal();
      } else {
        cartCounter.resetCartCount();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.myIndex != 0) {
      _onItemTapped(widget.myIndex);
    }
    loadRef();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: selectedIndex,
        children: page,
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          elevation: 8,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Colors.cyan[800],
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/home_slt.png',
                color: Colors.cyan[800],
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
                color: Colors.cyan[800],
                height: 20,
              ),
              label: "Danh mục",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/fav.png',
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/icons/fav_slt.png',
                color: Colors.cyan[800],
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
                color: Colors.cyan[800],
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
