enum ShirtSize {
  S,
  M,
  XL,
  XXL,
}

extension ShirtVal on ShirtSize {

  static const displayMap = {
    ShirtSize.S: "S",
    ShirtSize.M: "M",
    ShirtSize.XL : "XL",
    ShirtSize.XXL: "XXL",
  };

  String get displayName => displayMap[this];
}
