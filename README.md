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
      lib
      │
      ├── core
      │   ├── utils
      │   │   ├── app_style.dart
      │   │   └── color.dart
      │   └── constants
      │       └── app_constants.dart
      │
      ├── data
      │   ├── repositories
      │   │   └── auth_repository_impl.dart
      │   └── sources
      │       ├── firebase_service.dart
      │       └── shared_preferences_service.dart
      │
      ├── domain
      │   ├── entities
      │   │   └── user_entity.dart
      │   ├── repositories
      │   │   └── auth_repository.dart
      │   └── use_cases
      │       ├── login_use_case.dart
      │       └── sign_up_use_case.dart
      │
      ├── presentation
      │   ├── bloc
      │   │   ├── auth_bloc.dart
      │   │   ├── auth_event.dart
      │   │   └── auth_state.dart
      │   ├── pages
      │   │   ├── login_screen.dart
      │   │   └── sign_up_screen.dart
      │   └── widgets
      │       ├── email_field.dart
      │       ├── password_field.dart
      │       ├── role_dropdown.dart
      │       └── social_auth_buttons.dart
      │
      └── main.dart
      
