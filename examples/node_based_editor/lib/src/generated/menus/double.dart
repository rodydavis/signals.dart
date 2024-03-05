import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/double/double_node.dart';
import '../nodes/double/optional_double_node.dart';
import '../nodes/double/double_parse.dart';
import '../nodes/double/double_try_parse.dart';
import '../nodes/double/double_infinity.dart';
import '../nodes/double/double_max_finite.dart';
import '../nodes/double/double_min_positive.dart';
import '../nodes/double/double_nan.dart';
import '../nodes/double/double_negative_infinity.dart';
import '../nodes/double/double_add.dart';
import '../nodes/double/double_subtract.dart';
import '../nodes/double/double_divide.dart';
import '../nodes/double/double_multiply.dart';
import '../nodes/double/double_modulo.dart';
import '../nodes/double/double_less_than.dart';
import '../nodes/double/double_less_than_equal.dart';
import '../nodes/double/double_greater_than.dart';
import '../nodes/double/double_greater_than_equal.dart';
import '../nodes/double/double_equal.dart';
import '../nodes/double/double_truncating_division.dart';
import '../nodes/double/double_negate.dart';
import '../nodes/double/double_to_num.dart';
import '../nodes/double/double_is_finite.dart';
import '../nodes/double/double_is_infinite.dart';
import '../nodes/double/double_is_nan.dart';
import '../nodes/double/double_is_negative.dart';
import '../nodes/double/double_sign.dart';
import '../nodes/double/double_abs.dart';
import '../nodes/double/double_ceil.dart';
import '../nodes/double/double_ceil_to_double.dart';
import '../nodes/double/double_clamp.dart';
import '../nodes/double/double_compare_to.dart';
import '../nodes/double/double_floor.dart';
import '../nodes/double/double_floor_to_double.dart';
import '../nodes/double/double_remainder.dart';
import '../nodes/double/double_round.dart';
import '../nodes/double/double_round_to_double.dart';
import '../nodes/double/double_to_double.dart';
import '../nodes/double/double_to_int.dart';
import '../nodes/double/double_to_string.dart';
import '../nodes/double/double_to_string_as_exponential.dart';
import '../nodes/double/double_to_string_as_fixed.dart';
import '../nodes/double/double_to_string_as_precision.dart';
import '../nodes/double/double_truncate.dart';
import '../nodes/double/double_truncate_to_double.dart';

