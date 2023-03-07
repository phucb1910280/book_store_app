import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cartCount = 0;
  int _cartTotal = 0;

  getCartCount() => _cartCount;
  getCartTotal() => _cartTotal;

  CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('userCartItems')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('cartItems');

  void getCartData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      _cartCount = 0;
      _cartTotal = 0;
      int sl = 0;
      int giaban = 0;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        _cartCount += querySnapshot.docs[i]['soLuong'] as int;
        sl = querySnapshot.docs[i]['soLuong'];
        giaban = querySnapshot.docs[i]['giaBan'];
        _cartTotal += sl * giaban;
      }
      notifyListeners();
    } else {
      _cartCount = 0;
    }
  }

  Future<void> updateCartCount() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      _cartCount = 0;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        _cartCount += querySnapshot.docs[i]['soLuong'] as int;
      }
      notifyListeners();
    } else {
      _cartCount = 0;
      notifyListeners();
    }
  }

  Future<void> updateCartTotal() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      _cartTotal = 0;
      int sl;
      int giaban;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        sl = querySnapshot.docs[i]['soLuong'];
        giaban = querySnapshot.docs[i]['giaBan'];
        _cartTotal += sl * giaban;
      }
      notifyListeners();
    } else {
      _cartTotal = 0;
    }
  }
}
