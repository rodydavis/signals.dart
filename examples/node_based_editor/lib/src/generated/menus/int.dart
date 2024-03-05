import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/int/int_node.dart';
import '../nodes/int/optional_int_node.dart';
import '../nodes/int/int_parse.dart';
import '../nodes/int/int_try_parse.dart';
import '../nodes/int/int_add.dart';
import '../nodes/int/int_subtract.dart';
import '../nodes/int/int_divide.dart';
import '../nodes/int/int_multiply.dart';
import '../nodes/int/int_modulo.dart';
import '../nodes/int/int_less_than.dart';
import '../nodes/int/int_less_than_equal.dart';
import '../nodes/int/int_greater_than.dart';
import '../nodes/int/int_greater_than_equal.dart';
import '../nodes/int/int_equal.dart';
import '../nodes/int/int_truncating_division.dart';
import '../nodes/int/int_bitwise_and.dart';
import '../nodes/int/int_bitwise_or.dart';
import '../nodes/int/int_bitwise_shift_left.dart';
import '../nodes/int/int_bitwise_shift_right.dart';
import '../nodes/int/int_bitwise_unsigned_shift_right.dart';
import '../nodes/int/int_bitwise_exclusive_or.dart';
import '../nodes/int/int_bitwise_negate.dart';
import '../nodes/int/int_negate.dart';
import '../nodes/int/int_to_num.dart';
import '../nodes/int/int_to_double.dart';
import '../nodes/int/int_is_finite.dart';
import '../nodes/int/int_is_even.dart';
import '../nodes/int/int_is_odd.dart';
import '../nodes/int/int_bit_length.dart';
import '../nodes/int/int_is_infinite.dart';
import '../nodes/int/int_is_nan.dart';
import '../nodes/int/int_is_negative.dart';
import '../nodes/int/int_sign.dart';
import '../nodes/int/int_abs.dart';
import '../nodes/int/int_ceil.dart';
import '../nodes/int/int_ceil_to_double.dart';
import '../nodes/int/int_clamp.dart';
import '../nodes/int/int_compare_to.dart';
import '../nodes/int/int_floor.dart';
import '../nodes/int/int_floor_to_double.dart';
import '../nodes/int/int_remainder.dart';
import '../nodes/int/int_round.dart';
import '../nodes/int/int_round_to_double.dart';
import '../nodes/int/int_to_string.dart';
import '../nodes/int/int_to_string_as_exponential.dart';
import '../nodes/int/int_to_string_as_fixed.dart';
import '../nodes/int/int_to_string_as_precision.dart';
import '../nodes/int/int_truncate.dart';
import '../nodes/int/int_truncate_to_double.dart';
import '../nodes/int/int_gcd.dart';
import '../nodes/int/int_mod_inverse.dart';
import '../nodes/int/int_mod_pow.dart';
import '../nodes/int/int_to_radix_string.dart';
import '../nodes/int/int_to_signed.dart';
import '../nodes/int/int_to_unsigned.dart';

