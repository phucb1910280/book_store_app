import 'package:flutter/material.dart';

import '../../pages/auth_page.dart';
import '../cart_screen_controller.dart';

class FavoriteNotLogged extends StatelessWidget {
  const FavoriteNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách yêu thích',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Badge(
            alignment: const AlignmentDirectional(25, 23),
            label: const Text('3'),
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bạn chưa đăng nhập!'),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthPage()));
                },
                child: const Text('Đăng nhập')),
          ],
        ),
      ),
    );
  }
}
