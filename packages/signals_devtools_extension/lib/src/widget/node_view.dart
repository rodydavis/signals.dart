import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../nodes_state.dart';

class NodeView extends StatelessWidget {
  const NodeView({
    required this.nodeId,
    super.key,
  });

  final int nodeId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SignalBuilder(builder: (context) {
      final items = nodes.value;
      final idx = items.indexWhere((e) => e.id == nodeId);
      if (idx == -1) return const SizedBox.shrink();
      final item = items[idx];

      final isEffect = item.type == 'effect';
      final isComputed = item.type == 'computed';

      final Color accentColor =
          isEffect ? Colors.pink : (isComputed ? Colors.purple : Colors.blue);

      final String typeIcon = isEffect ? '↪️' : (isComputed ? '⚡' : '🎯');

      return Tooltip(
        message: '${item.type.toUpperCase()} (ID: ${item.id})',
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.15),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header strip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.5),
                    topRight: Radius.circular(8.5),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      typeIcon,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.label ?? '${item.type} ${item.id}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '#${item.id}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        color: theme.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.6),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              // Value Box
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    isEffect ? 'Triggered' : (item.value ?? 'undefined'),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color:
                          isEffect ? Colors.pink : theme.colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
