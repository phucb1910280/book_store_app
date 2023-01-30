import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/widgets/book_on_home_widget.dart';
import 'package:simple_app/models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
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
            // id: books['id'],
            tenSach: books['tenSach'],
            biaSach: books['biaSach'],
            tacGia: books['tacGia'],
            giaBan: books['giaBan'],
            soTrang: books['soTrang'],
            loaiBia: books['loaiBia'],
            theLoai: books['theLoai'],
            moTa: books['moTa'],
            yeuThich: books['yeuThich']))
        .toList();
    setState(() {
      bookList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/appLogo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // CustomeAppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: bookList.length,
                itemBuilder: ((context, index) {
                  return BookDetailOnHome(
                    book: bookList[index],
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
