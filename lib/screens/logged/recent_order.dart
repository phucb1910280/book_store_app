import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/screens/logged/order_detail.dart';

class RecentOrder extends StatefulWidget {
  const RecentOrder({super.key});

  @override
  State<RecentOrder> createState() => _RecentOrderState();
}

class _RecentOrderState extends State<RecentOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userOrder')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('orderItems')
            .orderBy('id', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount:
                  snapshot.data!.docs.isEmpty ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                // String docId = snapshot.data!.docs[index].id;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetail(
                          docId: documentSnapshot.id,
                          documentSnapshot: documentSnapshot,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Mã đơn: ${documentSnapshot['id']}'),
                    subtitle: Text('Ngày đặt: ${documentSnapshot['ngayDat']}'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Đang tải'));
          }
        },
      ),
    );
  }
}
