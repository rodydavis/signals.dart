import 'package:flutter/material.dart';
import 'package:flutter_colorband/main.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:layout/layout.dart';
import 'package:signals/signals_flutter.dart';

import 'color_scale_definition.dart';

class ColorName extends StatelessWidget {
  const ColorName({super.key});

  @override
  build(context) {
    return Watch((context) {
      final color = signals.colorNameSignal.value;
      final conf = signals.confSignal.value;

      return Semantics(
        label: 'Current color',
        value: color,
        child: Text(
          color,
          style: TextStyle(
              color: conf.color, fontWeight: FontWeight.w400, fontSize: 30),
        ),
      );

      /*
      return signals.colorNameSignal.map(
          value: (name) => Semantics(
                label: 'Current color',
                value: name,
                child: Text(
                  name ?? '-',
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w400, fontSize: 30),
                ),
              ),
          loading: () => const Icon(Icons.local_activity),
          error: (e) => const Icon(Icons.warning));

       */
    });
  }
}

class ColorNameStream extends StatelessWidget {
  const ColorNameStream({super.key});

  @override
  build(context) => Watch(
        (context) {
          return signals.colorNameSignalStream.value.map(
              data: (name) => Semantics(
                    label: 'Current color',
                    value: name,
                    child: Text(
                      name,
                      style: TextStyle(
                        // Take the value but don't register
                        color: signals.confSignal.peek().color,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                      ),
                    ),
                  ),
              loading: () => const Icon(Icons.local_activity),
              error: (e, s) => const Icon(Icons.warning));
        },
      );
}

/// Define the drive color
class ColorSelector extends StatelessWidget {
  final ColorScaleDef conf;
  final TextStyle valueStyle;

  const ColorSelector(
      {super.key, required this.conf, required this.valueStyle});

  @override
  build(context) => Watch((context) {
        final band = signals.bandSignal.value;

        return SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text('#${conf.color.code().toUpperCase()}',
                          style: valueStyle),
                      const SizedBox(width: 20),
                      const SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            // Flexible(child: ColorName()),
                            Flexible(child: ColorNameStream()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                context.breakpoint > LayoutBreakpoint.sm
                    ? Row(
                        children: [
                          _buildColorResume(band),
                          Expanded(flex: 2, child: buildColorSliders()),
                          const Expanded(flex: 3, child: SizedBox()),
                        ],
                      )
                    : Row(
                        children: [
                          _buildColorResume(band),
                          Expanded(flex: 2, child: buildColorSliders()),
                        ],
                      )
              ],
            ),
          ),
        );
      });

  Expanded _buildColorResume(ColorBand band) {
    return Expanded(
      flex: 1,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            ColoredBox(color: conf.color),
            Align(
              alignment: Alignment.topLeft,
              child: FractionallySizedBox(
                heightFactor: .5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColoredBox(color: band.first.toColor()),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FractionallySizedBox(
                heightFactor: .5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColoredBox(color: band.last.toColor()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildColorSliders() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlutterSlider(
            handlerWidth: 15,
            handlerHeight: 15,
            jump: true,
            tooltip: FlutterSliderTooltip(disabled: true),
            visibleTouchArea: false,
            trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 2,
                activeTrackBar: BoxDecoration(color: conf.color)),
            handler: FlutterSliderHandler(
                child: const SizedBox(),
                decoration: BoxDecoration(
                    color: conf.color,
                    borderRadius: const BorderRadius.all(Radius.circular(20)))),
            min: 0,
            max: 255,
            values: [conf.color.red.toDouble()],
            onDragging: (idx, left, right) => signals.confSignal.value =
                conf.copyWith(color: conf.color.withRed(left.toInt())),
          ),
          FlutterSlider(
            handlerWidth: 15,
            handlerHeight: 15,
            jump: true,
            tooltip: FlutterSliderTooltip(disabled: true),
            visibleTouchArea: false,
            trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 2,
                activeTrackBar: BoxDecoration(color: conf.color)),
            handler: FlutterSliderHandler(
                child: const SizedBox(),
                decoration: BoxDecoration(
                    color: conf.color,
                    borderRadius: const BorderRadius.all(Radius.circular(20)))),
            min: 0,
            max: 255,
            values: [conf.color.green.toDouble()],
            onDragging: (idx, left, right) => signals.confSignal.value =
                conf.copyWith(color: conf.color.withGreen(left.toInt())),
          ),
          FlutterSlider(
            handlerWidth: 15,
            handlerHeight: 15,
            jump: true,
            tooltip: FlutterSliderTooltip(disabled: true),
            visibleTouchArea: false,
            trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 2,
                activeTrackBar: BoxDecoration(color: conf.color)),
            handler: FlutterSliderHandler(
                child: const SizedBox(),
                decoration: BoxDecoration(
                    color: conf.color,
                    borderRadius: const BorderRadius.all(Radius.circular(20)))),
            min: 0,
            max: 255,
            values: [conf.color.blue.toDouble()],
            onDragging: (idx, left, right) => signals.confSignal.value =
                conf.copyWith(color: conf.color.withBlue(left.toInt())),
          ),
        ],
      );
}
