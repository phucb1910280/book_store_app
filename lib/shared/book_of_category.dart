import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_app/models/book.dart';
import 'package:simple_app/shared/book_detail.dart';
import 'package:simple_app/shared/list_book_widget.dart';

import '../models/cart_provider.dart';
import '../screens/cart_screen_controller.dart';

class BookOfCategory extends StatefulWidget {
  final String tenTheLoaiSach;
  final String theLoaiSach;
  const BookOfCategory({
    Key? key,
    required this.tenTheLoaiSach,
    required this.theLoaiSach,
  }) : super(key: key);

  @override
  State<BookOfCategory> createState() => _BookOfCategoryState();
}

class _BookOfCategoryState extends State<BookOfCategory> {
  List<Book> bookList = [];
  @override
  void initState() {
    fetchRecord();
    super.initState();
  }

  void fetchRecord() async {
    var records = await FirebaseFirestore.instance
        .collection('books')
        .where('theLoai', isEqualTo: widget.theLoaiSach)
        .get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((books) => Book(
              id: books['id'],
              tenSach: books['tenSach'],
              biaSach: books['biaSach'],
              tacGia: books['tacGia'],
              giaBan: books['giaBan'],
              soTrang: books['soTrang'],
              loaiBia: books['loaiBia'],
              theLoai: books['theLoai'],
              thuocTheLoai: books['thuocTheLoai'],
              moTa: books['moTa'],
            ))
        .toList();
    setState(() {
      bookList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.tenTheLoaiSach,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: bookList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailWidget(book: bookList[index])));
                    },
                    child: ListOfBookWidget(
                      book: bookList[index],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
