import 'dart:ffi';

class Book {
  // String? id;
  String? tenSach;
  String? biaSach;
  String? tacGia;
  num? giaBan;
  num? soTrang;
  String? loaiBia;
  String? theLoai;
  String? moTa;
  bool yeuThich = false;

  Book({
    // required this.id,
    required this.tenSach,
    required this.biaSach,
    required this.tacGia,
    required this.giaBan,
    required this.soTrang,
    required this.loaiBia,
    required this.theLoai,
    required this.moTa,
    required this.yeuThich,
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
          // id: (json['id']! as String),
          tenSach: (json['tenSach']! as String),
          biaSach: (json['biaSach']! as String),
          tacGia: (json['tacGia']! as String),
          giaBan: (json['giaBan']! as num),
          soTrang: (json['soTrang']! as num),
          loaiBia: (json['loaiBia']! as String),
          theLoai: (json['theLoai']! as String),
          moTa: (json['moTa']! as String),
          yeuThich: (json['yeuThich']! as bool),
        );

  Map<String, Object?> toJson() {
    return {
      // 'id': id,
      'tenSach': tenSach,
      'biaSach': biaSach,
      'tacGia': tacGia,
      'giaBan': giaBan,
      'soTrang': soTrang,
      'loaiBia': loaiBia,
      'theLoai': theLoai,
      'moTa': moTa,
      'yeuThich': yeuThich,
    };
  }
}
