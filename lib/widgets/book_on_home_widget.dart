import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/book.dart';

class BookDetainOnHome extends StatelessWidget {
  final Book? book;

  const BookDetainOnHome({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    num? currency = book!.giaBan;
    final oCcy = NumberFormat('#,##0', 'en_US');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: screenWidth * 0.5,
                  width: screenWidth * 0.5,
                  child: Image.network(
                    book!.biaSach.toString(),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          book!.tenSach.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      Text(
                        '${oCcy.format(currency)} ₫',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
