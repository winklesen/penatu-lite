import 'package:intl/intl.dart';

/// Just for helping currency lol
class CurrencyFormat {
  static String convertToIdr({required dynamic number, int decimalDigit = 2}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
