// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:simple_app/models/user.dart';

class EditProfile extends StatefulWidget {
  final CurrentUser currentUser;
  const EditProfile({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.currentUser.fullName!;
    phoneNumberController.text = widget.currentUser.phoneNumber!;
    addressController.text = widget.currentUser.address!;
    super.initState();
  }

  Widget customeText(String string) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        string,
        style: TextStyle(
          fontSize: 20,
          color: Colors.cyan[800],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customeText('Họ tên:'),
              TextField(
                controller: fullNameController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Họ tên',
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customeText('Số điện thoại:'),
              TextField(
                controller: phoneNumberController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Số điện thoại',
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customeText('Địa chỉ:'),
              TextField(
                controller: addressController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Địa chỉ',
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Map<String, String> profileUpdated = {
                              'fullName': fullNameController.text,
                              'address': addressController.text,
                              'phoneNumber': phoneNumberController.text,
                            };
                            CollectionReference collectionReference =
                                FirebaseFirestore.instance.collection('user');
                            DocumentReference documentReference =
                                collectionReference
                                    .doc(widget.currentUser.email);
                            documentReference.update(profileUpdated);
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            var currentUser = auth.currentUser;
                            var updatedUser = CurrentUser(
                                fullName: fullNameController.text,
                                address: addressController.text,
                                email: currentUser!.email,
                                phoneNumber: phoneNumberController.text);
                            // Navigator.pop(context);
                            Navigator.pop(context, updatedUser);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.cyan[800],
                                borderRadius: BorderRadius.circular(25)),
                            child: const Center(
                              child: Text(
                                'Xong',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.cyan[800]!, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                'Hủy',
                                style: TextStyle(
                                  color: Colors.cyan[800]!,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
