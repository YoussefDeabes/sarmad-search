extension Validation on String {
  bool get isNullOrEmpty => (this != null && this.isNotEmpty) ? false : true;
}

extension StringExtension on String {
  String capitalizedFirstChar() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
