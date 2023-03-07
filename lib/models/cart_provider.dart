import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class CartItem {
//   String? id;
//   String tenSach;
//   String biaSach;
//   String tacGia;
//   String giaBan;
//   String soTrang;
//   String loaiBia;
//   String theLoai;
//   String thuocTheLoai;
//   String moTa;
//   int soLuong;
//
//   CartItem({
//     required this.id,
//     required this.tenSach,
//     required this.biaSach,
//     required this.tacGia,
//     required this.giaBan,
//     required this.soTrang,
//     required this.loaiBia,
//     required this.theLoai,
//     required this.thuocTheLoai,
//     required this.moTa,
//     required this.soLuong,
//   });
// }

class CartProvider with ChangeNotifier {
  // List<CartItem> bookCart = [];
  int _cartCount = 0;
  int _cartTotal = 0;

  getCartCount() => _cartCount;
  getCartTotal() => _cartTotal;

  CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('userCartItems')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('cartItems');

  Future<void> updateCartCount() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      _cartCount = 0;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        _cartCount += querySnapshot.docs[i]['soLuong'] as int;
        notifyListeners();
      }
    } else {
      _cartCount = 0;
      notifyListeners();
    }
  }

  Future<void> updateCartTotal() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    _cartTotal = 0;
    int sl;
    int giaban;
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      sl = querySnapshot.docs[i]['soLuong'];
      giaban = querySnapshot.docs[i]['giaBan'];
      _cartTotal += sl * giaban;
      notifyListeners();
    }
  }
}
