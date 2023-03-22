import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePW = true;

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
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
            title: const Text('Sai Email/ Mật khẩu'),
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
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Email hoặc mật khẩu không hợp lệ!'),
      //   backgroundColor: Colors.red,
      //   duration: Duration(seconds: 1),
      // ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                Image.asset(
                  'assets/images/appLogo_05.png',
                  height: 210,
                  width: 340,
                  // fit: BoxFit.fitWidth
                ),

                const SizedBox(
                  height: 20,
                ),
                // welcome back!
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Xin chào!',
                      style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // email textfield
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
                        obscureText: hidePW,
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
                            hidePW = !hidePW;
                          });
                        },
                        icon: hidePW
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

                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: login,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          'Đăng nhập',
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
                      'Chưa có tài khoản? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Đăng ký ngay',
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
