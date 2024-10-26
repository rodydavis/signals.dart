// A linked list node used to track dependencies (sources) and dependents (targets).
// Also used to remember the source's last version number that the target saw.
import 'package:meta/meta.dart';

import 'listenable.dart';
import 'readonly.dart';

@internal
class Node {
  // A source whose value the target depends on.
  @internal
  late ReadonlySignal source;

  @internal
  Node? prevSource;

  @internal
  Node? nextSource;

  // A target that depends on the source and should be notified when the source changes.
  @internal
  late Listenable target;

  @internal
  Node? prevTarget;

  @internal
  Node? nextTarget;

  // The version number of the source that target has last seen. We use version numbers
  // instead of storing the source value, because source values can take arbitrary amount
  // of memory, and computeds could hang on to them forever because they're lazily evaluated.
  // Use the special value -1 to mark potentially unused but recyclable nodes.
  @internal
  late int version;

  // Used to remember & roll back the source's previous `._node` value when entering &
  // exiting a new evaluation context.
  @internal
  Node? rollbackNode;
}
