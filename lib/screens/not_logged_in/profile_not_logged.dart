import 'package:flutter/material.dart';
import 'package:simple_app/pages/auth_page.dart';

class ProfileNotLoggedIn extends StatelessWidget {
  const ProfileNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/readingBooks.png',
              height: 250,
              // color: Colors.grey.withOpacity(.5),
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
    );
  }
}
