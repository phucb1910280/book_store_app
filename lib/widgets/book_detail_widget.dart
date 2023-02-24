import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/screens/logged/cart_logged.dart';

import '../models/book.dart';

class BookDetailWidget extends StatefulWidget {
  final Book? book;
  const BookDetailWidget({super.key, required this.book});

  @override
  State<BookDetailWidget> createState() => _BookDetailWidgetState();
}

class _BookDetailWidgetState extends State<BookDetailWidget> {
  Future addToCart(int soLuongSp) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('userCartItems');
    return collectionRef
        .doc(currentUser!.email)
        .collection('cartItems')
        .doc(widget.book!.id)
        .set({
      'id': widget.book!.id,
      'tenSach': widget.book!.tenSach,
      'giaBan': widget.book!.giaBan,
      'biaSach': widget.book!.biaSach,
      'tacGia': widget.book!.tacGia,
      'soTrang': widget.book!.soTrang,
      'loaiBia': widget.book!.loaiBia,
      'theLoai': widget.book!.theLoai,
      'moTa': widget.book!.moTa,
      'soLuong': soLuongSp,
      // ignore: avoid_print
    }).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Đã thêm vào Giỏ hàng'),
          backgroundColor: (Colors.green[600]),
          duration: const Duration(seconds: 1),
        ),
      ),
    );
  }

  Future addToFav(int soLuongSp) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('userFavItems');
    return collectionRef
        .doc(currentUser!.email)
        .collection('favItems')
        .doc(widget.book!.id)
        .set({
      'id': widget.book!.id,
      'tenSach': widget.book!.tenSach,
      'giaBan': widget.book!.giaBan,
      'biaSach': widget.book!.biaSach,
      'tacGia': widget.book!.tacGia,
      'soTrang': widget.book!.soTrang,
      'loaiBia': widget.book!.loaiBia,
      'theLoai': widget.book!.theLoai,
      'moTa': widget.book!.moTa,
    }).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Đã thêm vào Danh sách yêu thích'),
          backgroundColor: (Colors.green[600]),
          duration: const Duration(seconds: 1),
        ),
      ),
    );
  }

  List<Book> favBookList = [];
  int soLuong = 1;

  void increaseSL() {
    setState(() {
      soLuong++;
    });
  }

  void decreaseSL() {
    if (soLuong > 1) {
      setState(() {
        soLuong--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                // left: 20, right: 20,
                top: 10,
                bottom: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.book!.biaSach.toString(),
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CartLogged()));
                            },
                            icon: const Icon(
                              Icons.shopping_cart_sharp,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.book!.tenSach.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.book!.giaBan}₫',
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (FirebaseAuth.instance.currentUser != null) {
                              await addToFav(soLuong);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Vui lòng đăng nhập để tiếp tục!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.teal,
                                duration: Duration(seconds: 1),
                              ));
                            }
                          },
                          child: const Text('Yêu thích')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Thông tin sách',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Tác giả: ${widget.book!.tacGia}\nSố trang: ${widget.book!.soTrang}\nLoại bìa: ${widget.book!.loaiBia}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Mô tả',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            widget.book!.moTa,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                decreaseSL();
              },
              color: Colors.deepPurple.shade100,
              icon: const Icon(Icons.remove, color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(soLuong.toString()),
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                increaseSL();
              },
              color: Colors.deepPurple.shade100,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await addToCart(soLuong);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Vui lòng đăng nhập để tiếp tục!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.teal,
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    child: const Text('Thêm vào giỏ hàng')),
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
