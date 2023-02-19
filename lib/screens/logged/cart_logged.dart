// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/models/book.dart';
import 'package:simple_app/widgets/book_detail_widget.dart';

class CartLogged extends StatefulWidget {
  const CartLogged({super.key});

  @override
  State<CartLogged> createState() => _CartLoggedState();
}

class _CartLoggedState extends State<CartLogged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng của tôi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userCartItems')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('cartItems')
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
              return const Center(child: Text('Somthing Wrong!'));
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
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems')
          .doc(docID)
          .delete();
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 0, right: 5, bottom: 5),
      child: SizedBox(
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
                          tenSach: documentSnapshot['tenSach'],
                          biaSach: documentSnapshot['biaSach'],
                          tacGia: documentSnapshot['tacGia'],
                          giaBan: documentSnapshot['giaBan'].toString(),
                          soTrang: documentSnapshot['soTrang'].toString(),
                          loaiBia: documentSnapshot['loaiBia'],
                          theLoai: documentSnapshot['theLoai'],
                          moTa: documentSnapshot['moTa'],
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailWidget(book: currentBook)));
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
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            documentSnapshot['tenSach'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${documentSnapshot['giaBan']}₫',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove, color: Colors.black),
                          color: Colors.deepPurple.shade100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(documentSnapshot['soLuong'].toString()),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: Colors.black),
                          color: Colors.deepPurple.shade100,
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        IconButton(
                          onPressed: () async {
                            await deleteData();
                          },
                          icon: const Icon(Icons.delete, color: Colors.black),
                        ),
                      ],
                    ),
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
