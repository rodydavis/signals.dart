---
title: SignalsPreferNamedBuilder
description: A Dart static analysis rule that detects positional builder parameters in <code>Watch</code>.
---

A Dart static analysis rule that detects positional builder parameters in <code>Watch</code>
or <code>SignalBuilder</code> constructors and encourages using the named <code>builder</code> argument.

<Info>
In <code>signals</code> v7, to make the API more readable and consistent with standard Flutter components,
<code>Watch</code> and <code>SignalBuilder</code> support the named <code>builder</code> parameter. Using positional
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

<details>
<summary> View Constructors </summary>

##### <a name="signalsprefernamedbuilder"></a><a name="signalsprefernamedbuilder"></a><code>SignalsPreferNamedBuilder()</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a><code>void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)</code>

</details>
