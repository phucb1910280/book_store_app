import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              creditText('Ứng dụng mua sách online,'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              creditText('được xây dựng bởi Đào Vĩnh Phúc,'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              creditText('mã số sinh viên B1910280,'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              creditText('nhằm phục vụ HP Niên luận CNTT.'),
            ],
          ),
        ],
      )),
    );
  }

  Widget creditText(String value) {
    return Text(
      value,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
