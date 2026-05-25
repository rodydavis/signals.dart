# `computedFrom`

`computedFrom` allows you to create a derived async signal by combining multiple other async signals together, cleanly tracking the state of all dependencies.

---

## 1. Creation

```dart
final userProfile = futureSignal(() => fetchUser());
final userStats = futureSignal(() => fetchStats());

final combinedDashboard = computedFrom(
  [userProfile, userStats],
  () {
    final profile = userProfile.value.value;
    final stats = userStats.value.value;
    return DashboardData(profile, stats);
  },
);
```

---

## 2. Key Attributes
- **State Aggregation**: The returned signal is in `AsyncLoading` if any of its sources are loading, `AsyncError` if any have failed, and `AsyncData` only when all of them successfully complete.
