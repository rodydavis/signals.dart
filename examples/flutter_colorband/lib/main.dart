import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layout/layout.dart';
import 'package:rxdart/rxdart.dart';
import 'package:signals/signals_flutter.dart';

import 'color_scale.dart';
import 'color_scale_definition.dart';

typedef ColorBand = List<HSLColor>;

class Extra {
  const Extra();
}

// Need for a Context, here's a manual way to expose Signals to app
@Extra()
class Signals {
  // Root signal
  late Signal<ColorScaleDef> confSignal;

  // bind to conf
  late Computed<ColorBand> bandSignal;

  // Can not use computed since result is Future
  // StreamSignal not practical at all
  // Maybe Rx with connect but seems overkill
  late Signal<String> colorNameSignal;

  final nameCtrl = StreamController<String>();
  late StreamSignal<String> colorNameSignalStream;

  Signals() {
    confSignal = signal(ColorScaleDef(color: const Color(0xFF2AB3C0)));

    bandSignal = computed(() {
      final conf = confSignal.value;
      final render = conf.render();

      return ColorBand.empty(growable: true)
        ..addAll(render.first)
        ..add(HSLColor.fromColor(confSignal.peek().color))
        ..addAll(render.last);
    });

    // =======================

    colorNameSignalStream =
        streamSignal(() => nameCtrl.stream.debounce((_) => TimerStream(
              true,
              const Duration(milliseconds: 100),
            )));

    colorNameSignal = signal("-");

    String memo = '-';

    // Advantage of effect over computed: they can be async
    effect(() async {
      final conf = confSignal();
      final code = conf.color.code();

      try {
        final rs = await http
            .get(Uri.parse('https://www.thecolorapi.com/id?hex=$code'));
        final name = jsonDecode(rs.body)['name']['value'];

        nameCtrl.add(name);

        if (name != memo) {
          print("sending name $name from $memo");
          memo = name;
          colorNameSignal.value = name;
        }
      } catch (_) {
        colorNameSignal.value = '!';
      }
    });
  }
}

final signals = Signals();

void main() {
  runApp(const Layout(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: ColorScale()))));
}

extension ColorExtension on Color {
  String code() => value.toRadixString(16).replaceAll('ff', '');
}
