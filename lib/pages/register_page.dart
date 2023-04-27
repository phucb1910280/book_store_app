import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/models/user.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  bool showPW = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  Future addUserDetail(String fullName, String phoneNumber, String email,
      String cccd, String address) async {
    final CollectionReference userRef =
        FirebaseFirestore.instance.collection('user');

    var currentUser = CurrentUser(
        fullName: fullName,
        address: address,
        email: email,
        phoneNumber: phoneNumber);
    Map<String, dynamic> userData = currentUser.toJson();
    await userRef.doc(email).set(userData);
  }

  Future signUp() async {
    try {
      if (checkName() && checkEmail() && checkPw() && checkConfPw()) {
        if (confirmedPW()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
          addUserDetail(
              fullNameController.text, '', emailController.text.trim(), '', '');
          if (FirebaseAuth.instance.currentUser != null) {
            createNotification(
                title: 'Chào mừng đến với αBookStore',
                content:
                    'Hãy cập nhật thông tin để chúng tôi có thể giao hàng đến bạn!');
            if (context.mounted) {}
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false);
          }
        } else {
          showDialog(
            barrierColor: Colors.teal,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                content: const Text('Mật khẩu không trùng khớp'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK')),
                ],
              );
            },
          );
        }
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Có lỗi xảy ra.\nVui lòng thử lại sau.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
    }
  }

  Future createNotification({String? title, String? content}) async {
    var currentDay = DateTime.now();
    String notificationID =
        '${currentDay.day}${currentDay.month}${currentDay.year}${currentDay.hour}${currentDay.minute}';
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('userNotification');
    CollectionReference collectionRef2 =
        FirebaseFirestore.instance.collection('adminNotifications');
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
      'isWelcomeNotification': 'yes',
    }).then((value) => {
              collectionRef2.doc(notificationID).set({
                'id': notificationID,
                'title': 'Vừa có người dùng mới',
                'content': 'Xem thông tin ở phần Quản lý người dùng',
                'isRead': 'unread',
                'dateTime':
                    '${currentDay.hour}:${currentDay.minute}, ${currentDay.day}/${currentDay.month}',
              })
            });
  }

  bool checkName() {
    if (fullNameController.text.isEmpty || fullNameController.text.length < 5) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng điền họ tên'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool checkEmail() {
    if (!emailController.text.contains('@') ||
        emailController.text.length < 10 ||
        emailController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng nhập email hợp lệ!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool checkPw() {
    if (passwordController.text.length < 8 || passwordController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Mật khẩu phải dài hơn 8 ký tự'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool checkConfPw() {
    if (repasswordController.text.length < 8 ||
        repasswordController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng xác nhận mật khẩu'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool confirmedPW() {
    if (repasswordController.text.trim() == passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Chào mừng bạn!',
                      style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: fullNameController,
                    cursorColor: Colors.cyan[800],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      hintText: 'Họ tên',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailController,
                    cursorColor: Colors.cyan[800],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // password textfield
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: passwordController,
                        obscureText: showPW,
                        cursorColor: Colors.cyan[800],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.cyan[800]!,
                            ),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          hintText: 'Mật khẩu',
                          fillColor: Colors.grey[100],
                          filled: true,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 25,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            showPW = !showPW;
                          });
                        },
                        icon: showPW
                            ? Image.asset(
                                'assets/icons/showPass.png',
                                color: Colors.cyan[800],
                              )
                            : Image.asset(
                                'assets/icons/unShowPass.png',
                                color: Colors.cyan[800],
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: repasswordController,
                    obscureText: showPW,
                    cursorColor: Colors.cyan[800],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      hintText: 'Nhập lại mật khẩu',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(90)),
                      child: const Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // sign up option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tôi có tài khoản! ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.cyan[800],
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
