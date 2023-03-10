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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('M???t kh???u kh??ng tr??ng kh???p'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ));
    }
  }

  checkRegisterForm() {
    if (fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vui l??ng nh???p h??? t??n'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('M???t kh???u ph???i d??i h??n 8 k?? t???'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
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
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Ch??o m???ng b???n!',
                      style: TextStyle(
                        color: Colors.black,
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
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      hintText: 'H??? t??n',
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
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.black,
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
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'M???t kh???u',
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
                            ? Image.asset('assets/icons/showPass.png')
                            : Image.asset('assets/icons/unShowPass.png'),
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
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      hintText: 'Nh???p l???i m???t kh???u',
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
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          '????ng k??',
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
                      'T??i c?? t??i kho???n! ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        '????ng nh???p',
                        style: TextStyle(
                          color: Colors.purple,
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
