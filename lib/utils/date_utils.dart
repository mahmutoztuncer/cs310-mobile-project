/// Date helpers shared across screens.
/// Named AppDateUtils because Flutter's material library already has a DateUtils class.
class AppDateUtils {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  /// e.g. "Nov 20, 14:00"
  static String formatDateTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${_months[d.month - 1]} ${d.day}, $hh:$mm';
  }
}
