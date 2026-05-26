/// # Signals Linter and Developer Tools
///
/// A premium static analysis and code refactoring suite for the `signals` ecosystem.
/// This package integrates seamlessly with Dart's `analyzer` plugin system via `custom_lint`
/// to enforce reactive design patterns and automate widget bindings.
///
/// :::tip
/// Static analysis and assists provided by this linter greatly reduce the boilerplate and prevent
/// common reactive programming pitfalls, such as state loss or memory leaks.
/// :::
///
/// ## Features
///
/// - **Lint Rules**: Detects reactive anti-patterns like creating signals inside Flutter's `build` methods.
/// - **Assists (Quick Fixes)**: Enhances developer velocity by automating common refactoring tasks (e.g., wrapping widgets in `Watch`).
///
/// ---
///
/// ## Getting Started
///
/// To use the `signals_lint` plugin, follow these steps to integrate it into your Dart/Flutter project:
///
/// ### 1. Add Dependencies
/// Add `custom_lint` and `signals_lint` to the `dev_dependencies` of your project's `pubspec.yaml`:
///
/// ```yaml
/// dev_dependencies:
///   custom_lint: ^0.6.4
///   signals_lint: ^7.0.0
/// ```
///
/// ### 2. Enable the Plugin
/// Enable the `custom_lint` plugin in your `analysis_options.yaml` file:
///
/// ```yaml
/// analyzer:
///   plugins:
///     - custom_lint
/// ```
///
/// ### 3. Restart / Fetch dependencies
/// Run the following commands in the root of your project:
///
/// ```sh
/// flutter clean
/// flutter pub get
/// ```
///
/// After fetching dependencies, your IDE should automatically pick up the linter rules and assist options.
/// You can also run the linter manually from the CLI:
///
/// ```sh
/// dart run custom_lint
/// ```
///
/// ---
///
/// ## Rules & Assists Overview
///
/// ### 1. Lint: `signals_avoid_create_in_build_method`
/// Prevents creating signals, computed variables, or reactive builders inside a widget's build method.
/// Creating a signal inside the build method resets its state and creates a brand-new signal on every rebuild.
///
/// **Incorrect:**
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   final counter = signal(0); // BAD: Recreated on every rebuild!
///   return Text('${counter.value}');
/// }
/// ```
///
/// **Correct:**
/// ```dart
/// final counter = signal(0); // OK: Declared globally or in a stateful class
///
/// @override
/// Widget build(BuildContext context) {
///   return Text('${counter.value}');
/// }
/// ```
///
/// ### 2. Assist: `Wrap with Watch`
/// Quick fix to automatically wrap a Widget with a `Watch` builder. Rebuilds the widget automatically
/// when any signals read inside the builder change.
///
/// **Before:**
/// ```dart
/// Widget build(BuildContext context) {
///   return Text('Counter: ${counter.value}');
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// Widget build(BuildContext context) {
///   return Watch((context) => Text('Counter: ${counter.value}'));
/// }
/// ```
library;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'src/fixes/wrap_with_signal_builder.dart';
import 'src/fixes/convert_stateless_to_signal_widget.dart';
import 'src/fixes/convert_stateful_to_signal_stateful_widget.dart';
import 'src/fixes/migrate_signals_mixin_to_signal_stateful_widget.dart';
import 'src/fixes/migrate_watch_to_signal_builder.dart';
import 'src/lints/avoid_create_in_build_method.dart';
import 'src/lints/avoid_deprecated_watch_extension.dart';
import 'src/lints/avoid_deprecated_signals_mixin.dart';
import 'src/lints/prefer_named_builder.dart';
import 'src/lints/prefer_unified_options.dart';

PluginBase createPlugin() => _SignalsPlugin();

class _SignalsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        SignalsAvoidCreateInBuildMethod(),
        SignalsAvoidDeprecatedWatchExtension(),
        SignalsAvoidDeprecatedSignalsMixin(),
        SignalsPreferNamedBuilder(),
        SignalsPreferUnifiedOptions(),
      ];

  @override
  List<Assist> getAssists() => [
        WrapWithSignalBuilder(),
        ConvertStatelessToSignalWidget(),
        ConvertStatefulToSignalStatefulWidget(),
        MigrateSignalsMixinToSignalStatefulWidget(),
        MigrateWatchToSignalBuilder(),
      ];
}
