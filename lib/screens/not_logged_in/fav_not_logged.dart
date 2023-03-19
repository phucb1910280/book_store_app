import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_provider.dart';
import '../../pages/auth_page.dart';
import '../cart_screen_controller.dart';

class FavoriteNotLogged extends StatelessWidget {
  const FavoriteNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
            textStyle: const TextStyle(
              fontSize: 20,
            ),
            largeSize: 22,
            smallSize: 20,
            alignment: const AlignmentDirectional(35, 13),
            label: FirebaseAuth.instance.currentUser != null
                ? Text(cartCounter.getCartCount().toString())
                : const Text(''),
            backgroundColor: Colors.white,
            textColor: Colors.cyan[800],
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.cyan[800],
                )),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/emptyFav.png',
                height: 150,
                color: Colors.grey.withOpacity(.5),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Danh sách trống',
                    style: TextStyle(
                        fontSize: 25, color: Colors.grey.withOpacity(.5)),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
                width: 150,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[800],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()));
                  },
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(fontSize: 22),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
