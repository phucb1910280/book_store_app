// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/pages/home_page.dart';

import '../../models/cart_provider.dart';
import '../../models/user.dart';

class CartConfirm extends StatefulWidget {
  const CartConfirm({
    Key? key,
  }) : super(key: key);

  @override
  State<CartConfirm> createState() => _CartConfirmState();
}

class _CartConfirmState extends State<CartConfirm> {
  @override
  void initState() {
    getDocData();
    super.initState();
  }

  var currentUser =
      CurrentUser(fullName: '', address: '', email: '', phoneNumber: '');
  Future<void> getDocData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var collection = FirebaseFirestore.instance.collection('user');
    var docSnapshot = await collection.doc(user!.email).get();
    try {
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var currentUserName = data?['fullName'];
        var currentUserAddress = data?['address'];
        var currentUserEmail = data?['email'];
        var currentUserPhoneNumber = data?['phoneNumber'];
        var thisUser = CurrentUser(
            fullName: currentUserName,
            address: currentUserAddress,
            email: currentUserEmail,
            phoneNumber: currentUserPhoneNumber);
        setState(() {
          currentUser = thisUser;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool checkPaymentInfo() {
    if (payOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng chọn hình thức thanh toán!'),
          backgroundColor: (Colors.cyan[800]),
          duration: const Duration(seconds: 1),
        ),
      );
      return false;
    }
    if (currentUser.phoneNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng cập nhật số điện thoại'),
          backgroundColor: (Colors.cyan[800]),
          duration: const Duration(seconds: 1),
        ),
      );
      return false;
    }
    if (currentUser.address == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng cập nhật địa chỉ'),
          backgroundColor: (Colors.cyan[800]),
          duration: const Duration(seconds: 1),
        ),
      );
      return false;
    }
    return true;
  }

  Widget customeText(String content, bool isBold,
      {bool? isItalic, double? size, bool? isCyanColor}) {
    return Text(
      content,
      style: TextStyle(
        color: isCyanColor == true ? Colors.cyan[800] : Colors.black,
        // ignore: prefer_if_null_operators
        fontSize: size != null ? size : 22,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic == true ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }

  String? payOption;
  Widget paymentOption(String content) {
    return ListTile(
      title: Text(
        content,
        style: const TextStyle(fontSize: 22),
      ),
      leading: Radio(
        value: content,
        groupValue: payOption,
        activeColor: Colors.cyan[800],
        onChanged: (value) {
          setState(() {
            payOption = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCounter = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác nhận đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 5),
              child: customeText('Thông tin người nhận', false,
                  size: 29, isCyanColor: true),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  customeText('Khách hàng:  ', false),
                  customeText(currentUser.fullName.toString(), true,
                      isItalic: false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  customeText('Số điện thoại:  ', false),
                  customeText(currentUser.phoneNumber.toString(), true,
                      isItalic: false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText('Địa chỉ:  ', false),
                  Flexible(
                    child: customeText(currentUser.address.toString(), true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 5),
              child: customeText('Hình thức thanh toán:', false,
                  size: 29, isCyanColor: true),
            ),
            paymentOption('Thanh toán khi nhận hàng'),
            paymentOption('Thanh toán qua thẻ ATM'),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Text(
                    'Phí ship: ',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    '0 VND',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  const Text(
                    'Tổng cộng: ',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '${cartCounter.getCartTotal().toString()} VND',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (checkPaymentInfo()) {
                  cartCounter.addOrderCollection(payOption!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.cyan[800]),
                child: Row(
                  children: const [
                    Expanded(child: SizedBox()),
                    Text(
                      'Đặt hàng',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(child: SizedBox()),
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
