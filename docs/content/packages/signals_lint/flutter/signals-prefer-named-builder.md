---
title: SignalsPreferNamedBuilder
description: A Dart static analysis rule that detects positional builder parameters in Watch.
---

A Dart static analysis rule that detects positional builder parameters in `Watch`
or `SignalBuilder` constructors and encourages using the named `builder` argument.

<Info>
In `signals` v7, to make the API more readable and consistent with standard Flutter components,
`Watch` and `SignalBuilder` support the named `builder` parameter. Using positional
parameters can be harder to read and may be deprecated in future versions.
</Info>

### Examples

**Incorrect:**
```dart
Watch((context) { // LINT: Positional builder argument
  return Text('${counter.value}');
});
```

**Correct:**
```dart
Watch(
  builder: (context) => Text('${counter.value}'), // OK: Named builder parameter
);
```


### Constructors

##### <a name="signalsprefernamedbuilder"></a><a name="signalsprefernamedbuilder"></a>`SignalsPreferNamedBuilder()`


### Methods

##### <a name="run"></a>`void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)`
