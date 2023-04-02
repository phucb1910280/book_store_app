import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/pages/auth_page.dart';
import '../models/book.dart';
import '../models/cart_provider.dart';
import '../pagesRoute/cart_screen_controller.dart';
import '../pagesRoute/pape_route_transition.dart';
import 'list_book_widget.dart';

class BookDetailWidget extends StatefulWidget {
  final Book? book;
  const BookDetailWidget({super.key, required this.book});

  @override
  State<BookDetailWidget> createState() => _BookDetailWidgetState();
}

class _BookDetailWidgetState extends State<BookDetailWidget> {
  @override
  void initState() {
    super.initState();
    checkExistOnFav(widget.book!.id.toString());
    checkExistOnCart(widget.book!.id.toString());
    fetchRecord();
  }

  List<Book> suggestBook = [];

  void fetchRecord() async {
    var records = await FirebaseFirestore.instance
        .collection('books')
        .where('theLoai', isEqualTo: widget.book!.theLoai.toString())
        // .where('id', isNotEqualTo: widget.book!.id.toString())
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
      suggestBook = list;
      suggestBook.removeWhere((element) => element.id == widget.book!.id);
    });
  }

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
      'thuocTheLoai': widget.book!.thuocTheLoai,
      'moTa': widget.book!.moTa,
      'soLuong': soLuongSp,
    }).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Đã thêm vào Giỏ hàng',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: (Colors.cyan[800]),
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
      'thuocTheLoai': widget.book!.thuocTheLoai,
      'theLoai': widget.book!.theLoai,
      'moTa': widget.book!.moTa,
    });
  }

  bool exitsOnFavCollection = false;
  bool exitsOnCartCollection = false;
  void checkExistOnFav(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('userFavItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('favItems')
          .doc(widget.book!.id)
          .get()
          .then((value) {
        setState(() {
          exitsOnFavCollection = value.exists;
        });
      });
    } catch (e) {
      setState(() {
        exitsOnFavCollection = false;
      });
    }
  }

  void checkExistOnCart(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems')
          .doc(widget.book!.id)
          .get()
          .then((value) {
        setState(() {
          exitsOnCartCollection = value.exists;
        });
      });
    } catch (e) {
      setState(() {
        exitsOnCartCollection = false;
      });
    }
  }

  Future removeFav() async {
    try {
      await FirebaseFirestore.instance
          .collection('userFavItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('favItems')
          .doc(widget.book!.id)
          .delete();
    } catch (e) {
      return false;
    }
  }

  List<Book> favBookList = [];
  int soLuong = 1;

  void increaseSL() {
    setState(() {
      if (soLuong < 10) {
        soLuong++;
      }
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
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
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
                        // color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 25,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        // color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Badge(
                        label: FirebaseAuth.instance.currentUser != null
                            ? Text(cartCounter.getCartCount().toString())
                            : const Text('0'),
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        largeSize: 22,
                        smallSize: 20,
                        alignment: const AlignmentDirectional(31, 8),
                        backgroundColor: Colors.white,
                        textColor: Colors.cyan[800],
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  SlideUpRoute(page: const CartScreen()));
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.cyan[800],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    NumberFormat.simpleCurrency(
                            locale: 'vi-VN', decimalDigits: 0)
                        .format(widget.book!.giaBan),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.cyan[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[800],
                    ),
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        if (!exitsOnFavCollection) {
                          await addToFav(soLuong);
                          setState(() {
                            exitsOnFavCollection = true;
                          });
                        } else {
                          removeFav();
                          setState(() {
                            exitsOnFavCollection = false;
                          });
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              content: const Text(
                                'Vui lòng đăng nhập để thêm danh sách yêu thích!',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) =>
                                                const AuthPage()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      exitsOnFavCollection
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red[700],
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
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
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      child: Row(
                        children: [
                          const Text(
                            'Tác giả: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.book!.tacGia,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan[800],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      child: Row(
                        children: [
                          const Text(
                            'Số trang: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            widget.book!.soTrang.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[800],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      child: Row(
                        children: [
                          const Text(
                            'Loại bìa: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            widget.book!.loaiBia,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[800],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      child: Row(
                        children: [
                          const Text(
                            'Thể loại: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            widget.book!.thuocTheLoai,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[800],
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    'Sách cùng thể loại',
                    style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 25,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestBook.isEmpty ? 0 : suggestBook.length,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300,
                    width: 150,
                    child: GestureDetector(
                        onTap: () {},
                        child: ListOfBookWidget(book: suggestBook[index])),
                  );
                },
              ),
            )
          ],
        ),
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
                width: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      soLuong.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[800],
                    ),
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        if (!exitsOnCartCollection) {
                          await addToCart(soLuong);
                          setState(() {
                            exitsOnCartCollection = true;
                          });
                          cartCounter.updateCartCount();
                          cartCounter.updateCartTotal();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                content: const Text(
                                  'Sản phẩm đã tồn tại trong giỏ hàng!',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              content: const Text(
                                'Vui lòng đăng nhập để thêm vào giỏ hàng!',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) =>
                                                const AuthPage()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
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
