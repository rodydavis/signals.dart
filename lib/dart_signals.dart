library dart_signals;

import 'dart:collection';

part 'src/listenable.dart';
part 'src/signal.dart';
part 'src/computed.dart';
part 'src/effect.dart';

_Listenable? _currentAccessed;
final _effectQueue = Queue<Effect>();
