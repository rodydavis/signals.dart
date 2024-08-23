part of 'value.dart';

/// A [Signal] that holds a [Queue].
class QueueSignal<T> extends Signal<Queue<T>>
    with ValueSignalMixin
    implements Queue<T> {
  /// Creates a [QueueSignal] with the given [value].
  QueueSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });

  @override
  void add(T value) {
    this.value.add(value);
    set(this.value, force: true);
  }

  @override
  void addAll(Iterable<T> iterable) {
    value.addAll(iterable);
    set(value, force: true);
  }

  @override
  void addFirst(T value) {
    this.value.addFirst(value);
    set(this.value, force: true);
  }

  @override
  void addLast(T value) {
    this.value.addLast(value);
    set(this.value, force: true);
  }

  @override
  bool any(bool Function(T element) test) {
    return value.any(test);
  }

  @override
  Queue<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  void clear() {
    value.clear();
  }

  @override
  bool contains(Object? element) {
    return value.contains(element);
  }

  @override
  T elementAt(int index) {
    return value.elementAt(index);
  }

  @override
  bool every(bool Function(T element) test) {
    return value.every(test);
  }

  @override
  Iterable<U> expand<U>(Iterable<U> Function(T element) toElements) {
    return expand<U>(toElements);
  }

  @override
  T get first => value.first;

  @override
  T firstWhere(bool Function(T element) test, {T Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  U fold<U>(U initialValue, U Function(U previousValue, T element) combine) {
    return fold<U>(initialValue, combine);
  }

  @override
  Iterable<T> followedBy(Iterable<T> other) {
    return value.followedBy(other);
  }

  @override
  void forEach(void Function(T element) action) {
    value.forEach(action);
  }

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterator<T> get iterator => value.iterator;

  @override
  String join([String separator = ""]) {
    return value.join(separator);
  }

  @override
  T get last => value.last;

  @override
  T lastWhere(bool Function(T element) test, {T Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }

  @override
  int get length => value.length;

  @override
  Iterable<U> map<U>(U Function(T e) toElement) {
    return value.map(toElement);
  }

  @override
  T reduce(T Function(T value, T element) combine) {
    return value.reduce(combine);
  }

  @override
  bool remove(Object? value) {
    final result = this.value.remove(value);
    set(this.value, force: true);
    return result;
  }

  @override
  T removeFirst() {
    final result = value.removeFirst();
    set(value, force: true);
    return result;
  }

  @override
  T removeLast() {
    final result = value.removeLast();
    set(value, force: true);
    return result;
  }

  @override
  void removeWhere(bool Function(T element) test) {
    final result = value.removeWhere(test);
    set(value, force: true);
    return result;
  }

  @override
  void retainWhere(bool Function(T element) test) {
    final result = value.retainWhere(test);
    set(value, force: true);
    return result;
  }

  @override
  T get single => value.single;

  @override
  T singleWhere(bool Function(T element) test, {T Function()? orElse}) {
    return value.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> skip(int count) {
    return value.skip(count);
  }

  @override
  Iterable<T> skipWhile(bool Function(T value) test) {
    return value.skipWhile(test);
  }

  @override
  Iterable<T> take(int count) {
    return value.take(count);
  }

  @override
  Iterable<T> takeWhile(bool Function(T value) test) {
    return value.takeWhile(test);
  }

  @override
  List<T> toList({bool growable = true}) => value.toList(growable: growable);

  @override
  Set<T> toSet() => value.toSet();

  @override
  Iterable<T> where(bool Function(T element) test) => value.where(test);

  @override
  Iterable<U> whereType<U>() => value.whereType<U>();
}

/// Create an [QueueSignal] from [Queue]
QueueSignal<T> queueSignal<T>(
  Queue<T> list, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return QueueSignal<T>(
    list,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalQueueUtils<T> on Queue<T> {
  /// Convert an existing list to [QueueSignal]
  QueueSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return QueueSignal(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
