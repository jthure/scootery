extension IterableUtils<T> on Iterable<T> {
  Iterable<T> uniqueBy<E>(E Function(T) f) sync* {
    var set = Set<E>();
    for (var t in this) {
      var e = f(t);
      if (!set.contains(e)) {
        set.add(e);
        yield t;
      }
    }
  }

  Iterable<T> unique() {
    return this.uniqueBy((x) => x);
  }
}
