class CurrentUser {
  String? fullName;
  String? address;
  String? email;
  String? phoneNumber;

  CurrentUser({
    required this.fullName,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, Object?> toJson() {
    return {
      // 'id': id,
      'fullName': fullName,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
