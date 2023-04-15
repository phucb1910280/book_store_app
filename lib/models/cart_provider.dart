import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cartCount = 0;
  int _cartTotal = 0;

  getCartCount() => _cartCount;
  getCartTotal() => _cartTotal;

  Future<String> addOrderCollection(String hinhThucThanhToan) async {
    if (FirebaseAuth.instance.currentUser != null) {
      var curDay = DateTime.now();
      String id =
          '${curDay.day}${curDay.month}${curDay.year}${curDay.hour}${curDay.minute}';
      String orderDay =
          '${curDay.hour}:${curDay.minute}, ${curDay.day}/${curDay.month}/${curDay.year}';
      String receiveDay = '${curDay.day + 2}/${curDay.month}/${curDay.year}';
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
      if (querySnapshot.docs.isNotEmpty) {
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
          'tongHoaDon': getCartTotal(),
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
      return Future.value(id);
    } else {
      return '';
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
    if (FirebaseAuth.instance.currentUser != null) {
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

  void updateCartCount() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        _cartCount = 0;
        var t = 0;
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          t += querySnapshot.docs[i]['soLuong'] as int;
        }
        _cartCount = t;
        notifyListeners();
      } else {
        _cartCount = 0;
        notifyListeners();
      }
    }
  }

  void updateCartTotal() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      var cartCollectionRef = FirebaseFirestore.instance
          .collection('userCartItems')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartItems');
      QuerySnapshot querySnapshot = await cartCollectionRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        _cartTotal = 0;
        int sum = 0;
        int sl;
        int giaban;
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          sl = querySnapshot.docs[i]['soLuong'];
          giaban = querySnapshot.docs[i]['giaBan'];
          sum += sl * giaban;
        }
        _cartTotal = sum;
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
