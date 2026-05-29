import 'dart:async';

import '../core/signals.dart';
import 'future.dart';
import 'signal.dart';


/// Create an asynchronous computed signal by explicitly declaring its dependencies.
///
/// `computedFrom` takes a list of [signals] and a [callback] function to compute
/// the value of the signal every time one of the declared [signals] changes.
///
/// Unlike [computedAsync], which tracks dependencies implicitly, `computedFrom` is
/// immune to the **Async Gap Gotcha** because all tracking is declared upfront.
///
/// ### Why use `computedFrom`?
/// When writing asynchronous code, Dart yields control at every `await` keyword.
/// Implicit tracking (in [computedAsync] or [computed]) cannot track reads that happen
/// *after* an asynchronous gap because the active reactive reader context is lost.
///
/// `computedFrom` solves this by:
/// 1. Subscribing to the list of input [signals] synchronously.
/// 2. Reading their latest values synchronously.
/// 3. Passing those resolved values into your callback as an ordered list of arguments.
///
/// ### Example: Fetching user details when an ID signal changes
///
/// ```dart
/// final userId = signal(123);
///
/// // The callback receives the current values of the declared signals
/// final userProfile = computedFrom([userId], (args) async {
///   final currentId = args.first; // Type-safe list of dependencies
///   return fetchUserProfileFromServer(currentId);
/// });
///
/// // userProfile is a FutureSignal<UserProfile> which can be pattern-matched
/// effect(() {
///   userProfile.value.map(
///     data: (profile) => print('Loaded profile: ${profile.name}'),
///     error: (err, stack) => print('Error: $err'),
///     loading: () => print('Fetching profile...'),
///   );
/// });
///
/// // Updating userId automatically triggers a new asynchronous fetch
/// userId.value = 456;
/// ```
///
/// @link https://dartsignals.dev/async/computed
FutureSignal<T> computedFrom<T, A>(
  List<ReadonlySignal<A>> signals,
  Future<T> Function(List<A> args) fn, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
  T? initialValue,
  @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return FutureSignal<T>(
    () => fn(signals.map((e) => e()).toList()),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: signals,
      initialValue: initialValue,
      lazy: lazy,
      autoDispose: autoDispose,
      name: debugLabel,
    ),
  );
}

/// Create an asynchronous computed signal with implicit dependency tracking.
///
/// `computedAsync` takes an asynchronous [callback] function to compute the value
/// of the signal. Any signal read *synchronously* inside the callback is automatically
/// tracked as a dependency, and the computed signal is re-evaluated when any of those
/// dependencies change.
///
/// ### ⚠️ The Async Gap Gotcha
/// Because Dart yields execution at every `await` expression, the reactive context that
/// automatically tracks reads is lost after an asynchronous gap.
///
/// **Rule:** All signal values MUST be read synchronously *before* the first `await` statement.
///
/// #### ❌ Incorrect Pattern (Signal read after await is NOT tracked):
/// ```dart
/// final movie = computedAsync(() async {
///   await Future.delayed(Duration(milliseconds: 100));
///   // BUG: movieId is read AFTER an async gap.
///   // Changes to movieId will NOT re-evaluate this computedAsync!
///   return fetchMovie(movieId.value);
/// });
/// ```
///
/// ####  Correct Pattern (Read dependencies synchronously first):
/// ```dart
/// final movie = computedAsync(() async {
///   // Capture all dependency values synchronously at the start!
///   final currentId = movieId.value;
///
///   await Future.delayed(Duration(milliseconds: 100));
///   // Use the captured local variable after the async gap
///   return fetchMovie(currentId);
/// });
/// ```
///
/// ### Advanced Example: Search Query with Debouncing
///
/// ```dart
/// final searchQuery = signal('');
///
/// final searchResults = computedAsync(() async {
///   // Capture dependency synchronously
///   final query = searchQuery.value;
///
///   if (query.isEmpty) return <SearchResult>[];
///
///   // Debounce: Wait 300ms before making the API request
///   await Future.delayed(Duration(milliseconds: 300));
///
///   return performSearchApiCall(query);
/// });
/// ```
///
/// @link https://dartsignals.dev/async/computed
FutureSignal<T> computedAsync<T>(
  Future<T> Function() fn, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
  T? initialValue,
  @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead')
  List<ReadonlySignal<dynamic>>? dependencies,
  @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return FutureSignal<T>(
    fn,
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      initialValue: initialValue,
      dependencies: dependencies,
      lazy: lazy,
      autoDispose: autoDispose,
      name: debugLabel,
    ),
  );
}

/// Create an asynchronous computed signal from 1 dependency.
FutureSignal<T> computedFrom1<T, A>(
  ReadonlySignal<A> s1,
  FutureOr<T> Function(A) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1],
    ),
  );
}

/// Create an asynchronous computed signal from 2 dependencies.
FutureSignal<T> computedFrom2<T, A, B>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  FutureOr<T> Function(A, B) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2],
    ),
  );
}

/// Create an asynchronous computed signal from 3 dependencies.
FutureSignal<T> computedFrom3<T, A, B, C>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  FutureOr<T> Function(A, B, C) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3],
    ),
  );
}

/// Create an asynchronous computed signal from 4 dependencies.
FutureSignal<T> computedFrom4<T, A, B, C, D>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  FutureOr<T> Function(A, B, C, D) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4],
    ),
  );
}

/// Create an asynchronous computed signal from 5 dependencies.
FutureSignal<T> computedFrom5<T, A, B, C, D, E>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  FutureOr<T> Function(A, B, C, D, E) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5],
    ),
  );
}

