# Runner App

This is a Flutter Runner App that uses Bloc for state management and Firebase Firestore for data storage. The app includes a history section and a popular section with role-based permissions to access different parts of the app.

## Table of Contents

- [Setup Instructions](#setup-instructions)
- [Architecture Overview](#architecture-overview)
- [Implementation Details](#implementation-details)
- [Role-Based Access Control Setup](#role-based-access-control-setup)
- [Bloc Implementation and Interactions](#bloc-implementation-and-interactions)
- [Contributing](#contributing)
- [License](#license)

## Setup Instructions

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.4.2)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project with Firestore and Authentication enabled.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AbdoAnany/runner-app.git
   cd runner-app

2. **Install dependencies::**

   ```bash
   flutter pub get
      ```bash
   lib/
      │
      ├── core/
      │   ├── constants/
      │   ├── errors/
      │   ├── helpers/
      │   ├── share/
      │   ├── style/
      │   ├── utils/
      │   └── widgets/
      │
      ├── features/
      │   ├── 0_get_started/ │
                  ├── presentation/pages/get_started_screen.dart
      │   ├── 1_onboarding/
                  ├── presentation/pages/onboarding_screen.dart
                  ├── presentation/widgets/card_onboarding.dart
      │   ├── 2_auth/
      │   ├── 3_home/
      │   ├── 4_history/
      │   ├── 5_store/
      │   └── 6_profile/
      │
      ├── main.dart
      └── my_app.dart
3. **pakages dependencies::**

   ```bash
      carousel_slider: ^4.2.1
        cloud_firestore: ^5.1.0
        dartz: ^0.10.1
        equatable: ^2.0.5
        firebase_auth: ^5.1.2
        firebase_core: ^3.2.0
        flutter:
          sdk: flutter
        flutter_bloc: ^8.1.6
        flutter_launcher_icons: ^0.13.1
        flutter_native_splash: ^2.4.1
        flutter_screenutil: ^5.9.3
        get_it: ^7.7.0
        iconsax: ^0.0.8
        intl: ^0.19.0
        provider: ^6.1.2
        shared_preferences: ^2.2.3
        smooth_page_indicator: ^1.2.0+3
        toastification: ^2.1.0
      
      
      dev_dependencies:
        flutter_test:
          sdk: flutter
        bloc_test: ^9.0.6
        flutter_lints: ^3.0.0
      flutter_native_splash:
        color: "#28333F" # Set the background color for the splash screen
        image: "assets/image/Logo.png" # Set the image for the splash screen
      
        android_12:
          image: "assets/image/Logo12.png" # Use the same image for Android 12+
          color: "#28333F" # Set the background color for Android 12+
      
      flutter_launcher_icons:
        android: "launcher_icon"
        ios: true
        image_path: "assets/image/Logo.png"
        min_sdk_android: 21 # android min sdk min:16, default 21

# Architecture

The `2_auth` feature is divided into three main layers: Presentation, Domain, and Data.

## Presentation Layer

This layer is responsible for managing the UI state and interactions. It utilizes the BLoC (Business Logic Component) pattern to separate business logic from UI components.

### Key Components

- **BLoC**: `AuthBloc` manages authentication events and states.
- **Events**: Define the actions that can be performed.
- **States**: Define the UI states resulting from events.

## Domain Layer

This layer contains the business logic and interacts with repositories to fulfill use cases.

### Key Components

- **Entities**: `UserEntity` represents the user data in the app.
- **Use Cases**: Encapsulate the application's business logic.
  - **`LoginUseCase`**: Handles user login.
  - **`SignUpUseCase`**: Handles user registration.

## Data Layer

This layer handles data operations, including data retrieval and storage.

### Key Components

- **Repositories**: Provide abstract interfaces for data operations.
  - **Implementation**: `AuthRepositoryImpl` handles data operations using Firebase Authentication and SharedPreferences.
- **Data Sources**: Manage actual data retrieval from network or local storage.
  - **Remote**: Interacts with Firebase for authentication.
  - **Local**: Utilizes SharedPreferences for storing session data.

## BLoC Pattern

The authentication feature uses BLoC to manage state changes in the application. Below is an overview of the events and states managed by the `AuthBloc`.

### Events

- **`UserIsLogIn`**: Checks if a user is logged in based on saved session data.
- **`SignInRequested`**: Triggers a user login with email and password.
- **`SignUpRequested`**: Initiates user registration with email, password, and role.
- **`LoadRolesRequested`**: Fetches user roles from the repository.
- **`SignOutRequested`**: Logs the user out and clears session data.
- **`ReloadState`**: Reloads the current authentication state to reflect any changes.

### States

- **`AuthInitial`**: The initial state when no authentication process is active.
- **`AuthLoading`**: Indicates an ongoing authentication process.
- **`Authenticated`**: Represents a successfully authenticated user.
- **`AuthError`**: Indicates an error occurred during authentication, with an error message.
- **`SignUpRequestedDone`**: Indicates a successful registration process.
- **`RolesLoaded`**: Represents the successful loading of user roles.
- **`LoggedOut`**: Indicates the user has successfully logged out.


      
