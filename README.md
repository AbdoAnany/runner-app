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
      
R**Flutter Runner Application**

**Table of Contents**

- [Features](#features)
- [Project Structure](#project-structure)
- [Libraries & Packages](#libraries--packages)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

**Features**

- User authentication (sign up, login, password reset) using Firebase.
- Role-based user management.
- Store management with brands, categories, and popular products.
- View user activity history.
- Onboarding screens for new users.
- Dynamic home screen with personalized user data and progress tracking.

**Project Structure**

The project follows a clean architecture approach with a focus on separation of concerns. The structure is divided into core, features, and shared components:

css

Copy code

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

│   ├── 0\_get\_started/

│   ├── 1\_onboarding/

│   ├── 2\_auth/

│   ├── 3\_home/

│   ├── 4\_history/

│   ├── 5\_store/

│   └── 6\_profile/

│

├── main.dart

└── my\_app.dart

**Key Components**

- **core**: Contains shared utilities, styles, constants, error handling, and reusable widgets.
- **features**: Each feature is organized by domain and contains its own data, domain, and presentation layers.
  - **data**: Data sources, repositories, and models.
  - **domain**: Use cases, entities, and repositories interfaces.
  - **presentation**: UI screens, widgets, and BLoC for state management.

**Libraries & Packages**

The project makes use of several libraries and packages to enhance its functionality:

- **Firebase**: Used for authentication and data storage.
  - firebase\_core
  - firebase\_auth
  - cloud\_firestore
- **State Management**:
  - flutter\_bloc: For BLoC pattern implementation.
- **Routing**:
  - go\_router: For declarative routing.
- **Storage**:
  - shared\_preferences: For storing user credentials locally.
- **UI and Styling**:
  - flutter\_screenutil: For responsive UI design.
  - iconsax: For a wide range of icons.
  - toastification: For showing custom toast messages.
- **Others**:
  - equatable: For value equality.
  - dio: For making HTTP requests (if needed for remote API calls).

**Getting Started**

Follow these steps to set up and run the project on your local machine:

**Prerequisites**

Ensure you have the following installed:

- Flutter SDK: Install Flutter
- Firebase CLI: Install Firebase CLI

**Installation**

1. **Clone the repository**:

   bash

   Copy code

   git clone https://github.com/your-username/flutter-ecommerce-app.git

   cd flutter-ecommerce-app

1. **Install dependencies**:

   bash

   Copy code

   flutter pub get

1. **Set up Firebase**:
   1. Create a Firebase project and add an Android/iOS app.
   1. Download the google-services.json (Android) and GoogleService-Info.plist (iOS) from the Firebase console and place them in the respective platform directories (android/app and ios/Runner).
1. **Run the application**:

   bash

   Copy code

   flutter run

**Contributing**

Contributions are welcome! Please fork the repository and submit a pull request for any changes. Here are some ways you can contribute:

- Report bugs and issues.
- Suggest features and enhancements.
- Write tests and improve coverage.
- Refactor code for efficiency and readability.

**License**

This project is licensed under the MIT License. See the LICENSE file for details.


