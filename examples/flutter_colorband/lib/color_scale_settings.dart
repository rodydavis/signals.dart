import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:layout/layout.dart';

import 'color_scale.dart';
import 'color_scale_definition.dart';
import 'main.dart';

/// Define Lightness & Darkness details
class ColorSettings extends StatelessWidget {
  final ColorScaleDef conf;
  final TextStyle valueStyle;

  static const activeColor = Color(0xff414548);
  static const inactiveColor = Color(0x773d3d40);

  const ColorSettings(
      {required this.conf, required this.valueStyle, super.key});

  @override
  build(context) {
    final largeLayout = context.breakpoint > LayoutBreakpoint.sm;
    final suffixStyle = baseInputDecoration.suffixStyle
        ?.copyWith(color: conf.color, fontSize: largeLayout ? 40 : 20);

    final content = <Widget>[
      Expanded(flex: 1, child: configureDarkColors(suffixStyle)),
      VerticalDivider(indent: 24, endIndent: 24, color: conf.color),
      Expanded(flex: 1, child: configureLightColors(suffixStyle)),
    ];

    return context.breakpoint > LayoutBreakpoint.sm
        ? Row(children: content)
        : Column(children: content);
  }

  // Darkness Row Layout for each setting
  Widget configureDarkColors(TextStyle? suffixStyle) {
    final darknessCtrl = TextEditingController(text: '${conf.darkness}');
    final darkHueAngleCtrl =
        TextEditingController(text: '${conf.darkHueAngle}');
    final darknessSaturationCtrl =
        TextEditingController(text: '${conf.darkSaturation}');

    return Row(
      children: <Widget>[
        layoutSetting(
            'Dark colors\namount',
            TextFormField(
              maxLines: 1,
              initialValue: "${conf.darkColorsCount}",
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration,
              maxLength: 2,
              onChanged: (v) => signals.confSignal.value = signals
                  .confSignal.value
                  .copyWith(darkColorsCount: int.parse(v)),
            ),
            null),
        layoutSetting(
            'Darkness\n',
            TextFormField(
              controller: darknessCtrl,
              maxLines: 1,
              //toolbarOptions: const ToolbarOptions(),
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '%', suffixStyle: suffixStyle),
              maxLength: 2,
              onChanged: (v) {
                signals.confSignal.value =
                    signals.confSignal.value.copyWith(darkness: int.parse(v));
              },
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: 0,
              max: 100,
              values: [conf.darkness.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(darkness: low.toInt()),
            )),
        layoutSetting(
            'Dark colors\nhue angle',
            TextFormField(
              maxLines: 1,
              controller: darkHueAngleCtrl,
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '°', suffixStyle: suffixStyle),
              maxLength: 3,
              onChanged: (v) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(darkHueAngle: int.parse(v)),
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: -360,
              max: 360,
              values: [conf.darkHueAngle.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(darkHueAngle: low.toInt()),
            )),
        layoutSetting(
            'Dark colors\nsaturation',
            TextFormField(
              maxLines: 1,
              controller: darknessSaturationCtrl,
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '%', suffixStyle: suffixStyle),
              maxLength: 3,
              onChanged: (v) => signals.confSignal.value = signals
                  .confSignal.value
                  .copyWith(darkSaturation: int.parse(v)),
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: -360,
              max: 360,
              values: [conf.darkSaturation.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value
                      .copyWith(darkSaturation: low.toInt()),
            )),
      ],
    );
  }

  // Lightness Row Layout for each setting
  Widget configureLightColors(TextStyle? suffixStyle) {
    final lightnessCtrl = TextEditingController(text: '${conf.lightness}');
    final lightHueAngleCtrl =
        TextEditingController(text: '${conf.lightHueAngle}');
    final lightSaturationCtrl =
        TextEditingController(text: '${conf.lightSaturation}');

    return Row(
      children: <Widget>[
        // Light Count
        layoutSetting(
            'Light colors\namount',
            TextFormField(
              maxLines: 1,
              initialValue: "${conf.lightColorsCount}",
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(),
              maxLength: 2,
              onChanged: (v) => signals.confSignal.value = signals
                  .confSignal.value
                  .copyWith(lightColorsCount: int.parse(v)),
            ),
            null),
        layoutSetting(
            'Lightness\n',
            TextFormField(
              maxLines: 1,
              controller: lightnessCtrl,
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '%', suffixStyle: suffixStyle),
              maxLength: 3,
              onChanged: (v) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(lightness: int.parse(v)),
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: 0,
              max: 100,
              values: [conf.lightness.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(lightness: low.toInt()),
            )),
        layoutSetting(
            'Light colors\nhue angle',
            TextFormField(
              maxLines: 1,
              controller: lightHueAngleCtrl,
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '°', suffixStyle: suffixStyle),
              maxLength: 3,
              onChanged: (v) => signals.confSignal.value = signals
                  .confSignal.value
                  .copyWith(lightHueAngle: int.parse(v)),
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: -360,
              max: 360,
              values: [conf.lightHueAngle.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value.copyWith(lightHueAngle: low.toInt()),
            )),
        layoutSetting(
            'Light colors\nsaturation',
            TextFormField(
              maxLines: 1,
              controller: lightSaturationCtrl,
              cursorColor: conf.color,
              style: valueStyle,
              textAlign: TextAlign.center,
              cursorWidth: 4,
              decoration: baseInputDecoration.copyWith(
                  suffixText: '%', suffixStyle: suffixStyle),
              maxLength: 3,
              onChanged: (v) => signals.confSignal.value = signals
                  .confSignal.value
                  .copyWith(lightSaturation: int.parse(v)),
            ),
            FlutterSlider(
              jump: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              handlerWidth: 15,
              handlerHeight: 15,
              visibleTouchArea: false,
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 2,
                  activeTrackBar: BoxDecoration(color: conf.color)),
              handler: FlutterSliderHandler(
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      color: conf.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)))),
              min: -360,
              max: 360,
              values: [conf.lightSaturation.toDouble()],
              onDragging: (update, low, high) => signals.confSignal.value =
                  signals.confSignal.value
                      .copyWith(lightSaturation: low.toInt()),
            )),
      ],
    );
  }

  // Setting Column Layout
  Widget layoutSetting(String title, Widget value, Widget? slider) => Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: conf.color,
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: value),
              slider ?? const SizedBox(),
            ],
          ),
        ),
      );
}
