import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/regex/regex_node.dart';
import '../nodes/regex/regex_escape.dart';
import '../nodes/regex/regex_to_pattern.dart';
import '../nodes/regex/regex_all_matches.dart';
import '../nodes/regex/regex_first_match.dart';
import '../nodes/regex/regex_has_match.dart';
import '../nodes/regex/regex_string_match.dart';

MenuEntry regexMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'regex',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Regex Node',
            onPressed: () => onPressed(RegexNode.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Static',
        menuChildren: [
          MenuEntry(
            label: 'Regex Escape',
            onPressed: () => onPressed(RegexEscape.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Regex To Pattern',
            onPressed: () => onPressed(RegexToPattern.defaults),
          ),
          MenuEntry(
            label: 'Regex All Matches',
            onPressed: () => onPressed(RegexAllMatches.defaults),
          ),
          MenuEntry(
            label: 'Regex First Match',
            onPressed: () => onPressed(RegexFirstMatch.defaults),
          ),
          MenuEntry(
            label: 'Regex Has Match',
            onPressed: () => onPressed(RegexHasMatch.defaults),
          ),
          MenuEntry(
            label: 'Regex String Match',
            onPressed: () => onPressed(RegexStringMatch.defaults),
          ),
        ],
      ),
    ],
  );
}
