import 'package:flutter/material.dart';

class FavoriteLogged extends StatelessWidget {
  const FavoriteLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        title: const Text('Danh sách yêu thích'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Danh sách rỗng'),
          ],
        ),
      ),
    );
  }
}
