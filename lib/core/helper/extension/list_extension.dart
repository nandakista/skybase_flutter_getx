extension ListNullExt<T> on List<T>? {
  String? getValues() {
    if(this != null) {
      return toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '');

    }
    return null;
  }
}