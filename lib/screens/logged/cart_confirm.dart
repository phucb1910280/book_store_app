// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/pages/home_page.dart';
import 'package:simple_app/screens/logged/order_success.dart';

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

  bool checkPaymentInfo(String phoneNumber, String address) {
    if (phoneNumber.isEmpty || address.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text(
                'Vui lòng cập nhật số điện thoại/ địa chỉ giao hàng.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => HomePage(outFromIndex: 3)),
                      (route) => false,
                    );
                  },
                  child: const Text('Cập nhật thông tin')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  Future createNotification({String? title, String? content}) async {
    var currentDay = DateTime.now();
    String notificationID =
        '${currentDay.day}${currentDay.month}${currentDay.year}${currentDay.hour}${currentDay.minute}';
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('userNotification');
    return collectionRef
        .doc(currentUser!.email)
        .collection('notifications')
        .doc(notificationID)
        .set({
      'id': notificationID,
      'title': title,
      'content': content,
      'isRead': 'unread',
      'dateTime':
          '${currentDay.hour}:${currentDay.minute}, ${currentDay.day}/${currentDay.month}',
      'isWelcomeNotification': 'no',
    });
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

  int choice = 1;
  String payOption = 'Thanh toán khi nhận hàng';
  Widget paymentOption(String content, int orderChoice) {
    return ListTile(
      title: Text(
        content,
        style: const TextStyle(fontSize: 22),
      ),
      leading: Radio(
        value: orderChoice,
        groupValue: choice,
        activeColor: Colors.cyan[800],
        onChanged: (value) {
          setState(() {
            choice = orderChoice;
            payOption = content;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: customeText('Thông tin người nhận', false,
                size: 29, isCyanColor: true),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              children: [
                customeText('Khách hàng:  ', false),
                customeText(currentUser.fullName.toString(), true,
                    isItalic: false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              children: [
                customeText('Số điện thoại:  ', false),
                customeText(currentUser.phoneNumber.toString(), true,
                    isItalic: false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customeText('Địa chỉ:  ', false),
                Flexible(
                  flex: 1,
                  child: customeText(currentUser.address.toString(), true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: customeText('Hình thức thanh toán:', false,
                size: 29, isCyanColor: true),
          ),
          paymentOption('Thanh toán khi nhận hàng', 1),
          paymentOption('Thanh toán qua thẻ ATM', 2),
          // const Expanded(child: SizedBox()),
        ],
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          if (checkPaymentInfo(currentUser.phoneNumber.toString(),
              currentUser.address.toString())) {
            showModalBottomSheet(
                context: context,
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 20,
                          width: 50,
                          child: Divider(
                            color: Colors.grey,
                            thickness: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              // SizedBox(
                              //   width: 20,
                              // ),
                              Text(
                                'Phí vận chuyển: ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                '0 VND',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal),
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
                                'Tổng đơn hàng: ',
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
                        // const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyan[50],
                                      foregroundColor: Colors.cyan[800]),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Trở lại',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyan[800],
                                      foregroundColor: Colors.white),
                                  onPressed: () async {
                                    // cartCounter.addOrderCollection(payOption);
                                    String s = await cartCounter
                                        .addOrderCollection(payOption);
                                    createNotification(
                                        title: 'Đặt hàng thành công',
                                        content: 'Mã đơn hàng: $s');
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) =>
                                              const OrderSuccess()),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    'Đặt hàng',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.cyan[800]),
          child: Row(
            children: const [
              Expanded(child: SizedBox()),
              Text(
                'Xác nhận',
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
    );
  }
}
