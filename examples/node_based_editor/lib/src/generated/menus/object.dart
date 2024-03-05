import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/object/object_node.dart';
import '../nodes/object/optional_object_node.dart';
import '../nodes/object/object_equals_string.dart';
import '../nodes/object/object_not_null.dart';
import '../nodes/object/object_to_string.dart';
import '../nodes/object/optional_object_to_string.dart';
import '../nodes/object/optional_object_fallback.dart';
import '../nodes/object/object_is.dart';
import '../nodes/object/object_is_num.dart';
import '../nodes/object/object_is_int.dart';
import '../nodes/object/object_is_double.dart';
import '../nodes/object/object_is_map.dart';
import '../nodes/object/object_is_list.dart';
import '../nodes/object/object_is_set.dart';
import '../nodes/object/object_is_null.dart';
import '../nodes/object/object_is_not_null.dart';
import '../nodes/object/object_unwrap.dart';

MenuEntry objectMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'object',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Object Node',
            onPressed: () => onPressed(ObjectNode.defaults),
          ),
          MenuEntry(
            label: 'Optional Object Node',
            onPressed: () => onPressed(OptionalObjectNode.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'Object Equals String',
            onPressed: () => onPressed(ObjectEqualsString.defaults),
          ),
          MenuEntry(
            label: 'Object Not Null',
            onPressed: () => onPressed(ObjectNotNull.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Object To String',
            onPressed: () => onPressed(ObjectToString.defaults),
          ),
          MenuEntry(
            label: 'Optional Object To String',
            onPressed: () => onPressed(OptionalObjectToString.defaults),
          ),
          MenuEntry(
            label: 'Optional Object Fallback',
            onPressed: () => onPressed(OptionalObjectFallback.defaults),
          ),
          MenuEntry(
            label: 'Object Is',
            onPressed: () => onPressed(ObjectIs.defaults),
          ),
          MenuEntry(
            label: 'Object Is Num',
            onPressed: () => onPressed(ObjectIsNum.defaults),
          ),
          MenuEntry(
            label: 'Object Is Int',
            onPressed: () => onPressed(ObjectIsInt.defaults),
          ),
          MenuEntry(
            label: 'Object Is Double',
            onPressed: () => onPressed(ObjectIsDouble.defaults),
          ),
          MenuEntry(
            label: 'Object Is Map',
            onPressed: () => onPressed(ObjectIsMap.defaults),
          ),
          MenuEntry(
            label: 'Object Is List',
            onPressed: () => onPressed(ObjectIsList.defaults),
          ),
          MenuEntry(
            label: 'Object Is Set',
            onPressed: () => onPressed(ObjectIsSet.defaults),
          ),
          MenuEntry(
            label: 'Object Is Null',
            onPressed: () => onPressed(ObjectIsNull.defaults),
          ),
          MenuEntry(
            label: 'Object Is Not Null',
            onPressed: () => onPressed(ObjectIsNotNull.defaults),
          ),
          MenuEntry(
            label: 'Object Unwrap',
            onPressed: () => onPressed(ObjectUnwrap.defaults),
          ),
        ],
      ),
    ],
  );
}
