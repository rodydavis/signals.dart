import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/num/num_node.dart';
import '../nodes/num/optional_num_node.dart';
import '../nodes/num/num_parse.dart';
import '../nodes/num/num_try_parse.dart';
import '../nodes/num/num_add.dart';
import '../nodes/num/num_subtract.dart';
import '../nodes/num/num_divide.dart';
import '../nodes/num/num_multiply.dart';
import '../nodes/num/num_modulo.dart';
import '../nodes/num/num_less_than.dart';
import '../nodes/num/num_less_than_equal.dart';
import '../nodes/num/num_greater_than.dart';
import '../nodes/num/num_greater_than_equal.dart';
import '../nodes/num/num_equal.dart';
import '../nodes/num/num_truncating_division.dart';
import '../nodes/num/num_negate.dart';
import '../nodes/num/num_is_finite.dart';
import '../nodes/num/num_is_infinite.dart';
import '../nodes/num/num_is_nan.dart';
import '../nodes/num/num_is_negative.dart';
import '../nodes/num/num_sign.dart';
import '../nodes/num/num_abs.dart';
import '../nodes/num/num_ceil.dart';
import '../nodes/num/num_ceil_to_double.dart';
import '../nodes/num/num_clamp.dart';
import '../nodes/num/num_compare_to.dart';
import '../nodes/num/num_floor.dart';
import '../nodes/num/num_floor_to_double.dart';
import '../nodes/num/num_remainder.dart';
import '../nodes/num/num_round.dart';
import '../nodes/num/num_round_to_double.dart';
import '../nodes/num/num_to_double.dart';
import '../nodes/num/num_to_int.dart';
import '../nodes/num/num_to_string.dart';
import '../nodes/num/num_to_string_as_exponential.dart';
import '../nodes/num/num_to_string_as_fixed.dart';
import '../nodes/num/num_to_string_as_precision.dart';
import '../nodes/num/num_truncate.dart';
import '../nodes/num/num_truncate_to_double.dart';

MenuEntry numMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'num',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Num Node',
            onPressed: () => onPressed(NumNode.defaults),
          ),
          MenuEntry(
            label: 'Optional Num Node',
            onPressed: () => onPressed(OptionalNumNode.defaults),
          ),
          MenuEntry(
            label: 'Num Parse',
            onPressed: () => onPressed(NumParse.defaults),
          ),
          MenuEntry(
            label: 'Num Try Parse',
            onPressed: () => onPressed(NumTryParse.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'Num Add',
            onPressed: () => onPressed(NumAdd.defaults),
          ),
          MenuEntry(
            label: 'Num Subtract',
            onPressed: () => onPressed(NumSubtract.defaults),
          ),
          MenuEntry(
            label: 'Num Divide',
            onPressed: () => onPressed(NumDivide.defaults),
          ),
          MenuEntry(
            label: 'Num Multiply',
            onPressed: () => onPressed(NumMultiply.defaults),
          ),
          MenuEntry(
            label: 'Num Modulo',
            onPressed: () => onPressed(NumModulo.defaults),
          ),
          MenuEntry(
            label: 'Num Less Than',
            onPressed: () => onPressed(NumLessThan.defaults),
          ),
          MenuEntry(
            label: 'Num Less Than Equal',
            onPressed: () => onPressed(NumLessThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Num Greater Than',
            onPressed: () => onPressed(NumGreaterThan.defaults),
          ),
          MenuEntry(
            label: 'Num Greater Than Equal',
            onPressed: () => onPressed(NumGreaterThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Num Equal',
            onPressed: () => onPressed(NumEqual.defaults),
          ),
          MenuEntry(
            label: 'Num Truncating Division',
            onPressed: () => onPressed(NumTruncatingDivision.defaults),
          ),
          MenuEntry(
            label: 'Num Negate',
            onPressed: () => onPressed(NumNegate.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Num Is Finite',
            onPressed: () => onPressed(NumIsFinite.defaults),
          ),
          MenuEntry(
            label: 'Num Is Infinite',
            onPressed: () => onPressed(NumIsInfinite.defaults),
          ),
          MenuEntry(
            label: 'Num Is Nan',
            onPressed: () => onPressed(NumIsNan.defaults),
          ),
          MenuEntry(
            label: 'Num Is Negative',
            onPressed: () => onPressed(NumIsNegative.defaults),
          ),
          MenuEntry(
            label: 'Num Sign',
            onPressed: () => onPressed(NumSign.defaults),
          ),
          MenuEntry(
            label: 'Num Abs',
            onPressed: () => onPressed(NumAbs.defaults),
          ),
          MenuEntry(
            label: 'Num Ceil',
            onPressed: () => onPressed(NumCeil.defaults),
          ),
          MenuEntry(
            label: 'Num Ceil To Double',
            onPressed: () => onPressed(NumCeilToDouble.defaults),
          ),
          MenuEntry(
            label: 'Num Clamp',
            onPressed: () => onPressed(NumClamp.defaults),
          ),
          MenuEntry(
            label: 'Num Compare To',
            onPressed: () => onPressed(NumCompareTo.defaults),
          ),
          MenuEntry(
            label: 'Num Floor',
            onPressed: () => onPressed(NumFloor.defaults),
          ),
          MenuEntry(
            label: 'Num Floor To Double',
            onPressed: () => onPressed(NumFloorToDouble.defaults),
          ),
          MenuEntry(
            label: 'Num Remainder',
            onPressed: () => onPressed(NumRemainder.defaults),
          ),
          MenuEntry(
            label: 'Num Round',
            onPressed: () => onPressed(NumRound.defaults),
          ),
          MenuEntry(
            label: 'Num Round To Double',
            onPressed: () => onPressed(NumRoundToDouble.defaults),
          ),
          MenuEntry(
            label: 'Num To Double',
            onPressed: () => onPressed(NumToDouble.defaults),
          ),
          MenuEntry(
            label: 'Num To Int',
            onPressed: () => onPressed(NumToInt.defaults),
          ),
          MenuEntry(
            label: 'Num To String',
            onPressed: () => onPressed(NumToString.defaults),
          ),
          MenuEntry(
            label: 'Num To String As Exponential',
            onPressed: () => onPressed(NumToStringAsExponential.defaults),
          ),
          MenuEntry(
            label: 'Num To String As Fixed',
            onPressed: () => onPressed(NumToStringAsFixed.defaults),
          ),
          MenuEntry(
            label: 'Num To String As Precision',
            onPressed: () => onPressed(NumToStringAsPrecision.defaults),
          ),
          MenuEntry(
            label: 'Num Truncate',
            onPressed: () => onPressed(NumTruncate.defaults),
          ),
          MenuEntry(
            label: 'Num Truncate To Double',
            onPressed: () => onPressed(NumTruncateToDouble.defaults),
          ),
        ],
      ),
    ],
  );
}
