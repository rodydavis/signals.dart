// ignore: implementation_imports
import 'package:benchmarking/src/printer.dart';

/// Console printer for benchmark results.
class Logger implements Printer {
  const Logger(this.cb);

  final Sink<String> cb;

  void print(Object val) {
    cb.add(val.toString());
  }

  @override
  void blank() => print('');

  @override
  void plain(dynamic value) => print(Printer.autoTransform(value));

  @override
  void labeled(String label, dynamic value, {Color color = Color.none}) {
    label = '${Printer.lpad(label, 20)}: ';
    value = Printer.autoTransform(value);
    return color == Color.none
        ? print('$label$value')
        : print('$label$color$value${'\x1b[0m'}');
  }

  @override
  void colored(Color color, dynamic value) {
    value = Printer.autoTransform(value);
    return color == Color.none
        ? print(value)
        : print('$color$value${'\x1b[0m'}');
  }
}