MenuEntry intMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'int',
    menuChildren: [
      MenuEntry(
        label: 'Value',
        menuChildren: [
          MenuEntry(
            label: 'Int Node',
            onPressed: () => onPressed(IntNode.defaults),
          ),
          MenuEntry(
            label: 'Optional Int Node',
            onPressed: () => onPressed(OptionalIntNode.defaults),
          ),
          MenuEntry(
            label: 'Int Parse',
            onPressed: () => onPressed(IntParse.defaults),
          ),
          MenuEntry(
            label: 'Int Try Parse',
            onPressed: () => onPressed(IntTryParse.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Operator',
        menuChildren: [
          MenuEntry(
            label: 'Int Add',
            onPressed: () => onPressed(IntAdd.defaults),
          ),
          MenuEntry(
            label: 'Int Subtract',
            onPressed: () => onPressed(IntSubtract.defaults),
          ),
          MenuEntry(
            label: 'Int Divide',
            onPressed: () => onPressed(IntDivide.defaults),
          ),
          MenuEntry(
            label: 'Int Multiply',
            onPressed: () => onPressed(IntMultiply.defaults),
          ),
          MenuEntry(
            label: 'Int Modulo',
            onPressed: () => onPressed(IntModulo.defaults),
          ),
          MenuEntry(
            label: 'Int Less Than',
            onPressed: () => onPressed(IntLessThan.defaults),
          ),
          MenuEntry(
            label: 'Int Less Than Equal',
            onPressed: () => onPressed(IntLessThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Int Greater Than',
            onPressed: () => onPressed(IntGreaterThan.defaults),
          ),
          MenuEntry(
            label: 'Int Greater Than Equal',
            onPressed: () => onPressed(IntGreaterThanEqual.defaults),
          ),
          MenuEntry(
            label: 'Int Equal',
            onPressed: () => onPressed(IntEqual.defaults),
          ),
          MenuEntry(
            label: 'Int Truncating Division',
            onPressed: () => onPressed(IntTruncatingDivision.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise And',
            onPressed: () => onPressed(IntBitwiseAnd.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Or',
            onPressed: () => onPressed(IntBitwiseOr.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Shift Left',
            onPressed: () => onPressed(IntBitwiseShiftLeft.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Shift Right',
            onPressed: () => onPressed(IntBitwiseShiftRight.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Unsigned Shift Right',
            onPressed: () => onPressed(IntBitwiseUnsignedShiftRight.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Exclusive Or',
            onPressed: () => onPressed(IntBitwiseExclusiveOr.defaults),
          ),
          MenuEntry(
            label: 'Int Bitwise Negate',
            onPressed: () => onPressed(IntBitwiseNegate.defaults),
          ),
          MenuEntry(
            label: 'Int Negate',
            onPressed: () => onPressed(IntNegate.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Property',
        menuChildren: [
          MenuEntry(
            label: 'Int To Num',
            onPressed: () => onPressed(IntToNum.defaults),
          ),
          MenuEntry(
            label: 'Int To Double',
            onPressed: () => onPressed(IntToDouble.defaults),
          ),
          MenuEntry(
            label: 'Int Is Finite',
            onPressed: () => onPressed(IntIsFinite.defaults),
          ),
          MenuEntry(
            label: 'Int Is Even',
            onPressed: () => onPressed(IntIsEven.defaults),
          ),
          MenuEntry(
            label: 'Int Is Odd',
            onPressed: () => onPressed(IntIsOdd.defaults),
          ),
          MenuEntry(
            label: 'Int Bit Length',
            onPressed: () => onPressed(IntBitLength.defaults),
          ),
          MenuEntry(
            label: 'Int Is Infinite',
            onPressed: () => onPressed(IntIsInfinite.defaults),
          ),
          MenuEntry(
            label: 'Int Is Nan',
            onPressed: () => onPressed(IntIsNan.defaults),
          ),
          MenuEntry(
            label: 'Int Is Negative',
            onPressed: () => onPressed(IntIsNegative.defaults),
          ),
          MenuEntry(
            label: 'Int Sign',
            onPressed: () => onPressed(IntSign.defaults),
          ),
          MenuEntry(
            label: 'Int Abs',
            onPressed: () => onPressed(IntAbs.defaults),
          ),
          MenuEntry(
            label: 'Int Ceil',
            onPressed: () => onPressed(IntCeil.defaults),
          ),
          MenuEntry(
            label: 'Int Ceil To Double',
            onPressed: () => onPressed(IntCeilToDouble.defaults),
          ),
          MenuEntry(
            label: 'Int Clamp',
            onPressed: () => onPressed(IntClamp.defaults),
          ),
          MenuEntry(
            label: 'Int Compare To',
            onPressed: () => onPressed(IntCompareTo.defaults),
          ),
          MenuEntry(
            label: 'Int Floor',
            onPressed: () => onPressed(IntFloor.defaults),
          ),
          MenuEntry(
            label: 'Int Floor To Double',
            onPressed: () => onPressed(IntFloorToDouble.defaults),
          ),
          MenuEntry(
            label: 'Int Remainder',
            onPressed: () => onPressed(IntRemainder.defaults),
          ),
          MenuEntry(
            label: 'Int Round',
            onPressed: () => onPressed(IntRound.defaults),
          ),
          MenuEntry(
            label: 'Int Round To Double',
            onPressed: () => onPressed(IntRoundToDouble.defaults),
          ),
          MenuEntry(
            label: 'Int To String',
            onPressed: () => onPressed(IntToString.defaults),
          ),
          MenuEntry(
            label: 'Int To String As Exponential',
            onPressed: () => onPressed(IntToStringAsExponential.defaults),
          ),
          MenuEntry(
            label: 'Int To String As Fixed',
            onPressed: () => onPressed(IntToStringAsFixed.defaults),
          ),
          MenuEntry(
            label: 'Int To String As Precision',
            onPressed: () => onPressed(IntToStringAsPrecision.defaults),
          ),
          MenuEntry(
            label: 'Int Truncate',
            onPressed: () => onPressed(IntTruncate.defaults),
          ),
          MenuEntry(
            label: 'Int Truncate To Double',
            onPressed: () => onPressed(IntTruncateToDouble.defaults),
          ),
          MenuEntry(
            label: 'Int Gcd',
            onPressed: () => onPressed(IntGcd.defaults),
          ),
          MenuEntry(
            label: 'Int Mod Inverse',
            onPressed: () => onPressed(IntModInverse.defaults),
          ),
          MenuEntry(
            label: 'Int Mod Pow',
            onPressed: () => onPressed(IntModPow.defaults),
          ),
          MenuEntry(
            label: 'Int To Radix String',
            onPressed: () => onPressed(IntToRadixString.defaults),
          ),
          MenuEntry(
            label: 'Int To Signed',
            onPressed: () => onPressed(IntToSigned.defaults),
          ),
          MenuEntry(
            label: 'Int To Unsigned',
            onPressed: () => onPressed(IntToUnsigned.defaults),
          ),
        ],
      ),
    ],
  );
}
