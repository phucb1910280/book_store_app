import 'package:flutter/material.dart';

import '../../pages/auth_page.dart';

class CartNotLogged extends StatelessWidget {
  const CartNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/emptyCart.png',
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
                    'Giỏ hàng rỗng',
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
