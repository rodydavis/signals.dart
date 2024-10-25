part of 'signals.dart';

@internal
abstract class Listenable {
  @internal
  Node? sources;

  @internal
  int get flags;

  /// Global ID of the signal
  int get globalId;

  @internal
  void notify();
}

@internal
bool needsToRecompute(Listenable target) {
  // Check the dependencies for changed values. The dependency list is already
  // in order of use. Therefore if multiple dependencies have changed values, only
  // the first used dependency is re-evaluated at this point.
  for (var node = target.sources; node != null; node = node.nextSource) {
    // If there's a new version of the dependency before or after refreshing,
    // or the dependency has something blocking it from refreshing at all (e.g. a
    // dependency cycle), then we need to recompute.
    if (node.source.version != node.version ||
        !node.source.refresh() ||
        node.source.version != node.version) {
      return true;
    }
  }
  // If none of the dependencies have changed values since last recompute then
  // there's no need to recompute.
  return false;
}

@internal
void prepareSources(Listenable target) {
  /**
	 * 1. Mark all current sources as re-usable nodes (version: -1)
	 * 2. Set a rollback node if the current node is being used in a different context
	 * 3. Point 'target._sources' to the tail of the doubly-linked list, e.g:
	 *
	 *    { undefined <- A <-> B <-> C -> undefined }
	 *                   ↑           ↑
	 *                   │           └──────┐
	 * target._sources = A; (node is head)  │
	 *                   ↓                  │
	 * target._sources = C; (node is tail) ─┘
	 */
  for (var node = target.sources; node != null; node = node.nextSource) {
    final rollbackNode = node.source.node;
    if (rollbackNode != null) {
      node.rollbackNode = rollbackNode;
    }
    node.source.node = node;
    node.version = -1;

    if (node.nextSource == null) {
      target.sources = node;
      break;
    }
  }
}

@internal
void cleanupSources(Listenable target) {
  var node = target.sources;
  Node? head;

  /**
	 * At this point 'target._sources' points to the tail of the doubly-linked list.
	 * It contains all existing sources + new sources in order of use.
	 * Iterate backwards until we find the head node while dropping old dependencies.
	 */
  while (node != null) {
    final prev = node.prevSource;

    /**
		 * The node was not re-used, unsubscribe from its change notifications and remove itself
		 * from the doubly-linked list. e.g:
		 *
		 * { A <-> B <-> C }
		 *         ↓
		 *    { A <-> C }
		 */
    if (node.version == -1) {
      node.source.unsubscribeFromNode(node);

      if (prev != null) {
        prev.nextSource = node.nextSource;
      }
      if (node.nextSource != null) {
        node.nextSource!.prevSource = prev;
      }
    } else {
      /**
			 * The new head is the last node seen which wasn't removed/unsubscribed
			 * from the doubly-linked list. e.g:
			 *
			 * { A <-> B <-> C }
			 *   ↑     ↑     ↑
			 *   │     │     └ head = node
			 *   │     └ head = node
			 *   └ head = node
			 */
      head = node;
    }

    node.source.node = node.rollbackNode;
    if (node.rollbackNode != null) {
      node.rollbackNode = null;
    }

    node = prev;
  }

  target.sources = head;
}
