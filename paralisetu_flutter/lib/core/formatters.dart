import 'package:intl/intl.dart';

class Formatters {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final _numberFormat = NumberFormat.decimalPattern('en_IN');
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  static String money(num amount) {
    return _currencyFormat.format(amount);
  }

  static String kg(num kilograms) {
    return '${_numberFormat.format(kilograms)} kg';
  }

  static String date(DateTime? dt) {
    if (dt == null) return '';
    return _dateFormat.format(dt);
  }
}
