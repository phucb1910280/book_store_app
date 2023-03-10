// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String docId;

  const OrderDetail({
    Key? key,
    required this.documentSnapshot,
    required this.docId,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Widget customeText(String text,
      {double? size, bool? isBold, bool? isTealColor}) {
    return Text(
      text,
      style: TextStyle(
        // ignore: prefer_if_null_operators
        fontSize: size == null ? 23 : size,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
        color: isTealColor == true ? Colors.teal : Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      customeText('Mã đơn hàng:', isBold: false),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      customeText(widget.documentSnapshot['id'], isBold: true),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      customeText('Trạng thái', isBold: false),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      customeText(widget.documentSnapshot['trangThaiDonHang'],
                          isBold: false),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      customeText('Ngày đặt:', isBold: false),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      customeText(widget.documentSnapshot['ngayDat'],
                          isBold: false),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      customeText('Ngày giao dự kiến:', isBold: false),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      customeText(widget.documentSnapshot['ngayGiaoDuKien'],
                          isBold: false),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customeText('Người nhận:  ', isBold: false),
                      Flexible(
                        child: customeText(
                            '${widget.documentSnapshot['fullName']}\n${widget.documentSnapshot['phoneNumber']}\n${widget.documentSnapshot['address']}',
                            isBold: true),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      customeText('Chi tiết đơn hàng',
                          size: 30, isTealColor: true),
                      // Text(documentSnapshot['ngayGiaoDuKien']),
                    ],
                  ),
                  BookOrdered(
                      documentSnapshot: widget.documentSnapshot,
                      docId: widget.docId),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      customeText('Tổng cộng:', isBold: false, size: 25),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      customeText('${widget.documentSnapshot['tongHoaDon']}₫',
                          isBold: true, isTealColor: true, size: 25),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class BookOrdered extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  final String docId;

  const BookOrdered({
    Key? key,
    required this.documentSnapshot,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userOrder')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('orderItems')
            .doc(docId)
            .collection('cacSanpham')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  snapshot.data!.docs.isEmpty ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                String docId = snapshot.data!.docs[index].id;
                return CustomeListTile(
                  docID: docId,
                  documentSnapshot: documentSnapshot,
                );
              },
            );
          } else {
            return const Center(child: Text('Loading'));
          }
        },
      ),
    );
  }
}

class CustomeListTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String docID;
  const CustomeListTile({
    Key? key,
    required this.documentSnapshot,
    required this.docID,
  }) : super(key: key);

  int totalPrice() {
    int t = documentSnapshot['soLuong'] * documentSnapshot['giaBan'];
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        height: 150,
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                      documentSnapshot['biaSach'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            documentSnapshot['tenSach'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        //
                        '${totalPrice().toString()}₫',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'x${documentSnapshot['soLuong']}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
