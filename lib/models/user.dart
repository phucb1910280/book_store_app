import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrentUser {
  String? fullName;
  String? address;
  String? cccd;
  String? email;
  String? phoneNumber;

  CurrentUser({
    required this.fullName,
    required this.address,
    required this.cccd,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'address': address,
      'cccd': cccd,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, Object?> toJson() {
    return {
      // 'id': id,
      'fullName': fullName,
      'address': address,
      'cccd': cccd,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      cccd: map['cccd'] != null ? map['cccd'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  factory CurrentUser.fromJson(String source) =>
      CurrentUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
