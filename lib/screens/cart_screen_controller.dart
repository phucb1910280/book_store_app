import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'logged/cart_logged.dart';
import 'not_logged_in/cart_not_logged.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const CartLogged();
    } else {
      return const CartNotLogged();
    }
  }
}
