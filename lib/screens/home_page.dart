import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/widgets/book_on_home_widget.dart';
import 'package:simple_app/models/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // Future getDocID() async {
  //   await FirebaseFirestore.instance
  //       .collection('books')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((document) {
  //             docsID.add(document.reference.id);
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('BookStore'),
      //   centerTitle: true,
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: SafeArea(
        child: Column(
          children: [
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
                    return BookDetainOnHome(
                      book: bookList[index],
                    );
                  }),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
