# GEMINI.md – Flutter Project Guidelines

## 1. Overview
Cross-platform Flutter app (Android, iOS, Web) using clean architecture and strict Flutter/Dart style.

## 2. Core Principles

### 2.1 Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) and Flutter style guides.
- Naming: camelCase (vars, funcs), PascalCase (classes), snake_case (files).
- Use `dart format`.
- Document public APIs with `///`.

### 2.2 Separation of Concerns
- **Screens:** UI only (widgets/pages), no business logic.
- **Widgets:** Feature logic, use cases, state management.
- **Models:** Entities, value objects, repository interfaces.
- **Data:** Data sources, repository implementations.

## 3. Packages

- **flutter_riverpod:** State management. Use Provider, StateProvider, StateNotifierProvider, FutureProvider, StreamProvider. Prefer `ConsumerWidget`/`ConsumerStatefulWidget` and `ref.watch`/`ref.read`.
- **firebase_auth:** User authentication. Use with firebase_core.
- **envied:** For securely storing API keys and other secrets.
- **shared_preferences:** Simple key-value storage for preferences.
- **url_launcher:** Open external URLs.
- **animated_text_kit:** Text animations for UI.
- **firebase_data_connect:** All Firebase data operations (Firestore, RTDB, etc).
- **firebase_core:** Must be initialized in `main()`.

## 4. Best Practices

### 4.1 State Management
- Use Riverpod providers for all state.
- Provider: read-only, StateProvider: simple mutable, StateNotifierProvider: complex state, FutureProvider/StreamProvider: async.

### 4.2 Firebase
- Call `Firebase.initializeApp()` in `main()` before `runApp()`.
- Use streams for auth state.
- Define data models with `toJson()`/`fromJson()`.
- Use try-catch for all Firebase ops.

### 4.3 Structure

```
lib/
├── [feature]/
│   ├── screens/
│   ├── constants/
│   ├── widgets/
│   ├── models/
│   └── data/
├── common/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── widgets/
└── main.dart
```

### 4.4 Error Handling
- Define custom Failure classes in `core/errors` (e.g., AuthFailure).
- Propagate errors up to UI for user feedback.

### 4.5 Testing
- Unit tests: domain/application logic.
- Widget tests: UI.
- Integration tests: (optional) for complex flows.

## 5. New Packages
- Only add if existing packages can't solve the problem.
- Must be well-maintained, compatible, performant, and support SoC.

## 6. API Keys and secrets
- Always store API Keys and other secrets in the .env file. Obfuscate keys and secrets.