import 'package:flutter/material.dart';
import 'package:simple_app/pages/home_page.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/orderSuccess.png',
                color: Colors.cyan[800],
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Đặt hàng thành công',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          outFromIndex: 3,
                        ),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    // border: Border.all(
                    //   width: 2,
                    // ),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(
                      child: Text(
                    'Kiểm tra đơn hàng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 40,
                width: 150,
                child: Divider(
                  thickness: 1,
                  color: Colors.cyan[800],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          outFromIndex: 0,
                        ),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.cyan[800]!,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                      child: Text(
                    'Tiếp tục mua sắm',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.cyan[800],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
