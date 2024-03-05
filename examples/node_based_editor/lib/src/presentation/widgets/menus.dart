import 'package:flutter/material.dart';

class MenuEntry {
  const MenuEntry({
    required this.label,
    this.shortcut,
    this.onPressed,
    this.menuChildren,
  }) : assert(menuChildren == null || onPressed == null,
            'onPressed is ignored if menuChildren are provided');
  final String label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          child: Text(selection.label),
        );
      }
      return MenuItemButton(
        shortcut: selection.shortcut,
        onPressed: selection.onPressed,
        child: Text(selection.label),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(MenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] =
              VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}

class Menus extends StatefulWidget {
  const Menus({
    super.key,
    required this.entries,
    required this.child,
    this.leading,
    this.trailing,
  });

  final List<MenuEntry> entries;
  final Widget child;
  final Widget? leading, trailing;

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _shortcutsEntry?.dispose();
        final items = MenuEntry.shortcuts(
          widget.entries.where((e) => e.shortcut != null).toList(),
        );
        if (items.isNotEmpty) {
          _shortcutsEntry = ShortcutRegistry.of(context).addAll(items);
        }
      }
    });
  }

  ShortcutRegistryEntry? _shortcutsEntry;

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Menus oldWidget) {
    if (oldWidget.entries != widget.entries) {
      if (mounted) setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.leading != null) widget.leading!,
              Expanded(
                child: MenuBar(
                  style: MenuStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.surface),
                    elevation: const MaterialStatePropertyAll(0),
                  ),
                  children: MenuEntry.build(widget.entries),
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
        Expanded(
          child: ClipRect(
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
