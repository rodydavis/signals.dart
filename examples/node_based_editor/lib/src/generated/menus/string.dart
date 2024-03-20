import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/string/string_node.dart';
import '../nodes/string/optional_string_node.dart';
import '../nodes/string/string_multiply.dart';
import '../nodes/string/string_add.dart';
import '../nodes/string/string_equals.dart';
import '../nodes/string/string_index.dart';
import '../nodes/string/string_code_units.dart';
import '../nodes/string/string_to_pattern.dart';
import '../nodes/string/string_is_empty.dart';
import '../nodes/string/string_is_not_empty.dart';
import '../nodes/string/string_length.dart';
import '../nodes/string/string_code_unit_at.dart';
import '../nodes/string/string_compare_to.dart';
import '../nodes/string/string_contains.dart';
import '../nodes/string/string_ends_with.dart';
import '../nodes/string/string_starts_with.dart';
import '../nodes/string/string_index_of.dart';
import '../nodes/string/string_last_index_of.dart';
import '../nodes/string/string_pad_left.dart';
import '../nodes/string/string_pad_right.dart';
import '../nodes/string/string_replace_all.dart';
import '../nodes/string/string_replace_first.dart';
import '../nodes/string/string_replace_range.dart';
import '../nodes/string/string_split.dart';
import '../nodes/string/string_substring.dart';
import '../nodes/string/string_to_lower_case.dart';
import '../nodes/string/string_to_upper_case.dart';
import '../nodes/string/string_trim.dart';
import '../nodes/string/string_trim_left.dart';
import '../nodes/string/string_trim_right.dart';

MenuEntry stringMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'string',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'String Node',
            onPressed: () => onPressed(StringNode.defaults),
          ),
          MenuEntry(
            label: 'Optional String Node',
            onPressed: () => onPressed(OptionalStringNode.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'String Multiply',
            onPressed: () => onPressed(StringMultiply.defaults),
          ),
          MenuEntry(
            label: 'String Add',
            onPressed: () => onPressed(StringAdd.defaults),
          ),
          MenuEntry(
            label: 'String Equals',
            onPressed: () => onPressed(StringEquals.defaults),
          ),
          MenuEntry(
            label: 'String Index',
            onPressed: () => onPressed(StringIndex.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'String Code Units',
            onPressed: () => onPressed(StringCodeUnits.defaults),
          ),
          MenuEntry(
            label: 'String To Pattern',
            onPressed: () => onPressed(StringToPattern.defaults),
          ),
          MenuEntry(
            label: 'String Is Empty',
            onPressed: () => onPressed(StringIsEmpty.defaults),
          ),
          MenuEntry(
            label: 'String Is Not Empty',
            onPressed: () => onPressed(StringIsNotEmpty.defaults),
          ),
          MenuEntry(
            label: 'String Length',
            onPressed: () => onPressed(StringLength.defaults),
          ),
          MenuEntry(
            label: 'String Code Unit At',
            onPressed: () => onPressed(StringCodeUnitAt.defaults),
          ),
          MenuEntry(
            label: 'String Compare To',
            onPressed: () => onPressed(StringCompareTo.defaults),
          ),
          MenuEntry(
            label: 'String Contains',
            onPressed: () => onPressed(StringContains.defaults),
          ),
          MenuEntry(
            label: 'String Ends With',
            onPressed: () => onPressed(StringEndsWith.defaults),
          ),
          MenuEntry(
            label: 'String Starts With',
            onPressed: () => onPressed(StringStartsWith.defaults),
          ),
          MenuEntry(
            label: 'String Index Of',
            onPressed: () => onPressed(StringIndexOf.defaults),
          ),
          MenuEntry(
            label: 'String Last Index Of',
            onPressed: () => onPressed(StringLastIndexOf.defaults),
          ),
          MenuEntry(
            label: 'String Pad Left',
            onPressed: () => onPressed(StringPadLeft.defaults),
          ),
          MenuEntry(
            label: 'String Pad Right',
            onPressed: () => onPressed(StringPadRight.defaults),
          ),
          MenuEntry(
            label: 'String Replace All',
            onPressed: () => onPressed(StringReplaceAll.defaults),
          ),
          MenuEntry(
            label: 'String Replace First',
            onPressed: () => onPressed(StringReplaceFirst.defaults),
          ),
          MenuEntry(
            label: 'String Replace Range',
            onPressed: () => onPressed(StringReplaceRange.defaults),
          ),
          MenuEntry(
            label: 'String Split',
            onPressed: () => onPressed(StringSplit.defaults),
          ),
          MenuEntry(
            label: 'String Substring',
            onPressed: () => onPressed(StringSubstring.defaults),
          ),
          MenuEntry(
            label: 'String To Lower Case',
            onPressed: () => onPressed(StringToLowerCase.defaults),
          ),
          MenuEntry(
            label: 'String To Upper Case',
            onPressed: () => onPressed(StringToUpperCase.defaults),
          ),
          MenuEntry(
            label: 'String Trim',
            onPressed: () => onPressed(StringTrim.defaults),
          ),
          MenuEntry(
            label: 'String Trim Left',
            onPressed: () => onPressed(StringTrimLeft.defaults),
          ),
          MenuEntry(
            label: 'String Trim Right',
            onPressed: () => onPressed(StringTrimRight.defaults),
          ),
        ],
      ),
    ],
  );
}
