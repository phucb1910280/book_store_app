import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'edit_profile.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
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
            address: currentUserAddress ?? 'Chưa cung cấp',
            email: currentUserEmail,
            phoneNumber: currentUserPhoneNumber ?? 'Chưa cung cấp');
        setState(() {
          currentUser = thisUser;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget customeTextStye(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 22,
        color: Colors.cyan[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Thông tin của tôi'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, currentUser);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Họ tên:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Flexible(
                    child: customeTextStye(
                      currentUser.fullName.toString(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 333,
              child: Divider(color: Colors.black26),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số điện thoại:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Flexible(
                      child:
                          customeTextStye(currentUser.phoneNumber.toString())),
                ],
              ),
            ),
            const SizedBox(
              width: 333,
              child: Divider(color: Colors.black26),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Flexible(
                      child: customeTextStye(currentUser.email.toString())),
                ],
              ),
            ),
            const SizedBox(
              width: 333,
              child: Divider(color: Colors.black26),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Địa chỉ:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                      child: customeTextStye(currentUser.address.toString())),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                // backgroundColor: Colors.white,
              ),
              onPressed: () async {
                final updatedUser = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfile(currentUser: currentUser)));
                setState(() {
                  currentUser = updatedUser;
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.cyan[800]!,
                    width: 2,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Icon(
                      Icons.edit,
                      color: Colors.cyan[800],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Chỉnh sửa thông tin',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.cyan[800],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
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
