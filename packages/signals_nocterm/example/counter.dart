import 'package:nocterm/nocterm.dart';
import 'package:signals_nocterm/signals_nocterm.dart';

void main() {
  runApp(const Counter());
}

/// A simple counter example using signals.
///
/// Press SPACE to increment the counter.
/// Press 'r' to reset the counter.
class Counter extends StatefulComponent {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> with SignalsMixin {
  // Create a signal for the count
  late final _count = createSignal(0);

  // Create a computed signal for the doubled value
  late final _doubled = createComputed(() => _count() * 2);

  // Create a computed signal for checking if even
  late final _isEven = createComputed(() => _count() % 2 == 0);

  @override
  void initState() {
    super.initState();

    // Create an effect that logs when count changes
    createEffect(() {
      print('Count changed to: ${_count()}');
    });
  }

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKey.space) {
          _count.value++;
          return true;
        }
        if (event.character == 'r') {
          _count.value = 0;
          return true;
        }
        if (event.logicalKey == LogicalKey.escape) {
          shutdownApp();
          return true;
        }
        return false;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signals + Nocterm Counter'),
            const Text(''),
            Text('Count: ${_count()}'),
            Text('Doubled: ${_doubled()}'),
            Text('Is Even: ${_isEven()}'),
            const Text(''),
            const Text('Press SPACE to increment'),
            const Text('Press R to reset'),
            const Text('Press ESC to quit'),
          ],
        ),
      ),
    );
  }
}
