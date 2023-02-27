import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  Widget customeText(String categoryName) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        categoryName,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.teal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục sách'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: customeText('Sách Văn học'),
            ),
            GestureDetector(
              onTap: () {},
              child: customeText('Sách Thiếu Nhi'),
            ),
            GestureDetector(
              onTap: () {},
              child: customeText('Truyện tranh'),
            ),
            GestureDetector(
              onTap: () {},
              child: customeText('Sách Giáo khoa - Tham khảo'),
            ),
          ],
        ),
      ),
    );
  }
}
