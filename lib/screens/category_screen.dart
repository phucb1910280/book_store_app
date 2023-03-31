import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/shared/book_of_category.dart';

import '../models/cart_provider.dart';
import '../models/notification_provider.dart';
import '../pagesRoute/cart_screen_controller.dart';
import '../pagesRoute/pape_route_transition.dart';
import 'logged/user_notification_screen.dart';

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
        style: TextStyle(
          fontSize: 22,
          color: Colors.cyan[800],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    final notificationCount = Provider.of<NotificationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
                ? Text(notificationCount.getNotificationCount().toString())
                : const Text(''),
            backgroundColor: Colors.white,
            textColor: Colors.pink,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      SlideUpRoute(page: const UserNotificationScreen()));
                },
                icon: notificationCount.getNotificationCount() != 0
                    ? const Icon(
                        Icons.notifications_active,
                        color: Colors.pink,
                      )
                    : const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.pink,
                      )),
          ),
          const SizedBox(
            width: 10,
          ),
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
                      context, SlideUpRoute(page: const CartScreen()));
                },
                icon: cartCounter.getCartCount() != 0
                    ? Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.cyan[800],
                      )
                    : Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.teal[800],
                      )),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlideToLeftRoute(
                                page: const BookOfCategory(
                              theLoaiSach: 'vanhoc',
                              tenTheLoaiSach: 'Sách Văn học',
                            )));
                      },
                      child: customeText('Sách Văn học')),
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
                              theLoaiSach: 'kinhte',
                              tenTheLoaiSach: 'Sách Kinh tế',
                            )));
                      },
                      child: customeText('Sách Kinh tế')),
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
                              theLoaiSach: 'thamkhao',
                              tenTheLoaiSach: 'Sách Tham khảo',
                            )));
                      },
                      child: customeText('Sách Tham khảo')),
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
                              theLoaiSach: 'kynang',
                              tenTheLoaiSach: 'Sách Kỹ năng sống',
                            )));
                      },
                      child: customeText('Sách Kỹ năng sống')),
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
                              theLoaiSach: 'thieunhi',
                              tenTheLoaiSach: 'Sách Thiếu nhi',
                            )));
                      },
                      child: customeText('Sách Thiếu nhi')),
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
                            SlideToLeftRoute(
                                page: const BookOfCategory(
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