MenuEntry doubleMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'double',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Double Node',
            onPressed: () => onPressed(DoubleNode.defaults),
          ),
          MenuEntry(
            label: 'Optional Double Node',
            onPressed: () => onPressed(OptionalDoubleNode.defaults),
          ),
          MenuEntry(
            label: 'Double Parse',
            onPressed: () => onPressed(DoubleParse.defaults),
          ),
          MenuEntry(
            label: 'Double Try Parse',
            onPressed: () => onPressed(DoubleTryParse.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Static',
        menuChildren: [
          MenuEntry(
            label: 'Double Infinity',
            onPressed: () => onPressed(DoubleInfinity.defaults),
          ),
          MenuEntry(
            label: 'Double Max Finite',
            onPressed: () => onPressed(DoubleMaxFinite.defaults),
          ),
          MenuEntry(
            label: 'Double Min Positive',
            onPressed: () => onPressed(DoubleMinPositive.defaults),
          ),
          MenuEntry(
            label: 'Double Nan',
            onPressed: () => onPressed(DoubleNan.defaults),
          ),
          MenuEntry(
            label: 'Double Negative Infinity',
            onPressed: () => onPressed(DoubleNegativeInfinity.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'Double Add',
            onPressed: () => onPressed(DoubleAdd.defaults),
          ),
          MenuEntry(
            label: 'Double Subtract',
            onPressed: () => onPressed(DoubleSubtract.defaults),
          ),
          MenuEntry(
            label: 'Double Divide',
            onPressed: () => onPressed(DoubleDivide.defaults),
          ),
          MenuEntry(
            label: 'Double Multiply',
            onPressed: () => onPressed(DoubleMultiply.defaults),
          ),
          MenuEntry(
            label: 'Double Modulo',
            onPressed: () => onPressed(DoubleModulo.defaults),
          ),
          MenuEntry(
            label: 'Double Less Than',
            onPressed: () => onPressed(DoubleLessThan.defaults),
          ),
          MenuEntry(
            label: 'Double Less Than Equal',
            onPressed: () => onPressed(DoubleLessThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Double Greater Than',
            onPressed: () => onPressed(DoubleGreaterThan.defaults),
          ),
          MenuEntry(
            label: 'Double Greater Than Equal',
            onPressed: () => onPressed(DoubleGreaterThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Double Equal',
            onPressed: () => onPressed(DoubleEqual.defaults),
          ),
          MenuEntry(
            label: 'Double Truncating Division',
            onPressed: () => onPressed(DoubleTruncatingDivision.defaults),
          ),
          MenuEntry(
            label: 'Double Negate',
            onPressed: () => onPressed(DoubleNegate.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Double To Num',
            onPressed: () => onPressed(DoubleToNum.defaults),
          ),
          MenuEntry(
            label: 'Double Is Finite',
            onPressed: () => onPressed(DoubleIsFinite.defaults),
          ),
          MenuEntry(
            label: 'Double Is Infinite',
            onPressed: () => onPressed(DoubleIsInfinite.defaults),
          ),
          MenuEntry(
            label: 'Double Is Nan',
            onPressed: () => onPressed(DoubleIsNan.defaults),
          ),
          MenuEntry(
            label: 'Double Is Negative',
            onPressed: () => onPressed(DoubleIsNegative.defaults),
          ),
          MenuEntry(
            label: 'Double Sign',
            onPressed: () => onPressed(DoubleSign.defaults),
          ),
          MenuEntry(
            label: 'Double Abs',
            onPressed: () => onPressed(DoubleAbs.defaults),
          ),
          MenuEntry(
            label: 'Double Ceil',
            onPressed: () => onPressed(DoubleCeil.defaults),
          ),
          MenuEntry(
            label: 'Double Ceil To Double',
            onPressed: () => onPressed(DoubleCeilToDouble.defaults),
          ),
          MenuEntry(
            label: 'Double Clamp',
            onPressed: () => onPressed(DoubleClamp.defaults),
          ),
          MenuEntry(
            label: 'Double Compare To',
            onPressed: () => onPressed(DoubleCompareTo.defaults),
          ),
          MenuEntry(
            label: 'Double Floor',
            onPressed: () => onPressed(DoubleFloor.defaults),
          ),
          MenuEntry(
            label: 'Double Floor To Double',
            onPressed: () => onPressed(DoubleFloorToDouble.defaults),
          ),
          MenuEntry(
            label: 'Double Remainder',
            onPressed: () => onPressed(DoubleRemainder.defaults),
          ),
          MenuEntry(
            label: 'Double Round',
            onPressed: () => onPressed(DoubleRound.defaults),
          ),
          MenuEntry(
            label: 'Double Round To Double',
            onPressed: () => onPressed(DoubleRoundToDouble.defaults),
          ),
          MenuEntry(
            label: 'Double To Double',
            onPressed: () => onPressed(DoubleToDouble.defaults),
          ),
          MenuEntry(
            label: 'Double To Int',
            onPressed: () => onPressed(DoubleToInt.defaults),
          ),
          MenuEntry(
            label: 'Double To String',
            onPressed: () => onPressed(DoubleToString.defaults),
          ),
          MenuEntry(
            label: 'Double To String As Exponential',
            onPressed: () => onPressed(DoubleToStringAsExponential.defaults),
          ),
          MenuEntry(
            label: 'Double To String As Fixed',
            onPressed: () => onPressed(DoubleToStringAsFixed.defaults),
          ),
          MenuEntry(
            label: 'Double To String As Precision',
            onPressed: () => onPressed(DoubleToStringAsPrecision.defaults),
          ),
          MenuEntry(
            label: 'Double Truncate',
            onPressed: () => onPressed(DoubleTruncate.defaults),
          ),
          MenuEntry(
            label: 'Double Truncate To Double',
            onPressed: () => onPressed(DoubleTruncateToDouble.defaults),
          ),
        ],
      ),
    ],
  );
}
