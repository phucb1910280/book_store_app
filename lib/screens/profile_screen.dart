import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    getDocData();
    super.initState();
  }

  CurrentUser? currentUser;
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
        var currentUserCCCD = data?['cccd'];
        var currentUserEmail = data?['email'];
        var currentUserPhoneNumber = data?['phoneNumber'];
        var thisUser = CurrentUser(
            fullName: currentUserName,
            address: currentUserAddress,
            cccd: currentUserCCCD,
            email: currentUserEmail,
            phoneNumber: currentUserPhoneNumber);
        setState(() {
          currentUser = thisUser;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Xin chào,',
                    style: TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    currentUser!.fullName.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Thông tin của tôi',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Cập nhật thông tin',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/myorder.png',
                        width: 25,
                        height: 25,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Đơn hàng của tôi',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.deepPurple.withOpacity(.3),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Về chúng tôi',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Phiên bản: bookstore.2.2.0',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _signOut(),
        label: const Text('Đăng xuất'),
        icon: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
