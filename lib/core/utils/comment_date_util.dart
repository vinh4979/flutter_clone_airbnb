import 'package:intl/intl.dart';

class CommentDateUtil {
  static String format(String rawDate) {
    try {
      DateTime? date;

      // Trường hợp định dạng 2024-10-08T15:49:50.196Z
      if (rawDate.contains('T') && rawDate.contains('Z')) {
        date = DateTime.parse(rawDate).toLocal();
        final hour = DateFormat('HH:mm').format(date);
        final monthYear = DateFormat('MM / yyyy').format(date);
        return '$hour · $monthYear';
      }

      // Trường hợp dd/MM/yyyy HH:mm:ss
      if (RegExp(r'^\d{2}/\d{2}/\d{4}').hasMatch(rawDate)) {
        date = DateFormat('dd/MM/yyyy HH:mm:ss').parse(rawDate);
      }
      // Trường hợp dạng GMT string
      else if (rawDate.contains('GMT')) {
        date =
            DateTime.tryParse(rawDate) ??
            DateFormat('EEE MMM dd yyyy HH:mm:ss').parseLoose(rawDate);
      }

      // Nếu không parse được thì trả về fallback
      if (date == null) return 'Vài tháng trước';

      // Nếu parse thành công thì tính thời gian cách đây bao lâu
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays < 30) {
        return '${difference.inDays} ngày trước';
      } else {
        final monthsAgo = difference.inDays ~/ 30;
        return '$monthsAgo tháng trước';
      }
    } catch (e) {
      return 'Vài tháng trước';
    }
  }
}
