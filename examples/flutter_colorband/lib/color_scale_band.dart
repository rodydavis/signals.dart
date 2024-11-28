import 'package:flutter/material.dart';
import 'package:flutter_colorband/main.dart';
import 'package:layout/layout.dart';
import 'package:signals/signals_flutter.dart';

/// Display the band of colors
class ColorBandDisplay extends StatelessWidget {
  const ColorBandDisplay({super.key});

  @override
  build(context) {
    return Watch((builder) {
      final conf = signals.confSignal.value;
      final band = signals.bandSignal.value;

      return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
          child: context.breakpoint > LayoutBreakpoint.sm
              ? LayoutBuilder(builder: (ctx, cns) => _renderBand(band, cns))
              : Column(
                  children: [
                    Flexible(
                        child: LayoutBuilder(
                            builder: (ctx, cns) => _renderBand(
                                band.sublist(0, conf.darkColorsCount), cns))),
                    Flexible(
                      child: LayoutBuilder(
                          builder: (ctx, cns) => _renderBand(
                              band.sublist(
                                  conf.darkColorsCount + 1, band.length),
                              cns)),
                    ),
                  ],
                ));
    });
  }

  Widget _renderBand(ColorBand band, BoxConstraints cns) => Stack(
      children: band
          .asMap()
          .map((idx, hsl) => _layoutTile(band, cns, idx, hsl))
          .values
          .toList());

  // Layout the Color Tile
  MapEntry<int, Widget> _layoutTile(
      ColorBand colorBand, BoxConstraints cns, int idx, HSLColor hsl) {
    final slideWidth = cns.maxWidth / colorBand.length;
    return MapEntry(
        idx,
        Positioned(
          left: idx * slideWidth,
          top: 0,
          height: cns.maxHeight,
          width: slideWidth + 3,
          child: SizedBox.expand(
            child: _buildColorTile(hsl),
          ),
        ));
  }

  // Transform Color -> Widget
  Widget _buildColorTile(HSLColor hsl) => Tooltip(
      showDuration: const Duration(milliseconds: 1200),
      preferBelow: true,
      decoration: BoxDecoration(
          color: Colors.black54,
          border: Border.all(color: Colors.white, width: .2)),
      message: '#${hsl.toColor().code().toUpperCase()}',
      child: ColoredBox(color: hsl.toColor()));
}
