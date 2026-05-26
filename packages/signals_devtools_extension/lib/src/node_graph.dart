import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';

class NodeGraph extends StatefulWidget {
  const NodeGraph({super.key});

  @override
  State<NodeGraph> createState() => _NodeGraphState();
}

class _NodeGraphState extends State<NodeGraph> {
  final searchQuery = signal<String>('');
  final selectedTypeFilter =
      signal<String>('All'); // All, Signal, Computed, Effect
  final selectedNodeId = signal<int?>(null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SignalBuilder(
      builder: (context) {
        final allNodes = nodes.value;
        final query = searchQuery.value.toLowerCase().trim();
        final typeFilter = selectedTypeFilter.value;
        final selectedId = selectedNodeId.value;

        // Filter nodes based on search query and type filter
        final filteredNodes = allNodes.where((n) {
          final String targetType;
          if (typeFilter == 'Signals') {
            targetType = 'signal';
          } else if (typeFilter == 'Computeds') {
            targetType = 'computed';
          } else if (typeFilter == 'Effects') {
            targetType = 'effect';
          } else {
            targetType = '';
          }
          final matchesType =
              typeFilter == 'All' || n.type.toLowerCase() == targetType;
          final matchesSearch = query.isEmpty ||
              (n.label?.toLowerCase().contains(query) ?? false) ||
              n.id.toString().contains(query) ||
              (n.value?.toLowerCase().contains(query) ?? false);
          return matchesType && matchesSearch;
        }).toList();

        // Find the selected node
        final selectedNode = allNodes.firstWhere(
          (n) => n.id == selectedId,
          orElse: () => $Node(id: -1, type: 'unknown'),
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 720;

            if (allNodes.isEmpty) {
              return _buildEmptyState(theme);
            }

            final listPane = _buildListPane(
              theme,
              allNodes,
              filteredNodes,
              selectedId,
              isDark,
            );

            final detailPane = selectedId == null || selectedNode.id == -1
                ? _buildDetailPlaceholder(theme, isDark)
                : _buildDetailPane(theme, selectedNode, allNodes, isDark);

            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: theme.colorScheme.outlineVariant
                                .withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                      ),
                      child: listPane,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: isDark
                          ? const Color(0xFF0F0F16)
                          : const Color(0xFFF9FAFC),
                      child: detailPane,
                    ),
                  ),
                ],
              );
            } else {
              // On narrow screens, show list or details
              if (selectedId != null && selectedNode.id != -1) {
                return PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) {
                    if (didPop) return;
                    selectedNodeId.value = null;
                  },
                  child: Scaffold(
                    backgroundColor: isDark
                        ? const Color(0xFF0F0F16)
                        : const Color(0xFFF9FAFC),
                    appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => selectedNodeId.value = null,
                      ),
                      title: Text(selectedNode.label ??
                          '${selectedNode.type.toUpperCase()} #${selectedNode.id}'),
                      elevation: 0,
                      backgroundColor: theme.colorScheme.surface,
                    ),
                    body: detailPane,
                  ),
                );
              }
              return listPane;
            }
          },
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primaryContainer.withOpacity(0.2),
              ),
              child: Icon(
                Icons.hub_outlined,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Reactive Explorer Ready',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Interact with your application or trigger updates to populate the signals hierarchy.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListPane(
    ThemeData theme,
    List<$Node> allNodes,
    List<$Node> filteredNodes,
    int? selectedId,
    bool isDark,
  ) {
    final signalCount = allNodes.where((n) => n.type == 'signal').length;
    final computedCount = allNodes.where((n) => n.type == 'computed').length;
    final effectCount = allNodes.where((n) => n.type == 'effect').length;

    return Column(
      children: [
        // Search & Filter header
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                onChanged: (val) => searchQuery.value = val,
                decoration: InputDecoration(
                  hintText: 'Search by label, ID, or value...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          onPressed: () {
                            searchQuery.value = '';
                          },
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', allNodes.length, theme),
                    const SizedBox(width: 8),
                    _buildFilterChip('Signals', signalCount, theme),
                    const SizedBox(width: 8),
                    _buildFilterChip('Computeds', computedCount, theme),
                    const SizedBox(width: 8),
                    _buildFilterChip('Effects', effectCount, theme),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Scrollable nodes list
        Expanded(
          child: filteredNodes.isEmpty
              ? Center(
                  child: Text(
                    'No matching nodes found',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredNodes.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final node = filteredNodes[index];
                    final isSelected = node.id == selectedId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primaryContainer
                                  .withOpacity(isDark ? 0.15 : 0.3)
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary.withOpacity(0.5)
                                : theme.colorScheme.outlineVariant
                                    .withOpacity(0.3),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            selectedNodeId.value = node.id;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                _buildTypeBadge(node.type, theme, isDark),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        node.label ??
                                            '${node.type.toUpperCase()} #${node.id}',
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        node.value != null
                                            ? 'Value: ${node.value}'
                                            : 'No value set',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontFamily: 'monospace',
                                          color: theme
                                              .colorScheme.onSurfaceVariant
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant
                                      .withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, int count, ThemeData theme) {
    final isSelected = selectedTypeFilter.value == label;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.onPrimary.withOpacity(0.2)
                  : theme.colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (val) {
        if (val) selectedTypeFilter.value = label;
      },
    );
  }

  Widget _buildDetailPlaceholder(ThemeData theme, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Dependency Inspector',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a signal or computation to trace its inputs and outputs.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailPane(
    ThemeData theme,
    $Node node,
    List<$Node> allNodes,
    bool isDark,
  ) {
    // Parse sources and targets
    final sourceIds = (node.sources?.split(',') ?? [])
        .map((e) => int.tryParse(e.trim()))
        .whereType<int>()
        .toSet();
    final targetIds = (node.targets?.split(',') ?? [])
        .map((e) => int.tryParse(e.trim()))
        .whereType<int>()
        .toSet();

    final sourceNodes =
        allNodes.where((n) => sourceIds.contains(n.id)).toList();
    final targetNodes =
        allNodes.where((n) => targetIds.contains(n.id)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Inspector Header Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withOpacity(0.4),
              ),
            ),
            child: Row(
              children: [
                _buildTypeBadge(node.type, theme, isDark),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node.label ?? '${node.type.toUpperCase()} #${node.id}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${node.id}  •  Type: ${node.type}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Raw Value Pane
          Text(
            'CURRENT VALUE',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E24) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withOpacity(0.3),
              ),
            ),
            child: Text(
              node.value ?? 'null',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Sources / Inputs
          Text(
            'DEPENDENCIES (SOURCES / INPUTS)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          if (sourceNodes.isEmpty)
            _buildEmptyStateLabel(
              'No input dependencies. This is a root source node.',
              theme,
            )
          else
            Column(
              children: sourceNodes
                  .map((n) => _buildConnectionCard(n, theme, isDark, true))
                  .toList(),
            ),
          const SizedBox(height: 24),

          // Targets / Outputs
          Text(
            'DEPENDENTS (TARGETS / CONSUMERS)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          if (targetNodes.isEmpty)
            _buildEmptyStateLabel(
              'No active consumers or dependents.',
              theme,
            )
          else
            Column(
              children: targetNodes
                  .map((n) => _buildConnectionCard(n, theme, isDark, false))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateLabel(String text, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildConnectionCard(
      $Node targetNode, ThemeData theme, bool isDark, bool isSource) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withOpacity(0.3),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            selectedNodeId.value = targetNode.id;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isSource ? Icons.arrow_back : Icons.arrow_forward,
                  size: 16,
                  color: isSource ? Colors.orange : Colors.green,
                ),
                const SizedBox(width: 12),
                _buildTypeBadge(targetNode.type, theme, isDark),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        targetNode.label ??
                            '${targetNode.type.toUpperCase()} #${targetNode.id}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Value: ${targetNode.value}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: theme.colorScheme.onSurfaceVariant
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String type, ThemeData theme, bool isDark) {
    Color bg;
    Color fg;
    IconData icon;

    switch (type.toLowerCase()) {
      case 'signal':
        bg = isDark ? const Color(0xFF2E2445) : const Color(0xFFEFE8FF);
        fg = isDark ? const Color(0xFFC5A3FF) : const Color(0xFF6B44FF);
        icon = Icons.radio_button_checked;
        break;
      case 'computed':
        bg = isDark ? const Color(0xFF453018) : const Color(0xFFFFEDD5);
        fg = isDark ? const Color(0xFFFFB668) : const Color(0xFFEA580C);
        icon = Icons.calculate_outlined;
        break;
      case 'effect':
        bg = isDark ? const Color(0xFF1D3B2C) : const Color(0xFFDCFCE7);
        fg = isDark ? const Color(0xFF7FE6B2) : const Color(0xFF15803D);
        icon = Icons.flash_on_outlined;
        break;
      default:
        bg = theme.colorScheme.surfaceVariant;
        fg = theme.colorScheme.onSurfaceVariant;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            type.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: fg,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
