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
  bool get isNullOrEmpty {
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

  T? get firstOrNull {
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

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
