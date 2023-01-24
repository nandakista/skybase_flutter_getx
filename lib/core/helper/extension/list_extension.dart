extension ListExtension<T> on List<T> {
  List<T> replaceElement({required T element}) {
    int index = indexOf(element);
    this[index] = element;
    return this;
  }

  List<T> replaceMultipleElement({required List<T> elements}) {
    for (T i in elements) {
      int index = indexOf(i);
      this[index] = i;
    }
    return this;
  }
}

extension ListNullExtension<T> on List<T>? {
  bool isNullOrEmpty() {
    if (this == null) {
      return true;
    } else {
      if (this!.isEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  T? firstOrNull() {
    if (this != null) {
      if (this!.isNotEmpty) {
        return this![0];
      } else {
        return null;
      }
    }
    return null;
  }
}
