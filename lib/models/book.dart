class Book {
  String? id;
  String tenSach;
  String biaSach;
  String tacGia;
  String giaBan;
  String soTrang;
  String loaiBia;
  String theLoai;
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
    required this.moTa,
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
          id: (json['id']! as String),
          tenSach: (json['tenSach']! as String),
          biaSach: (json['biaSach']! as String),
          tacGia: (json['tacGia']! as String),
          giaBan: (json['giaBan']! as String),
          soTrang: (json['soTrang']! as String),
          loaiBia: (json['loaiBia']! as String),
          theLoai: (json['theLoai']! as String),
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
      'moTa': moTa,
    };
  }
}
