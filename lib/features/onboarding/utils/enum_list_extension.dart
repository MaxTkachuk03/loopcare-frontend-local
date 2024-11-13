extension EnumListExtension on List {
  List<E> insertAfter<E>(E element, E insertElement) {
    List<E> list = [];

    for (final e in this) {
      list.add(e);
      if (e == element) {
        list.add(insertElement);
      }
    }

    return list;
  }

  List<E> insertAllAfter<E>(Iterable<E> items, E element) {
    List<E> list = [];

    for (final e in this) {
      list.add(e);
      if (e == element) {
        list.addAll(items);
      }
    }

    return list;
  }
}
