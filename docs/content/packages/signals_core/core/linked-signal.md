---
title: LinkedSignal
description: A highly powerful, mutable computed signal that derives its default value from an underlying source,.
---

A highly powerful, mutable computed signal that derives its default value from an underlying source,
but allows manual write overrides. Crucially, **whenever the underlying source value changes, the signal**
**automatically discards any local manual overrides and resets back to the newly computed default.**

This hybrid behavior is the perfect solution for synchronizing local edit state with external remote state.

### 1. Real-World Use Case: Profile Form Editor
Imagine you are building a profile editor where the user can modify their username:
- The initial/remote username is fetched from a database and held in a source signal.
- The text input field is bound to a local signal.
- The user should be able to edit the field locally (overriding the remote default).
- If the selected user changes (e.g., they switch to a different profile in a list), the text field must automatically discard any local changes and reset to the new user's username.

```dart
// The remote/source state
final selectedUser = signal(User(id: 1, name: 'Alice'));

// The local editable state linked to the remote source
final username = linkedSignal(() => selectedUser.value.name);

print(username.value); // 'Alice'

// User edits the text field:
username.value = 'Bob';
print(username.value); // 'Bob' (local override active)

// Switch remote profile:
selectedUser.value = User(id: 2, name: 'Charlie');

// Local overrides are discarded and reset to the new source:
print(username.value); // 'Charlie'
```

### 2. Custom Computations using <code>LinkedSignalOptions</code>
By default, a linked signal directly passes the source value through. You can customize this mapping using a custom <code>computation</code> function that has access to both the current source value and the previous state:

```dart
final counter = signal(10);

final doubled = linkedSignal(
  () => counter.value,
  options: LinkedSignalOptions(
    computation: (sourceVal, prev) {
      print('Source changed to $sourceVal. Previous value was: ${prev?.value}');
      return sourceVal * 2;
    },
  ),
);
```

### 3. Custom Source Equality
To prevent unnecessary resets, you can supply a custom <code>sourceEquality</code> callback. The signal will only reset when the equality check returns <code>false</code>:

```dart
final selectedUser = signal(User(id: 1, name: 'Alice'));

final username = linkedSignal(
  () => selectedUser.value,
  options: LinkedSignalOptions(
    // Only reset when the user ID actually changes:
    sourceEquality: (a, b) => a.id == b.id,
  ),
);
```

<Info>
  Always use <code>LinkedSignal</code> rather than manual <code>effect</code> listeners to synchronize local editable values with remote defaults. It is simpler, avoids race conditions, and consumes significantly less memory.
</Info>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="linkedsignal"></a><a name="linkedsignal"></a><code>LinkedSignal({required S Function() source, LinkedSignalOptions<T, S>? options})</code>

Creates a new [LinkedSignal](/types/linkedsignal).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="set"></a><code>bool set(T val, {bool force = false})</code>

##### <a name="value"></a><code>T value</code>

##### <a name="value"></a><code>value(T val)</code>

##### <a name="dispose"></a><code>void dispose()</code>

</details>



---

## linkedSignal

{@macro linked_signal}
