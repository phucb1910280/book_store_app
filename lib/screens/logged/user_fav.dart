// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/screens/logged/user_notification.dart';

import '../../models/book.dart';
import '../../models/cart_provider.dart';
import '../../models/notification_provider.dart';
import '../../pagesRoute/cart_screen_controller.dart';
import '../../pagesRoute/pape_route_transition.dart';
import '../../shared/book_detail.dart';

class FavoriteLogged extends StatefulWidget {
  const FavoriteLogged({super.key});

  @override
  State<FavoriteLogged> createState() => _FavoriteLoggedState();
}

class _FavoriteLoggedState extends State<FavoriteLogged> {
  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    final notificationCount = Provider.of<NotificationProvider>(context);
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
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userFavItems')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('favItems')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.isEmpty
                    ? 0
                    : snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  String docId = snapshot.data!.docs[index].id;
                  return CustomeListTile(
                    docID: docId,
                    documentSnapshot: documentSnapshot,
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class CustomeListTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String docID;
  const CustomeListTile({
    Key? key,
    required this.documentSnapshot,
    required this.docID,
  }) : super(key: key);

  Future deleteData() async {
    try {
      await FirebaseFirestore.instance
          .collection('userFavItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('favItems')
          .doc(docID)
          .delete();
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        height: 150,
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        var currentBook = Book(
                          id: documentSnapshot['id'],
                          tenSach: documentSnapshot['tenSach'],
                          biaSach: documentSnapshot['biaSach'],
                          tacGia: documentSnapshot['tacGia'],
                          giaBan: documentSnapshot['giaBan'],
                          soTrang: documentSnapshot['soTrang'],
                          loaiBia: documentSnapshot['loaiBia'],
                          theLoai: documentSnapshot['theLoai'],
                          thuocTheLoai: documentSnapshot['thuocTheLoai'],
                          moTa: documentSnapshot['moTa'],
                        );
                        Navigator.push(
                            context,
                            SlideToLeftRoute(
                                page: BookDetailWidget(book: currentBook)));
                      },
                      child: Image.network(
                        documentSnapshot['biaSach'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        var currentBook = Book(
                          id: documentSnapshot['id'],
                          tenSach: documentSnapshot['tenSach'],
                          biaSach: documentSnapshot['biaSach'],
                          tacGia: documentSnapshot['tacGia'],
                          giaBan: documentSnapshot['giaBan'],
                          soTrang: documentSnapshot['soTrang'],
                          loaiBia: documentSnapshot['loaiBia'],
                          theLoai: documentSnapshot['theLoai'],
                          thuocTheLoai: documentSnapshot['thuocTheLoai'],
                          moTa: documentSnapshot['moTa'],
                        );
                        Navigator.push(
                            context,
                            SlideToLeftRoute(
                                page: BookDetailWidget(book: currentBook)));
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              documentSnapshot['tenSach'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(
                                locale: 'vi-VN', decimalDigits: 0)
                            .format(documentSnapshot['giaBan']),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.cyan[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () async {
                          await deleteData();
                        },
                        icon: Image.asset(
                          'assets/icons/unFav.png',
                          color: Colors.red[700],
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
