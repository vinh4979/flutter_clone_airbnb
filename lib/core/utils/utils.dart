import 'dart:math';
import 'package:intl/intl.dart';

String genRandomRating({double min = 3.5, double max = 5.0}) {
  final r = Random();
  final value = min + r.nextDouble() * (max - min);
  return value.toStringAsFixed(1);
}

// do giá phong API trả về số ko được đẹp nên func này giúp làm đẹp giá phòng VND
String formatRoomPrice(dynamic rawPrice) {
  final numberFormat = NumberFormat.decimalPattern('vi_VN');
  final random = Random();

  // Ép kiểu số
  int price = 0;
  if (rawPrice is num) {
    price = rawPrice.toInt();
  } else if (rawPrice is String) {
    price = int.tryParse(rawPrice) ?? 0;
  }

  // Nếu giá <= 0, random từ 200.000 đến 900.000
  if (price <= 0) {
    price = 200000 + random.nextInt(700000); // 200.000 -> 900.000
  }
  // Nếu giá nhỏ < 100
  else if (price < 1000) {
    price *= 10000;
  }

  return "₫${numberFormat.format(price)} / đêm";
}
