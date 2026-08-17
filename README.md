# 🧱 Bloc Advanced Demo

A production-ready Flutter project demonstrating advanced **BLoC (Business Logic Component)** state management patterns with clean architecture principles.

---

## 📋 Overview

This project showcases how to build scalable Flutter applications using:

- **BLoC / Cubit** for state management
- **Clean Architecture** (Data → Domain → Presentation)
- **Dependency Injection** with `get_it`
- **JSON Serialization** with `json_serializable`
- **HTTP Networking** with `Dio`
- **Event Transformers** with `bloc_concurrency`

---

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── bloc_observer.dart       # Global BLoC observer for logging
│   ├── error/
│   │   └── failures.dart        # Failure models
│   ├── network/
│   │   └── api_client.dart      # Dio HTTP client setup
│   └── theme/
│       └── theme_cubit.dart     # App theme management
├── features/
│   └── posts/
│       ├── data/
│       │   ├── models/
│       │   │   ├── post_model.dart      # JSON model with serialization
│       │   │   └── post_model.g.dart    # Generated serialization code
│       │   └── repositories/
│       │       └── post_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── post.dart            # Core Post entity
│       │   └── repositories/
│       │       └── post_repository.dart # Abstract repository
│       └── presentation/
│           ├── bloc/
│           │   ├── posts_bloc.dart
│           │   ├── posts_event.dart
│           │   └── posts_state.dart
│           ├── pages/
│           │   └── posts_page.dart
│           └── widgets/
│               └── post_list_item.dart
├── injection_container.dart     # GetIt service locator setup
└── main.dart
```

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | BLoC state management |
| `bloc_concurrency` | Event transformer helpers |
| `stream_transform` | Stream utility operators |
| `dio` | HTTP networking |
| `get_it` | Dependency injection |
| `equatable` | Value equality for entities |
| `json_annotation` | JSON serialization annotations |
| `google_fonts` | Custom typography |
| `flutter_spinkit` | Loading indicators |

### Dev Dependencies
| Package | Purpose |
|---|---|
| `build_runner` | Code generation runner |
| `json_serializable` | JSON serialization code generator |
| `bloc_test` | BLoC unit testing utilities |
| `mocktail` | Mocking library for tests |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.11.1`
- Dart SDK `^3.11.1`

### Installation

```bash
# Clone the repository
git clone https://github.com/Sumant26/Bloc-advanced-demo.git
cd Bloc-advanced-demo

# Install dependencies
flutter pub get

# Generate serialization code
flutter pub run build_runner build
```

### Run the App

```bash
flutter run
```

---

## 🔧 Code Generation

This project uses `json_serializable` for JSON serialization. After modifying any `@JsonSerializable()` class, regenerate the code:

```bash
# One-time build
flutter pub run build_runner build

# Watch mode (auto-regenerates on changes)
flutter pub run build_runner watch
```

---

## 🧪 Running Tests

```bash
flutter test
```

---

## 📚 Learn More

- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Flutter Official Docs](https://docs.flutter.dev/)
