import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'src/lints/avoid_create_in_build_method.dart';
import 'src/lints/avoid_deprecated_signals_mixin.dart';
import 'src/lints/avoid_deprecated_watch_extension.dart';
import 'src/lints/prefer_named_builder.dart';
import 'src/lints/prefer_unified_options.dart';

import 'src/fixes/convert_stateful_to_signal_stateful_widget.dart';
import 'src/fixes/convert_stateless_to_signal_widget.dart';
import 'src/fixes/migrate_signals_mixin_to_signal_stateful_widget.dart';
import 'src/fixes/migrate_watch_to_signal_builder.dart';
import 'src/fixes/wrap_with_signal_builder.dart';

/// Entrypoint for the `signals_lint` Dart analyzer plugin.
final plugin = SignalsLintPlugin();

class SignalsLintPlugin extends Plugin {
  @override
  String get name => 'signals_lint';

  @override
  void register(PluginRegistry registry) {
    // 1. Register Rules (Lints)
    final avoidCreate = SignalsAvoidCreateInBuildMethod();
    final avoidWatch = SignalsAvoidDeprecatedWatchExtension();
    final avoidMixin = SignalsAvoidDeprecatedSignalsMixin();
    final preferNamed = SignalsPreferNamedBuilder();
    final preferUnified = SignalsPreferUnifiedOptions();

    registry.registerLintRule(avoidCreate);
    registry.registerLintRule(avoidWatch);
    registry.registerLintRule(avoidMixin);
    registry.registerLintRule(preferNamed);
    registry.registerLintRule(preferUnified);

    // 2. Register Quick Fixes (associated with specific diagnostics)
    registry.registerFixForRule(
      avoidMixin.diagnosticCode,
      MigrateSignalsMixinToSignalStatefulWidget.new,
    );
    registry.registerFixForRule(
      avoidWatch.diagnosticCode,
      MigrateWatchToSignalBuilder.new,
    );
    registry.registerFixForRule(
      preferNamed.diagnosticCode,
      MigrateWatchToSignalBuilder.new,
    );

    // 3. Register Assists (general context-based refactoring)
    registry.registerAssist(ConvertStatelessToSignalWidget.new);
    registry.registerAssist(ConvertStatefulToSignalStatefulWidget.new);
    registry.registerAssist(MigrateSignalsMixinToSignalStatefulWidget.new);
    registry.registerAssist(MigrateWatchToSignalBuilder.new);
    registry.registerAssist(WrapWithSignalBuilder.new);
  }
}
