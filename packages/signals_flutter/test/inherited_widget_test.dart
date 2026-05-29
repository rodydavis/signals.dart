import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MyTestSignal extends FlutterSignal<int> {
  MyTestSignal([super.value = 0]);

  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

class MyOtherSignal extends FlutterSignal<String> {
  MyOtherSignal([super.value = 'default']);

  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

void main() {
  group('SignalProvider Standard Lifecycle Tests', () {
    testWidgets(
      'creates signal and persists it across parent widget rebuilds',
      (WidgetTester tester) async {
        late MyTestSignal retrievedSignal1;
        late MyTestSignal retrievedSignal2;

        int rebuildCount = 0;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return MaterialApp(
                home: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: const Text('Rebuild Parent'),
                    ),
                    SignalProvider<MyTestSignal>(
                      create: () {
                        rebuildCount++;
                        return MyTestSignal(10);
                      },
                      child: Builder(
                        builder: (childContext) {
                          retrievedSignal1 =
                              SignalProvider.of<MyTestSignal>(childContext)!;
                          return Text('Value: ${retrievedSignal1.value}');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Value: 10'), findsOneWidget);
        expect(rebuildCount, equals(1));

        // Rebuild the parent widget
        await tester.tap(find.text('Rebuild Parent'));
        await tester.pumpAndSettle();

        // Get reference after rebuild
        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return MaterialApp(
                home: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: const Text('Rebuild Parent'),
                    ),
                    SignalProvider<MyTestSignal>(
                      create: () {
                        rebuildCount++;
                        return MyTestSignal(10);
                      },
                      child: Builder(
                        builder: (childContext) {
                          retrievedSignal2 =
                              SignalProvider.of<MyTestSignal>(childContext)!;
                          return Text('Value: ${retrievedSignal2.value}');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );

        await tester.pumpAndSettle();

        // Verify the signal instance was persisted (not recreated)
        expect(retrievedSignal1, same(retrievedSignal2));
        expect(rebuildCount, equals(1));
      },
    );

    testWidgets(
      'automatically disposes of created signal when unmounted',
      (WidgetTester tester) async {
        late MyTestSignal mySignal;
        bool showProvider = true;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return MaterialApp(
                home: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() {
                        showProvider = false;
                      }),
                      child: const Text('Unmount Provider'),
                    ),
                    if (showProvider)
                      SignalProvider<MyTestSignal>(
                        create: () {
                          mySignal = MyTestSignal(42);
                          return mySignal;
                        },
                        child: const Text('Exposed Subtree'),
                      ),
                  ],
                ),
              );
            },
          ),
        );

        await tester.pumpAndSettle();
        expect(mySignal.isDisposed, isFalse);

        // Unmount the provider
        await tester.tap(find.text('Unmount Provider'));
        await tester.pumpAndSettle();

        // Verify it was automatically disposed
        expect(mySignal.isDisposed, isTrue);
      },
    );

    testWidgets(
      'uses custom dispose callback if provided',
      (WidgetTester tester) async {
        late MyTestSignal mySignal;
        bool showProvider = true;
        bool customDisposeCalled = false;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return MaterialApp(
                home: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() {
                        showProvider = false;
                      }),
                      child: const Text('Unmount Provider'),
                    ),
                    if (showProvider)
                      SignalProvider<MyTestSignal>(
                        create: () {
                          mySignal = MyTestSignal(100);
                          return mySignal;
                        },
                        dispose: (sig) {
                          customDisposeCalled = true;
                          sig.dispose();
                        },
                        child: const Text('Exposed Subtree'),
                      ),
                  ],
                ),
              );
            },
          ),
        );

        await tester.pumpAndSettle();
        expect(customDisposeCalled, isFalse);

        // Unmount the provider
        await tester.tap(find.text('Unmount Provider'));
        await tester.pumpAndSettle();

        // Verify custom dispose callback was executed
        expect(customDisposeCalled, isTrue);
        expect(mySignal.isDisposed, isTrue);
      },
    );
  });

  group('SignalProvider.value Constructor Tests', () {
    testWidgets(
      'exposes existing signal and does not dispose it when unmounted',
      (WidgetTester tester) async {
        final existingSignal = MyTestSignal(200);
        bool showProvider = true;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return MaterialApp(
                home: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() {
                        showProvider = false;
                      }),
                      child: const Text('Unmount Provider'),
                    ),
                    if (showProvider)
                      SignalProvider<MyTestSignal>.value(
                        value: existingSignal,
                        child: Builder(
                          builder: (childContext) {
                            final sig =
                                SignalProvider.of<MyTestSignal>(childContext)!;
                            return Text('Value: ${sig.value}');
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Value: 200'), findsOneWidget);
        expect(existingSignal.isDisposed, isFalse);

        // Unmount the provider
        await tester.tap(find.text('Unmount Provider'));
        await tester.pumpAndSettle();

        // Verify the existing signal is still NOT disposed
        expect(existingSignal.isDisposed, isFalse);

        // Clean up the signal manually since we exposed it via .value
        existingSignal.dispose();
        expect(existingSignal.isDisposed, isTrue);
      },
    );
  });

  group('MultiSignalProvider & SignalProvider.multi Tests', () {
    testWidgets(
      'propagates multiple signals successfully down the tree',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: SignalProvider.multi(
              providers: [
                SignalProvider<MyTestSignal>(create: () => MyTestSignal(111)),
                SignalProvider<MyOtherSignal>(
                  create: () => MyOtherSignal('hello'),
                ),
              ],
              child: Builder(
                builder: (childContext) {
                  final sig1 = SignalProvider.of<MyTestSignal>(childContext)!;
                  final sig2 = SignalProvider.of<MyOtherSignal>(childContext)!;
                  return Text('sig1: ${sig1.value}, sig2: ${sig2.value}');
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('sig1: 111, sig2: hello'), findsOneWidget);
      },
    );

    testWidgets(
      'MultiSignalProvider class propagates multiple signals successfully down the tree',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MultiSignalProvider(
              providers: [
                SignalProvider<MyTestSignal>(create: () => MyTestSignal(222)),
                SignalProvider<MyOtherSignal>(
                  create: () => MyOtherSignal('world'),
                ),
              ],
              child: Builder(
                builder: (childContext) {
                  final sig1 = SignalProvider.of<MyTestSignal>(childContext)!;
                  final sig2 = SignalProvider.of<MyOtherSignal>(childContext)!;
                  return Text('sig1: ${sig2.value}, sig2: ${sig1.value}');
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('sig1: world, sig2: 222'), findsOneWidget);
      },
    );
  });

  group('SignalProvider Edge Cases & Advanced Options', () {
    testWidgets(
      'SignalProvider.of with listen: false does not rebuild calling widget',
      (WidgetTester tester) async {
        final mySignal = MyTestSignal(100);
        int buildCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: SignalProvider<MyTestSignal>.value(
              value: mySignal,
              child: Builder(
                builder: (context) {
                  buildCount++;
                  final retrieved =
                      SignalProvider.of<MyTestSignal>(context, listen: false)!;
                  return Text('Value: ${retrieved.peek()}');
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(buildCount, 1);
        expect(find.text('Value: 100'), findsOneWidget);

        // Mutate signal - should NOT trigger rebuild because listen: false
        mySignal.value = 101;
        await tester.pumpAndSettle();
        expect(buildCount, 1); // Remains 1!

        mySignal.dispose();
      },
    );

    testWidgets(
      'SignalProvider.providerOf returns provider instance with listen true/false',
      (WidgetTester tester) async {
        final mySignal = MyTestSignal(200);

        await tester.pumpWidget(
          MaterialApp(
            home: SignalProvider<MyTestSignal>.value(
              value: mySignal,
              child: Builder(
                builder: (context) {
                  final provider1 = SignalProvider.providerOf<MyTestSignal>(
                    context,
                    listen: true,
                  );
                  final provider2 = SignalProvider.providerOf<MyTestSignal>(
                    context,
                    listen: false,
                  );
                  return Text(
                    'Provider1: ${provider1 != null}, Provider2: ${provider2 != null}',
                  );
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Provider1: true, Provider2: true'), findsOneWidget);
        mySignal.dispose();
      },
    );

    testWidgets(
      'SignalProvider.value didUpdateWidget updates exposed signal instance',
      (WidgetTester tester) async {
        final sigA = MyTestSignal(1);
        final sigB = MyTestSignal(2);
        var currentSignal = sigA;

        late StateSetter setParentState;

        await tester.pumpWidget(
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) {
                setParentState = setState;
                return SignalProvider<MyTestSignal>.value(
                  value: currentSignal,
                  child: Builder(
                    builder: (childContext) {
                      final sig =
                          SignalProvider.of<MyTestSignal>(childContext)!;
                      return Text('Value: ${sig.value}');
                    },
                  ),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Value: 1'), findsOneWidget);

        // Update currentSignal and rebuild parent
        setParentState(() {
          currentSignal = sigB;
        });
        await tester.pumpAndSettle();
        expect(find.text('Value: 2'), findsOneWidget);

        sigA.dispose();
        sigB.dispose();
      },
    );

    testWidgets(
      'supports standard core ReadonlySignal instances via Listenable adapter conversion',
      (WidgetTester tester) async {
        final coreSignal = signal(456);
        late ReadonlySignal<int> retrieved;
        int buildCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: SignalProvider<ReadonlySignal<int>>.value(
              value: coreSignal,
              child: Builder(
                builder: (context) {
                  buildCount++;
                  retrieved = SignalProvider.of<ReadonlySignal<int>>(context)!;
                  return Text('Value: ${retrieved.value}');
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Value: 456'), findsOneWidget);
        expect(buildCount, 1);

        // Mutate core signal - should automatically trigger rebuild via adapter conversion
        coreSignal.value = 789;
        await tester.pump();
        expect(find.text('Value: 789'), findsOneWidget);
        expect(buildCount, 2);

        coreSignal.dispose();
      },
    );
  });
}
