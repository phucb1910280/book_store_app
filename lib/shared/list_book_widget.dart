import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/book.dart';

class ListOfBookWidget extends StatelessWidget {
  final Book? book;

  const ListOfBookWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              flex: 3,
              child: Image.network(
                book!.biaSach.toString(),
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            book!.tenSach.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Row(
                      children: [
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(book!.giaBan),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.cyan[800],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
