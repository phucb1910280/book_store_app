import 'package:flutter/material.dart';
import 'package:simple_app/screens/cart_screen.dart';
import 'package:simple_app/screens/favorite_screen.dart';
import 'package:simple_app/screens/home_screen.dart';
import 'package:simple_app/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Widget homeScreen = HomeScreen();
  Widget cartScreen = CartScreen();
  Widget favScreeen = FavoriteScreen();
  Widget profileScreen = ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
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
            label: "Home",
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
            label: "Cart",
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
            label: "Favorite",
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
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return homeScreen;
    } else if (selectedIndex == 1) {
      return cartScreen;
    } else if (selectedIndex == 2) {
      return favScreeen;
    } else {
      return profileScreen;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
