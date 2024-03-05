import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/bool/bool_node.dart';
import '../nodes/bool/optional_bool_node.dart';
import '../nodes/bool/bool_parse.dart';
import '../nodes/bool/bool_try_parse.dart';
import '../nodes/bool/bool_and.dart';
import '../nodes/bool/bool_equals.dart';
import '../nodes/bool/bool_exclusive_or.dart';
import '../nodes/bool/bool_inclusive_or.dart';

MenuEntry boolMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'bool',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Bool Node',
            onPressed: () => onPressed(BoolNode.defaults),
          ),
          MenuEntry(
            label: 'Optional Bool Node',
            onPressed: () => onPressed(OptionalBoolNode.defaults),
          ),
          MenuEntry(
            label: 'Bool Parse',
            onPressed: () => onPressed(BoolParse.defaults),
          ),
          MenuEntry(
            label: 'Bool Try Parse',
            onPressed: () => onPressed(BoolTryParse.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'Bool And',
            onPressed: () => onPressed(BoolAnd.defaults),
          ),
          MenuEntry(
            label: 'Bool Equals',
            onPressed: () => onPressed(BoolEquals.defaults),
          ),
          MenuEntry(
            label: 'Bool Exclusive Or',
            onPressed: () => onPressed(BoolExclusiveOr.defaults),
          ),
          MenuEntry(
            label: 'Bool Inclusive Or',
            onPressed: () => onPressed(BoolInclusiveOr.defaults),
          ),
        ],
      ),
    ],
  );
}
