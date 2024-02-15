---
title: ValueNotifier
description: How is Signals different than using ValueNotifier?
---

## Signal

You may be thinking **"How is Signals different than using ValueNotifier?"** and that is a valid question when first coming to signals because at a glance they look very familiar.

```dart
// Value Notifier
final count = ValueNotifier(0);

// Signals
final count = signal(0);
```

But there is more to reactive programming than just the containers for the data. We still need to react to when the data changes which requires us to add listeners. This gets even more complicated the more we add.

```dart
class MyWidget extends ... {
final count1 = ValueNotifier(0);
final count2 = ValueNotifier(0);

// React to count 1 changing
count1.addListener(() {
    if (mounted) setState(() {});
});

// React to count 2 changing
count2.addListener(() {
    if (mounted) setState(() {});
});

@override
void dispose() {
    super.dispose();
    count1.dispose();
    count2.dispose();
}

@override
Widget build(BuildContext context) {
    // If using setState
    return Text('${count1.value} - ${count2.value}');

    // Or if you are using with ValueListenableBuilder
    return ValueListenableBuilder(
        valueListenable: count1,
        builder: (context, count1Val, child) {
            // React when count 1 changes
            return ValueListenableBuilder(
                valueListenable: count2,
                builder: (context, count2Val, child) {
                    // React when count 2 changes
                    return Text('$count1Val - $count2Val');
                },
            );
        },
    );
  }
}
```

As you can see there is a lot to keep track of mentally and you are writing more boilerplate than domain logic. 

This also only works for Flutter and not in pure dart applications since [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) is tied to the Flutter SDK.

The same example above for signals would be the following:

```dart
import 'package:signals/signals_flutter.dart';

class MyWidget extends ... {
final count1 = signal(0);
final count2 = signal(0);

@override
Widget build(BuildContext context) {
    // If using setState
    return Text('${count1.watch(context)} - ${count2.watch(context)}');

    // Or if you are using with Watch
    return Watch((context) => Text('$count1 - $count2'));
  }
}
```

Lines of code are not everything, but this dramatically reduces the boilerplate needed to achieve the same result.

## Computed

State is not just about the values updated directly but often the derived state needed for any one screen.

In the example above we had two count values, but what if we had a third that was the total result and checked if it was even or odd.

With ValueNotifier you would have to calculate that directly or create a class with ChangeNotifier and start calling notifyListeners.

```dart
class MyWidget extends ... {
final count1 = ValueNotifier(0);
final count2 = ValueNotifier(0);

// React to count 1 changing
count1.addListener(() {
    if (mounted) setState(() {});
});

// React to count 2 changing
count2.addListener(() {
    if (mounted) setState(() {});
});

int get total => count1.value + count2.value;
int get isEven => total.isEven;
int get isOdd => total.isOdd;

@override
void dispose() {
    super.dispose();
    count1.dispose();
    count2.dispose();
}

@override
Widget build(BuildContext context) {
    // If using setState
    return Text('$total even=$isEven odd=$isOdd');

    // Or if you are using with ValueListenableBuilder
    return ValueListenableBuilder(
        valueListenable: count1,
        builder: (context, count1Val, child) {
            // React when count 1 changes
            return ValueListenableBuilder(
                valueListenable: count2,
                builder: (context, count2Val, child) {
                    // React when count 2 changes
                    return Text('$total even=$isEven odd=$isOdd');
                },
            );
        },
    );
  }
}
```

This still is possible but not efficient. What we care about is the total and isEven/isOdd result, not the count values themselves. Yet we have to still need to react to them when they change to trigger each computation.

It can be easy to miss an addListener or ValueListenableBuilder if you are unaware of a dependency in the chain.

Of course you could break it out with ChangeNotifier but then you are not using ValueNotifier anymore.

```dart
class Counter extends ChangeNotifier {
    int _count1 = 0;
    int get count1 => _count1;
    set count1(int value) {
        _count1 = value;
        notifyListeners();
    }
   
    int _count2 = 0;
    int get count2 => _count2;
    set count2(int value) {
        _count2 = value;
        notifyListeners();
    }

    int get total => count1 + count2;
    int get isEven => total.isEven;
    int get isOdd => total.isOdd;
}
```

This still recalculates everything on every update. Total/isEven/isOdd are always computed regardless if the value has changed.

But how would this be possible with signals?

```dart
import 'package:signals/signals_flutter.dart';

class MyWidget extends ... {
final count1 = signal(0);
final count2 = signal(0);
final total = computed(() => count1.value + count2.value);
final isEven = computed(() => total.value.isEven);
final isOdd = computed(() => total.value.isOdd);

@override
Widget build(BuildContext context) {
    // If using setState
    return Text('${total.watch(context)} even=${isEven.watch(context)} odd=${isOdd.watch(context)}');

    // Or if you are using with Watch
    return Watch((context) {
        return Text('$total even=$isEven odd=$isOdd');
    });
  }
}
```

There some special things happening here that I want to call out.

Total/isEven/isOdd is only called when the values it depends on change. Each computed signal will store the value and cache it until dependencies change.

If the value is never read the computed callbacks are never called. That means you only calculate the state you use when you use it.

Also the UI logic does not need to care about count1/count2 and only the values you want to read. This leads to fewer mistakes and simpler code.

## Incremental Migration

If you have value notifiers you cannot update because they come from a library you can convert them to a signal.

```dart
final notifier = ValueNotifier(0);
final ValueListenable listenable = ...;

final notifierSignal = notifier.toSignal();
// Will update notifier when the value is set
notifierSignal.value = 1; // calls notifier.value = 1;

// React to changes to listenable
final listenableSignal = listenable.toSignal();
```

You can also provide a signal as a ValueListenable or ValueNotifier depending on if the signal is read-only or not.

```dart
import 'package:signals/signals_flutter.dart';

final count = signal(0);
final isEven = computed(() => count.value.isEven);

final countNotifier = count.toValueNotifier();
// Will call count.value when countNotifier is set
countNotifier.value = 1; // calls count.value = 1;

// React to changes from the host signal
final countListenable = isEven.toValueListenable();
```

These extensions will also dispose the ValueNotifier and ValueListenable when the signal is disposed.

## Outside of Flutter

Signals can be used in pure dart applications. This means you can have the same logic for server side, flutter, CLIs, html web apps and more.

```dart
import 'package:signals/signals.dart';

void main() {
    final count1 = signal(0);
    final count2 = signal(0);
    final total = computed(() => count1.value +     count2.value);
    final isEven = computed(() => total.value.isEven);
    final isOdd = computed(() => total.value.isOdd);
    
    effect(() {
        print('$total even=$isEven odd=$isOdd');
    });
}
```

_It really is that simple._

All the other signals in the package are syntax sugar for core types or helper methods to connect to Flutter specifics.
