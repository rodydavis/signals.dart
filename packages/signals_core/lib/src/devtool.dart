// coverage:ignore-start

/// Reload the devtools
@Deprecated('Use the DevToolsSignalsObserver instead')
void reloadSignalsDevTools() {}

/// Disable the devtools
@Deprecated('Use the "signalsDevToolsEnabled = false" instead')
void disableSignalsDevTools() {}

/// Check if the signals devtools are enabled
bool get signalsDevToolsEnabled => false;

/// Manually enable/disable signals devtools
set signalsDevToolsEnabled(bool value) {}

// coverage:ignore-end
