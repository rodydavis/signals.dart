import 'dart:js_interop';

import 'package:signals/signals.dart';
import 'package:web/helpers.dart';

void main() {
  final example = Example();

  final canvas = document.querySelector('#output') as HTMLCanvasElement;

  final windowSize = signal((window.innerWidth, window.innerHeight));
  window.onresize = (Event e) {
    windowSize.value = (window.innerWidth, window.innerHeight);
  }.toJS;

  bindInputToSignal<num>(
    '#size',
    example.size,
    (el) => el.valueAsNumber,
  );
  bindInputToSignal<num>(
    '#width',
    example.width,
    (el) => el.valueAsNumber,
  );
  bindInputToSignal<JSAny>(
    '#color',
    example.color,
    (el) => el.value.toJS,
  );
  bindInputToSignal<Offset>(
    '#left',
    example.offset,
    (el) => (el.valueAsNumber, example.offset.value.$2),
  );
  bindInputToSignal<Offset>(
    '#top',
    example.offset,
    (el) => (example.offset.value.$1, el.valueAsNumber),
  );

  effect(() {
    final (width, height) = windowSize();
    canvas.width = width;
    canvas.height = height;
    return example.draw(canvas, (window.innerWidth, window.innerHeight));
  });
}

typedef Size = (num width, num height);
typedef Offset = (num dx, num dy);

class Example {
  final size = signal<num>(0);
  final width = signal<num>(0);
  final offset = signal<Offset>((0, 0));
  final color = signal<JSAny>("rgb(0 0 0)".toJS);

  Function draw(HTMLCanvasElement canvas, Size size) {
    final ctx = canvas.context2D;
    final (width, height) = size;
    ctx.clearRect(0, 0, width, height);

    drawRect(ctx);

    return () {
      // Optional clean up
    };
  }

  void drawRect(CanvasRenderingContext2D ctx) {
    ctx.save();
    ctx.lineWidth = width();
    ctx.strokeStyle = color();
    final (dx, dy) = offset();
    ctx.strokeRect(dx, dy, size(), size());
    ctx.restore();
  }
}

void bindInputToSignal<T>(
  String selector,
  Signal<T> target,
  T Function(HTMLInputElement) convert,
) {
  final el = document.querySelector(selector) as HTMLInputElement;
  el.oninput = (Event e) {
    target.value = convert(el);
  }.toJS;
  target.value = convert(el);
}
