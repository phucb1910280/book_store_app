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
      checkRegisterForm();
      if (confirmedPW()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        addUserDetail(
            fullNameController.text, '', emailController.text.trim(), '', '');
        if (FirebaseAuth.instance.currentUser != null) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        }
      } else {
        showDialog(
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
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Có lỗi xảy ra.\nVui lòng thử lại sau.'),
            // content:
            //     const Text('Vui lòng đăng nhập để thêm sách vào giỏ hàng!'),
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

  checkRegisterForm() {
    if (fullNameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // title: const Text('Sai Email/ Mật khẩu'),
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
    }
    if (passwordController.text.length < 8) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // title: const Text('Sai Email/ Mật khẩu'),
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
    }
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(25),
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(25),
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
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.cyan[800]!,
                            ),
                            borderRadius: BorderRadius.circular(25),
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
                    obscureText: true,
                    cursorColor: Colors.cyan[800],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.cyan[800]!,
                        ),
                        borderRadius: BorderRadius.circular(25),
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
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(25)),
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
