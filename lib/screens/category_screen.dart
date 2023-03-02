import 'package:flutter/material.dart';
import 'package:simple_app/shared/book_of_category.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'vanhoc',
                                      tenTheLoaiSach: 'Sách Văn học',
                                    )));
                      },
                      child: customeText('Sách Văn học')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'kinhte',
                                      tenTheLoaiSach: 'Sách Kinh tế',
                                    )));
                      },
                      child: customeText('Sách Kinh tế')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'sgk',
                                      tenTheLoaiSach: 'SGK - Tham khảo',
                                    )));
                      },
                      child: customeText('Sách Giáo khoa - Tham khảo')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'kynang',
                                      tenTheLoaiSach: 'Sách Kỹ năng sống',
                                    )));
                      },
                      child: customeText('Sách Kỹ năng sống')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'nuoicon',
                                      tenTheLoaiSach: 'Sách Nuôi dạy con',
                                    )));
                      },
                      child: customeText('Sách Nuôi dạy con')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'thieunhi',
                                      tenTheLoaiSach: 'Sách Thiếu nhi',
                                    )));
                      },
                      child: customeText('Sách Thiếu nhi')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.bottomLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookOfCategory(
                                      theLoaiSach: 'tieusu',
                                      tenTheLoaiSach: 'Sách Tiểu sử',
                                    )));
                      },
                      child: customeText('Sách Tiểu sử')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
