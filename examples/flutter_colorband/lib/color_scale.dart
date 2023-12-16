import 'package:flutter/material.dart';
import 'package:flutter_colorband/main.dart';
import 'package:layout/layout.dart';
import 'package:signals/signals_flutter.dart';

import 'color_scale_band.dart';
import 'color_scale_selector.dart';
import 'color_scale_settings.dart';

const baseInputDecoration = InputDecoration(
    counterText: '',
    suffixStyle: TextStyle(fontSize: 35),
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    hintStyle: TextStyle(fontSize: 15));

class ColorScale extends StatelessWidget {
  const ColorScale({super.key});

  @override
  build(context) {
    return Watch((context) {
      final conf = signals.confSignal.value;

      final configValueStyle = TextStyle(
          fontSize: context.breakpoint > LayoutBreakpoint.sm ? 50 : 35,
          fontWeight: FontWeight.w300,
          color: conf.color);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: ColorSelector(valueStyle: configValueStyle, conf: conf)),
          const Expanded(flex: 2, child: ColorBandDisplay()),
          Expanded(
              flex: 5,
              child: ColorSettings(conf: conf, valueStyle: configValueStyle)),
        ],
      );
    });
  }
}
