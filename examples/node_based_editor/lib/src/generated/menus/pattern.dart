import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/pattern/pattern_all_matches.dart';
import '../nodes/pattern/pattern_match_as_prefix.dart';

MenuEntry patternMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'pattern',
    menuChildren: [
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Pattern All Matches',
            onPressed: () => onPressed(PatternAllMatches.defaults),
          ),
          MenuEntry(
            label: 'Pattern Match As Prefix',
            onPressed: () => onPressed(PatternMatchAsPrefix.defaults),
          ),
        ],
      ),
    ],
  );
}
