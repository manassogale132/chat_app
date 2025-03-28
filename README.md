# Chat Application

A modern chat application built with Flutter, featuring real-time local dummy messaging capabilities and a sleek user interface.

![photo-collage png (1)](https://github.com/user-attachments/assets/4048d811-5615-4a2d-a84e-6fb434fc2279)


 
## Features

- Real-time dummy messaging with instant updates
- Voice message support (Custom Message)
- Dynamic chat background themes
- Dark/Light mode toggle
- Custom chat bubbles
- Interactive feature tour with ShowcaseView


## Technical Stack

- Flutter SDK: ^3.7.2
- BLoC pattern for state management
- Clean Architecture principles
- Responsive UI design
- Cross-platform support (iOS, Android, Web, Windows, Linux, macOS)


### Key Dependencies

- flutter_bloc: ^9.0.0 (State management)
- get_it: ^8.0.3 (Dependency injection)
- cached_network_image: ^3.4.1 (Image caching)
- intl: ^0.20.1 (Internationalization)
- showcaseview: ^4.0.1 (Interactive feature tour)
- freezed: ^2.5.7 (Code generation)
- equatable: ^2.0.7 (Value equality)


### Directory Structure
```
lib/
├── bloc/
│   ├── chat_screen_bloc.dart
│   ├── events/
│   │   ├── fetch_messages_event.dart
│   │   └── send_message_event.dart
│   └── states/
│       ├── chat_screen_initial.dart
│       ├── chat_screen_loading.dart
│       ├── chat_screen_loaded.dart
│       └── chat_screen_error.dart
├── core/
│   └── service_locator.dart
├── models/
│   └── message_model.dart
├── repositories/
│   └── chat_repository.dart
├── screens/
│   └── chat_screen.dart
├── services/
│   └── chat_service.dart
├── widgets/
│   ├── about_dialog_widget.dart
│   ├── chat_app_bar.dart
│   ├── chat_bubble.dart
│   └── chat_input_field.dart
└── main.dart
```


## Getting Started

1. Ensure you have Flutter SDK installed (^3.7.2)
2. Clone the repository
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```


## Platform Support

- iOS
- Android
- Web
- Windows
- Linux
- macOS

 
## Build Information

- Version: 1.0.0
- Build: 1
- Package Name: com.example.chat_application

 
## Development

This project follows Flutter's best practices and implements Clean Architecture principles. The state management is handled using the BLoC pattern, ensuring a clean separation of concerns and maintainable codebase.

