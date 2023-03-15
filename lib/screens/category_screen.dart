import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/shared/book_of_category.dart';

import '../models/cart_provider.dart';
import 'cart_screen_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Widget customeText(String categoryName) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        categoryName,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.teal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh mục sách',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
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
            textColor: Colors.teal,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.teal,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'vanhoc',
                                      tenTheLoaiSach: 'Sách Văn học',
                                    )));
                      },
                      child: customeText('Sách Văn học')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'kinhte',
                                      tenTheLoaiSach: 'Sách Kinh tế',
                                    )));
                      },
                      child: customeText('Sách Kinh tế')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'thamkhao',
                                      tenTheLoaiSach: 'Sách Tham khảo',
                                    )));
                      },
                      child: customeText('Sách Tham khảo')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'kynang',
                                      tenTheLoaiSach: 'Sách Kỹ năng sống',
                                    )));
                      },
                      child: customeText('Sách Kỹ năng sống')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'nuoicon',
                                      tenTheLoaiSach: 'Sách Nuôi dạy con',
                                    )));
                      },
                      child: customeText('Sách Nuôi dạy con')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'thieunhi',
                                      tenTheLoaiSach: 'Sách Thiếu nhi',
                                    )));
                      },
                      child: customeText('Sách Thiếu nhi')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'tieusu',
                                      tenTheLoaiSach: 'Sách Tiểu sử',
                                    )));
                      },
                      child: customeText('Sách Tiểu sử')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
