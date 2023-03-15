import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/screens/cart_screen_controller.dart';
import 'package:simple_app/shared/book_detail.dart';
import 'package:simple_app/shared/list_book_widget.dart';
import 'package:simple_app/models/book.dart';

import '../models/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> bookList = [];

  @override
  void initState() {
    fetchRecord();
    super.initState();
  }

  void fetchRecord() async {
    var records = await FirebaseFirestore.instance.collection('books').get();
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

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: const Text(
          'Tất cả sách',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // helper.getLogStatus()
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
          searchForm(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 2.3 / 3,
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

  Widget searchForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.search,
              color: Colors.black38,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                cursorColor: Colors.black12,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
