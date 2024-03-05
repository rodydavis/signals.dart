import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

import '../nodes/math/math_e.dart';
import '../nodes/math/math_ln10.dart';
import '../nodes/math/math_ln2.dart';
import '../nodes/math/math_log10e.dart';
import '../nodes/math/math_log2e.dart';
import '../nodes/math/math_pi.dart';
import '../nodes/math/math_sqrt1_2.dart';
import '../nodes/math/math_sqrt2.dart';
import '../nodes/math/math_acos.dart';
import '../nodes/math/math_asin.dart';
import '../nodes/math/math_atan.dart';
import '../nodes/math/math_atan2.dart';
import '../nodes/math/math_cos.dart';
import '../nodes/math/math_exp.dart';
import '../nodes/math/math_log.dart';
import '../nodes/math/math_max.dart';
import '../nodes/math/math_min.dart';
import '../nodes/math/math_pow.dart';
import '../nodes/math/math_sin.dart';
import '../nodes/math/math_sqrt.dart';
import '../nodes/math/math_tan.dart';

MenuEntry mathMenus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: 'math',
    menuChildren: [
      MenuEntry(
        label: 'Static',
        menuChildren: [
          MenuEntry(
            label: 'Math E',
            onPressed: () => onPressed(MathE.defaults),
          ),
          MenuEntry(
            label: 'Math Ln10',
            onPressed: () => onPressed(MathLn10.defaults),
          ),
          MenuEntry(
            label: 'Math Ln2',
            onPressed: () => onPressed(MathLn2.defaults),
          ),
          MenuEntry(
            label: 'Math Log10e',
            onPressed: () => onPressed(MathLog10e.defaults),
          ),
          MenuEntry(
            label: 'Math Log2e',
            onPressed: () => onPressed(MathLog2e.defaults),
          ),
          MenuEntry(
            label: 'Math Pi',
            onPressed: () => onPressed(MathPi.defaults),
          ),
          MenuEntry(
            label: 'Math Sqrt1 2',
            onPressed: () => onPressed(MathSqrt12.defaults),
          ),
          MenuEntry(
            label: 'Math Sqrt2',
            onPressed: () => onPressed(MathSqrt2.defaults),
          ),
        ],
      ),
      MenuEntry(
        label: 'Math Acos',
        onPressed: () => onPressed(MathAcos.defaults),
      ),
      MenuEntry(
        label: 'Math Asin',
        onPressed: () => onPressed(MathAsin.defaults),
      ),
      MenuEntry(
        label: 'Math Atan',
        onPressed: () => onPressed(MathAtan.defaults),
      ),
      MenuEntry(
        label: 'Math Atan2',
        onPressed: () => onPressed(MathAtan2.defaults),
      ),
      MenuEntry(
        label: 'Math Cos',
        onPressed: () => onPressed(MathCos.defaults),
      ),
      MenuEntry(
        label: 'Math Exp',
        onPressed: () => onPressed(MathExp.defaults),
      ),
      MenuEntry(
        label: 'Math Log',
        onPressed: () => onPressed(MathLog.defaults),
      ),
      MenuEntry(
        label: 'Math Max',
        onPressed: () => onPressed(MathMax.defaults),
      ),
      MenuEntry(
        label: 'Math Min',
        onPressed: () => onPressed(MathMin.defaults),
      ),
      MenuEntry(
        label: 'Math Pow',
        onPressed: () => onPressed(MathPow.defaults),
      ),
      MenuEntry(
        label: 'Math Sin',
        onPressed: () => onPressed(MathSin.defaults),
      ),
      MenuEntry(
        label: 'Math Sqrt',
        onPressed: () => onPressed(MathSqrt.defaults),
      ),
      MenuEntry(
        label: 'Math Tan',
        onPressed: () => onPressed(MathTan.defaults),
      ),
    ],
  );
}
