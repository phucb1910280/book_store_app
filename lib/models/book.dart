// ignore_for_file: public_member_api_docs, sort_constructors_first
class Book {
  String? id;
  String tenSach;
  String biaSach;
  String tacGia;
  int giaBan;
  int soTrang;
  String loaiBia;
  String theLoai;
  String thuocTheLoai;
  String moTa;

  Book({
    required this.id,
    required this.tenSach,
    required this.biaSach,
    required this.tacGia,
    required this.giaBan,
    required this.soTrang,
    required this.loaiBia,
    required this.theLoai,
    required this.thuocTheLoai,
    required this.moTa,
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
          id: (json['id']! as String),
          tenSach: (json['tenSach']! as String),
          biaSach: (json['biaSach']! as String),
          tacGia: (json['tacGia']! as String),
          giaBan: (json['giaBan']! as int),
          soTrang: (json['soTrang']! as int),
          loaiBia: (json['loaiBia']! as String),
          theLoai: (json['theLoai']! as String),
          thuocTheLoai: (json['thuocTheLoai']! as String),
          moTa: (json['moTa']! as String),
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'tenSach': tenSach,
      'biaSach': biaSach,
      'tacGia': tacGia,
      'giaBan': giaBan,
      'soTrang': soTrang,
      'loaiBia': loaiBia,
      'theLoai': theLoai,
      'thuocTheLoai': thuocTheLoai,
      'moTa': moTa,
    };
  }
}
