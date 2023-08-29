import 'package:flutter/material.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price,
      {double? discount, String? discountType}) {
    double _price = price;
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        _price = _price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        _price = _price - ((discount / 100) * _price);
      }
    }
    return '${_price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }
}
