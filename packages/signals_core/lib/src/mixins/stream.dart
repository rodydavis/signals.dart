import 'dart:async';

import '../../signals_core.dart';

/// [Stream] implementation for [AsyncState]
mixin StreamSignalMixin<T> on ReadonlySignal<T> implements Stream<T> {
  final _controller = StreamController<T>.broadcast(sync: true);
  void Function()? _cleanup;

  late final Stream<T> _stream = () {
    final s = toStream();
    _cleanup = subscribe(_controller.add);
    return s;
  }();

  @override
  void dispose() {
    _cleanup?.call();
    _controller.close();
    super.dispose();
  }

  @override
  Future<bool> any(bool Function(T element) test) async {
    return await _stream.any(test);
  }

  @override
  Stream<T> asBroadcastStream({
    void Function(StreamSubscription<T> subscription)? onListen,
    void Function(StreamSubscription<T> subscription)? onCancel,
  }) {
    return _stream.asBroadcastStream(
      onListen: onListen,
      onCancel: onCancel,
    );
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(T event) convert) {
    return _stream.asyncExpand(convert);
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(T event) convert) {
    return _stream.asyncMap(convert);
  }

  @override
  Stream<R> cast<R>() {
    return _stream.cast<R>();
  }

  @override
  Future<bool> contains(Object? needle) async {
    return await _stream.contains(needle);
  }

  @override
  Stream<T> distinct([bool Function(T previous, T next)? equals]) {
    return _stream.distinct(equals);
  }

  @override
  Future<E> drain<E>([E? futureValue]) async {
    return await _stream.drain(futureValue);
  }

  @override
  Future<T> elementAt(int index) async {
    return await _stream.elementAt(index);
  }

  @override
  Future<bool> every(bool Function(T element) test) async {
    return await _stream.every(test);
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(T element) convert) {
    return _stream.expand<S>(convert);
  }

  @override
  Future<T> get first => _stream.first;

  @override
  Future<T> firstWhere(
    bool Function(T element) test, {
    T Function()? orElse,
  }) async {
    return await _stream.firstWhere(test, orElse: orElse);
  }

  @override
  Future<S> fold<S>(
    S initialValue,
    S Function(S previous, T element) combine,
  ) async {
    return await _stream.fold<S>(initialValue, combine);
  }

  @override
  Future<void> forEach(void Function(T element) action) async {
    return await _stream.forEach(action);
  }

  @override
  Stream<T> handleError(
    Function onError, {
    bool Function(dynamic error)? test,
  }) {
    return _stream.handleError(onError, test: test);
  }

  @override
  bool get isBroadcast => _stream.isBroadcast;

  @override
  Future<bool> get isEmpty => _stream.isEmpty;

  @override
  Future<String> join([String separator = ""]) async {
    return await _stream.join(separator);
  }

  @override
  Future<T> get last => _stream.last;

  @override
  Future<T> lastWhere(
    bool Function(T element) test, {
    T Function()? orElse,
  }) async {
    return await _stream.lastWhere(test, orElse: orElse);
  }

  @override
  Future<int> get length => _stream.length;

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Stream<S> map<S>(S Function(T event) convert) {
    return _stream.map<S>(convert);
  }

  @override
  Future pipe(StreamConsumer<T> streamConsumer) async {
    return await _stream.pipe(streamConsumer);
  }

  @override
  Future<T> reduce(T Function(T previous, T element) combine) async {
    return await _stream.reduce(combine);
  }

  @override
  Future<T> get single => _stream.single;

  @override
  Future<T> singleWhere(
    bool Function(T element) test, {
    T Function()? orElse,
  }) async {
    return await _stream.singleWhere(test, orElse: orElse);
  }

  @override
  Stream<T> skip(int count) {
    return _stream.skip(count);
  }

  @override
  Stream<T> skipWhile(bool Function(T element) test) {
    return _stream.skipWhile(test);
  }

  @override
  Stream<T> take(int count) {
    return _stream.take(count);
  }

  @override
  Stream<T> takeWhile(bool Function(T element) test) {
    return _stream.takeWhile(test);
  }

  @override
  Stream<T> timeout(
    Duration timeLimit, {
    void Function(EventSink<T> sink)? onTimeout,
  }) {
    return _stream.timeout(timeLimit, onTimeout: onTimeout);
  }

  @override
  Future<List<T>> toList() async {
    return await _stream.toList();
  }

  @override
  Future<Set<T>> toSet() async {
    return await _stream.toSet();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<T, S> streamTransformer) {
    return _stream.transform<S>(streamTransformer);
  }

  @override
  Stream<T> where(bool Function(T event) test) {
    return _stream.where(test);
  }
}
