import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';

/// [Signal] + [Stream]
class SignalStream<T> extends Signal<T> implements StreamSink<T>, Stream<T> {
  /// [Signal] + [Stream]
  SignalStream(
    super.internalValue, {
    super.debugLabel,
    super.autoDispose,
  }) {
    stream = toStream();
    addStream(stream);
  }

  /// [Signal] + [ValueNotifier]
  SignalStream.fromSignal(super.source) {
    stream = toStream();
    addStream(stream);
  }

  /// Internal stream
  @visibleForTesting
  late StreamController<T> controller = StreamController.broadcast();

  /// Internal stream of signal
  @visibleForTesting
  late final Stream<T> stream;

  @override
  void add(T event) => value = event;

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    controller.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<T> stream) {
    return controller.addStream(stream);
  }

  @override
  Future<bool> any(bool Function(T element) test) {
    return stream.any((element) => false);
  }

  @override
  Stream<T> asBroadcastStream({
    void Function(StreamSubscription<T> subscription)? onListen,
    void Function(StreamSubscription<T> subscription)? onCancel,
  }) {
    return stream.asBroadcastStream(
      onListen: onListen,
      onCancel: onCancel,
    );
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(T event) convert) {
    return stream.asyncExpand<E>(convert);
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(T event) convert) {
    return stream.asyncMap<E>(convert);
  }

  @override
  Stream<R> cast<R>() {
    return stream.cast<R>();
  }

  @override
  Future close() {
    return controller.close();
  }

  @override
  Future<bool> contains(Object? needle) {
    return stream.contains(needle);
  }

  @override
  Stream<T> distinct([bool Function(T previous, T next)? equals]) {
    return stream.distinct(equals);
  }

  @override
  Future get done => controller.done;

  @override
  Future<E> drain<E>([E? futureValue]) {
    return stream.drain<E>(futureValue);
  }

  @override
  Future<T> elementAt(int index) {
    return stream.elementAt(index);
  }

  @override
  Future<bool> every(bool Function(T element) test) {
    return stream.every(test);
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(T element) convert) {
    return stream.expand<S>(convert);
  }

  @override
  Future<T> get first => stream.first;

  @override
  Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse}) {
    return stream.firstWhere(test, orElse: orElse);
  }

  @override
  Future<S> fold<S>(S initialValue, S Function(S previous, T element) combine) {
    return stream.fold<S>(initialValue, combine);
  }

  @override
  Future<void> forEach(void Function(T element) action) {
    return stream.forEach(action);
  }

  @override
  Stream<T> handleError(
    Function onError, {
    bool Function(dynamic error)? test,
  }) {
    return stream.handleError(onError, test: test);
  }

  @override
  bool get isBroadcast => stream.isBroadcast;

  @override
  Future<bool> get isEmpty => stream.isEmpty;

  @override
  Future<String> join([String separator = ""]) {
    return stream.join(separator);
  }

  @override
  Future<T> get last => stream.last;

  @override
  Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse}) {
    return stream.lastWhere(test, orElse: orElse);
  }

  @override
  Future<int> get length => stream.length;

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Stream<S> map<S>(S Function(T event) convert) {
    return stream.map<S>(convert);
  }

  @override
  Future pipe(StreamConsumer<T> streamConsumer) {
    return stream.pipe(streamConsumer);
  }

  @override
  Future<T> reduce(T Function(T previous, T element) combine) {
    return stream.reduce(combine);
  }

  @override
  Future<T> get single => stream.single;

  @override
  Future<T> singleWhere(
    bool Function(T element) test, {
    T Function()? orElse,
  }) {
    return stream.singleWhere(test, orElse: orElse);
  }

  @override
  Stream<T> skip(int count) {
    return stream.skip(count);
  }

  @override
  Stream<T> skipWhile(bool Function(T element) test) {
    return stream.skipWhile(test);
  }

  @override
  Stream<T> take(int count) {
    return stream.take(count);
  }

  @override
  Stream<T> takeWhile(bool Function(T element) test) {
    return stream.takeWhile(test);
  }

  @override
  Stream<T> timeout(
    Duration timeLimit, {
    void Function(EventSink<T> sink)? onTimeout,
  }) {
    return stream.timeout(timeLimit, onTimeout: onTimeout);
  }

  @override
  Future<List<T>> toList() {
    return stream.toList();
  }

  @override
  Future<Set<T>> toSet() {
    return stream.toSet();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<T, S> streamTransformer) {
    return stream.transform<S>(streamTransformer);
  }

  @override
  Stream<T> where(bool Function(T event) test) {
    return stream.where(test);
  }
}
