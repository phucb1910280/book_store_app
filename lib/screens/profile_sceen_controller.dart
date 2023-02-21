import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/screens/not_logged_in/profile_not_logged.dart';
import 'package:simple_app/screens/logged/profile_logged.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const ProfileLogged();
    } else {
      return const ProfileNotLoggedIn();
    }
  }
}
