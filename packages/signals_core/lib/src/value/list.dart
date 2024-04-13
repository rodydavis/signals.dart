part of 'value.dart';

/// A [Signal] that holds a [List].
class ListSignal<E> extends _IterableSignal<E, List<E>>
    implements List<E>, Signal<List<E>> {
  /// Creates a [ListSignal] with the given [value].
  ListSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });

  @override
  List<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  set first(E val) {
    value.first = val;
    set(value, force: true);
  }

  @override
  E get last => value.last;

  @override
  set last(E val) {
    value.last = val;
    set(value, force: true);
  }

  @override
  set length(int value) {
    this.value.length = value;
    set(this.value, force: true);
  }

  @override
  List<E> operator +(List<E> other) {
    return value + other;
  }

  @override
  E operator [](int index) {
    return value[index];
  }

  @override
  void operator []=(int index, E value) {
    this.value[index] = value;
    set(this.value, force: true);
  }

  /// Inject: Update current signal value with iterable
  ListSignal<E> operator <<(Iterable<E> other) {
    value.addAll(other);
    set(value, force: true);
    return this;
  }

  /// Fork: create a new signal which value is the concatenation of source signal and iterable parameter
  ListSignal<E> operator &(Iterable<E> other) {
    final rs = List<E>.from(peek())..addAll(other);
    return ListSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  ListSignal<E> operator |(Signal<Iterable<E>> other) {
    final rs = List<E>.from(peek())..addAll(other.peek());
    return ListSignal(rs);
  }

  @override
  void add(E value) {
    this.value.add(value);
    set(this.value, force: true);
  }

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    set(value, force: true);
  }

  @override
  Map<int, E> asMap() {
    return value.asMap();
  }

  @override
  void clear() {
    value.clear();
    set(value, force: true);
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) {
    return value.expand<T>(toElements);
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    set(value, force: true);
  }

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return value.fold<T>(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  @override
  Iterable<E> getRange(int start, int end) {
    return value.getRange(start, end);
  }

  @override
  int indexOf(E element, [int start = 0]) {
    return value.indexOf(element, start);
  }

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) {
    return value.indexWhere(test, start);
  }

  @override
  void insert(int index, E element) {
    value.insert(index, element);
    set(value, force: true);
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    set(value, force: true);
  }

  @override
  int lastIndexOf(E element, [int? start]) {
    return value.lastIndexOf(element, start);
  }

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    return value.lastIndexWhere(test, start);
  }

  @override
  bool remove(Object? value) {
    final result = this.value.remove(value);
    set(this.value, force: true);
    return result;
  }

  @override
  E removeAt(int index) {
    final result = value.removeAt(index);
    set(value, force: true);
    return result;
  }

  @override
  E removeLast() {
    final result = value.removeLast();
    set(value, force: true);
    return result;
  }

  @override
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    set(value, force: true);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    set(value, force: true);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    set(value, force: true);
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    set(value, force: true);
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    set(value, force: true);
  }

  @override
  void shuffle([Random? random]) {
    value.shuffle(random);
    set(value, force: true);
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    set(value, force: true);
  }

  /// Return a new array that is sorted by the [compare] function
  List<E> sorted([int Function(E a, E b)? compare]) {
    final items = toList();
    items.sort(compare);
    return items;
  }

  @override
  List<E> sublist(int start, [int? end]) {
    return value.sublist(start, end);
  }

  @override
  bool operator ==(Object other) {
    return other is ListSignal<E> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value) item.hashCode
    ]);
  }
}

/// Create an [ListSignal] from [List]
ListSignal<T> listSignal<T>(
  List<T> list, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return ListSignal<T>(
    list,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalListUtils<T> on List<T> {
  /// Convert an existing list to [ListSignal]
  ListSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return ListSignal<T>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
