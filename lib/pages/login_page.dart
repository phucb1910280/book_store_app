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
  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false);
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => const MainPage()));
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      // _showDialog(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password'),
        backgroundColor: Colors.red,
      ));
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
      // backgroundColor: const Color(0xff09203F),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                Image.asset(
                  'assets/images/appLogo_02.png',
                  height: 250,
                  width: 250,
                  // fit: BoxFit.fitWidth
                ),

                const SizedBox(
                  height: 20,
                ),
                // welcome back!
                const Center(
                  child: Text(
                    'WELCOME BACK!',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0xffE899DC),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0xffE899DC),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
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
                    onTap: login,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Login',
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
                      'Not a member? ',
                      style: TextStyle(
                        color: Color(0xffA4508B),
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Color(0xff5F0A87),
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
