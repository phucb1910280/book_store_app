// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/models/book.dart';
import 'package:simple_app/screens/logged/cart_confirm.dart';
import 'package:simple_app/shared/book_detail.dart';

import '../../models/cart_provider.dart';

class CartLogged extends StatefulWidget {
  const CartLogged({super.key});

  @override
  State<CartLogged> createState() => _CartLoggedState();
}

class _CartLoggedState extends State<CartLogged> {
  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Giỏ hàng (${cartCounter.getCartCount()})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
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
              return const Center(child: Text('Đang tải'));
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            Row(
              children: [
                const Expanded(child: SizedBox()),
                const Text(
                  'Tổng: ',
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${cartCounter.getCartTotal()} VND',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartConfirm()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.cyan[800],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Xác nhận đơn hàng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    final cartCounter = Provider.of<CartProvider>(context);
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
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailWidget(book: currentBook)));
                      },
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
                  ),
                  Row(
                    children: [
                      Text(
                        '${documentSnapshot['giaBan']}₫',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.cyan[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            // int t = documentSnapshot['soLuong'] - 1;
                            if (documentSnapshot['soLuong'] > 1) {
                              var document = FirebaseFirestore.instance
                                  .collection('userCartItems')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('cartItems')
                                  .doc(docID);
                              document.update({
                                'soLuong': documentSnapshot['soLuong'] - 1,
                              });
                              cartCounter.updateCartCount();
                              cartCounter.updateCartTotal();
                            } else {
                              await deleteData();
                              cartCounter.updateCartCount();
                              cartCounter.updateCartTotal();
                            }
                          },
                          icon: const Icon(Icons.remove, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                documentSnapshot['soLuong'].toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () {
                            int t = documentSnapshot['soLuong'] + 1;
                            var document = FirebaseFirestore.instance
                                .collection('userCartItems')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('cartItems')
                                .doc(docID);
                            document.update({
                              'soLuong': t,
                            });
                            cartCounter.updateCartCount();
                            cartCounter.updateCartTotal();
                          },
                          icon: const Icon(Icons.add, color: Colors.black),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        IconButton(
                          onPressed: () async {
                            await deleteData();
                            cartCounter.updateCartCount();
                            cartCounter.updateCartTotal();
                          },
                          icon: Icon(Icons.cancel, color: Colors.red[700]),
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