/// Create an asynchronous computed signal from 6 dependencies.
FutureSignal<T> computedFrom6<T, A, B, C, D, E, F>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  ReadonlySignal<F> s6,
  FutureOr<T> Function(A, B, C, D, E, F) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value, s6.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5, s6],
    ),
  );
}

/// Create an asynchronous computed signal from 7 dependencies.
FutureSignal<T> computedFrom7<T, A, B, C, D, E, F, G>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  ReadonlySignal<F> s6,
  ReadonlySignal<G> s7,
  FutureOr<T> Function(A, B, C, D, E, F, G) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value, s6.value, s7.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5, s6, s7],
    ),
  );
}

/// Create an asynchronous computed signal from 8 dependencies.
FutureSignal<T> computedFrom8<T, A, B, C, D, E, F, G, H>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  ReadonlySignal<F> s6,
  ReadonlySignal<G> s7,
  ReadonlySignal<H> s8,
  FutureOr<T> Function(A, B, C, D, E, F, G, H) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value, s6.value, s7.value, s8.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5, s6, s7, s8],
    ),
  );
}

/// Create an asynchronous computed signal from 9 dependencies.
FutureSignal<T> computedFrom9<T, A, B, C, D, E, F, G, H, I>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  ReadonlySignal<F> s6,
  ReadonlySignal<G> s7,
  ReadonlySignal<H> s8,
  ReadonlySignal<I> s9,
  FutureOr<T> Function(A, B, C, D, E, F, G, H, I) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value, s6.value, s7.value, s8.value, s9.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5, s6, s7, s8, s9],
    ),
  );
}

/// Create an asynchronous computed signal from 10 dependencies.
FutureSignal<T> computedFrom10<T, A, B, C, D, E, F, G, H, I, J>(
  ReadonlySignal<A> s1,
  ReadonlySignal<B> s2,
  ReadonlySignal<C> s3,
  ReadonlySignal<D> s4,
  ReadonlySignal<E> s5,
  ReadonlySignal<F> s6,
  ReadonlySignal<G> s7,
  ReadonlySignal<H> s8,
  ReadonlySignal<I> s9,
  ReadonlySignal<J> s10,
  FutureOr<T> Function(A, B, C, D, E, F, G, H, I, J) fn, {
  AsyncSignalOptions<T>? options,
}) {
  return FutureSignal<T>(
    () async => fn(s1.value, s2.value, s3.value, s4.value, s5.value, s6.value, s7.value, s8.value, s9.value, s10.value),
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      dependencies: [s1, s2, s3, s4, s5, s6, s7, s8, s9, s10],
    ),
  );
}

/// Extension on a 1-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt1<A> on (ReadonlySignal<A>,) {
  /// Create an asynchronous computed signal from this signal.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom1<T, A>($1, fn, options: options);
  }
}

/// Extension on a 2-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt2<A, B> on (ReadonlySignal<A>, ReadonlySignal<B>) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom2<T, A, B>($1, $2, fn, options: options);
  }
}

/// Extension on a 3-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt3<A, B, C> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom3<T, A, B, C>($1, $2, $3, fn, options: options);
  }
}

/// Extension on a 4-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt4<A, B, C, D> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom4<T, A, B, C, D>($1, $2, $3, $4, fn, options: options);
  }
}

/// Extension on a 5-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt5<A, B, C, D, E> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom5<T, A, B, C, D, E>(
      $1,
      $2,
      $3,
      $4,
      $5,
      fn,
      options: options,
    );
  }
}

/// Extension on a 6-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt6<A, B, C, D, E, F> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>,
  ReadonlySignal<F>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E, F) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom6<T, A, B, C, D, E, F>(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      fn,
      options: options,
    );
  }
}

/// Extension on a 7-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt7<A, B, C, D, E, F, G> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>,
  ReadonlySignal<F>,
  ReadonlySignal<G>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E, F, G) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom7<T, A, B, C, D, E, F, G>(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      $7,
      fn,
      options: options,
    );
  }
}

/// Extension on a 8-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt8<A, B, C, D, E, F, G, H> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>,
  ReadonlySignal<F>,
  ReadonlySignal<G>,
  ReadonlySignal<H>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E, F, G, H) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom8<T, A, B, C, D, E, F, G, H>(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      $7,
      $8,
      fn,
      options: options,
    );
  }
}

/// Extension on a 9-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt9<A, B, C, D, E, F, G, H, I> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>,
  ReadonlySignal<F>,
  ReadonlySignal<G>,
  ReadonlySignal<H>,
  ReadonlySignal<I>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E, F, G, H, I) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom9<T, A, B, C, D, E, F, G, H, I>(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      $7,
      $8,
      $9,
      fn,
      options: options,
    );
  }
}

/// Extension on a 10-tuple of [ReadonlySignal]s to create an asynchronous computed signal.
extension ComputedFromExt10<A, B, C, D, E, F, G, H, I, J> on (
  ReadonlySignal<A>,
  ReadonlySignal<B>,
  ReadonlySignal<C>,
  ReadonlySignal<D>,
  ReadonlySignal<E>,
  ReadonlySignal<F>,
  ReadonlySignal<G>,
  ReadonlySignal<H>,
  ReadonlySignal<I>,
  ReadonlySignal<J>
) {
  /// Create an asynchronous computed signal from these signals.
  FutureSignal<T> computedFrom<T>(
    FutureOr<T> Function(A, B, C, D, E, F, G, H, I, J) fn, {
    AsyncSignalOptions<T>? options,
  }) {
    return computedFrom10<T, A, B, C, D, E, F, G, H, I, J>(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      $7,
      $8,
      $9,
      $10,
      fn,
      options: options,
    );
  }
}

