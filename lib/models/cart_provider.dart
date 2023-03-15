import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int _cartCount = 0;
  int _cartTotal = 0;

  getCartCount() => _cartCount;
  getCartTotal() => _cartTotal;

  // var userCollectionRef = FirebaseFirestore.instance
  //     .collection('user')
  //     .doc(FirebaseAuth.instance.currentUser!.email);
  // var cartCollectionRef = FirebaseFirestore.instance
  //     .collection('userCartItems')
  //     .doc(FirebaseAuth.instance.currentUser!.email)
  //     .collection('cartItems');
  // var orderCollectionRef = FirebaseFirestore.instance
  //     .collection('userOrder')
  //     .doc(FirebaseAuth.instance.currentUser!.email)
  //     .collection('orderItems');

  void getCartData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        _cartCount = 0;
        _cartTotal = 0;
        int sl = 0;
        int giaban = 0;
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          _cartCount += querySnapshot.docs[i]['soLuong'] as int;
          notifyListeners();
          sl = querySnapshot.docs[i]['soLuong'];
          giaban = querySnapshot.docs[i]['giaBan'];
          _cartTotal += sl * giaban;
        }
        notifyListeners();
      } else {
        _cartCount = 0;
        notifyListeners();
      }
    }
  }

  void addOrderCollection(String hinhThucThanhToan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('logStt')!) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        var curDay = DateTime.now();
        String id =
            '${curDay.day}${curDay.month}${curDay.year}${curDay.hour + 7}${curDay.minute}';
        String orderDay =
            '${curDay.hour + 7}:${curDay.minute}, ${curDay.day}/${curDay.month}/${curDay.year}';
        String receiveDay = '${curDay.day + 2}/${curDay.month}/${curDay.year}';
        var userCollectionRef = FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.email);
        var documentSnapshot = await userCollectionRef.get();
        var orderCollectionRef = FirebaseFirestore.instance
            .collection('userOrder')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('orderItems');
        var document = await orderCollectionRef.add({
          'id': id,
          'ngayDat': orderDay,
          'ngayGiaoDuKien': receiveDay,
          //
          'fullName': documentSnapshot['fullName'],
          'phoneNumber': documentSnapshot['phoneNumber'],
          'address': documentSnapshot['address'],
          //
          'tongHoaDon': getCartTotal().toString(),
          'hinhThucThanhToan': hinhThucThanhToan,
          //
          'trangThaiDonHang': 'Đã tiếp nhận',
        });
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          addOrderSubCollection(
              document.id,
              querySnapshot.docs[i]['id'],
              querySnapshot.docs[i]['biaSach'],
              querySnapshot.docs[i]['tenSach'],
              querySnapshot.docs[i]['tacGia'],
              querySnapshot.docs[i]['giaBan'],
              querySnapshot.docs[i]['soTrang'],
              querySnapshot.docs[i]['soLuong'],
              querySnapshot.docs[i]['loaiBia'],
              querySnapshot.docs[i]['theLoai'],
              querySnapshot.docs[i]['thuocTheLoai'],
              querySnapshot.docs[i]['moTa']);
        }
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          clearCart(querySnapshot.docs[i].id);
        }
        updateCartCount();
        updateCartTotal();
      }
    }
  }

  void addOrderSubCollection(
    String docId,
    String id,
    String biaSach,
    String tenSach,
    String tacGia,
    int giaBan,
    int soTrang,
    int soLuong,
    String loaiBia,
    String theLoai,
    String thuocTheLoai,
    String moTa,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('logStt')!) {
      var orderCollectionRef = FirebaseFirestore.instance
          .collection('userOrder')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('orderItems');
      var subCollection = orderCollectionRef;
      subCollection.doc(docId).collection('cacSanpham').add({
        'id': id,
        'biaSach': biaSach,
        'tenSach': tenSach,
        'tacGia': tacGia,
        'giaBan': giaBan,
        'soTrang': soTrang,
        'soLuong': soLuong,
        'loaiBia': loaiBia,
        'theLoai': theLoai,
        'thuocTheLoai': thuocTheLoai,
        'moTa': moTa,
      });
    }
  }

  Future<void> updateCartCount() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
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
  }

  Future<void> updateCartTotal() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
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
        notifyListeners();
      }
    }
  }

  Future clearCart(String docID) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
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
  }

  void resetCartCount() {
    _cartCount = 0;
    _cartTotal = 0;
    notifyListeners();
  }
}
