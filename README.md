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

# Architecture 2_auth 

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

# History Screen Architecture

The **History Screen** feature is implemented using the BLoC architecture and is responsible for managing and displaying historical runner data.

## Architecture Overview

The History feature is structured into three main layers:

1. **Presentation Layer**
2. **Domain Layer**
3. **Data Layer**

### Presentation Layer

The presentation layer handles the UI state and user interactions. It uses the BLoC (Business Logic Component) pattern to maintain a clear separation between the business logic and UI components.

#### Key Components

- **BLoC**: `RunnerHistoryDataBloc` manages events and states related to runner data.
- **Events**: Define the actions or interactions that can be performed by the user.
- **States**: Represent the various states of the UI as a result of these events.

### Domain Layer

The domain layer contains the core business logic of the application, encapsulating use cases and interacting with repositories to retrieve or modify data.

#### Key Components

- **Use Cases**: Encapsulate the business logic of the application.
  - **`GetHistoryData`**: Retrieves historical runner data.
  - **`SetHistoryData`**: Stores runner data.

### Data Layer

The data layer is responsible for managing data retrieval and storage, interfacing with remote and local data sources.

#### Key Components

- **Repositories**: Abstract interfaces that define data operations.
  - **Remote Sources**: Handle data operations with Firebase Storge.
  

## BLoC Pattern

The History Screen feature employs the BLoC pattern to manage state changes in the application efficiently. Below is a detailed overview of the events and states managed by the `RunnerHistoryDataBloc`.

### Events

- **`LoadRunnerData`**: Initiates the process of loading runner history data. If no data is available, it generates fake history data for demonstration purposes.

### States

- **`RunnerDataLoading`**: Represents the state when the data is being loaded.
- **`RunnerDataLoaded`**: Indicates that the runner history data has been successfully loaded.
- **`RunnerDataError`**: Represents an error state with an error message when data loading fails.

### BLoC Implementation

The `RunnerHistoryDataBloc` manages the state of runner history data through the following process:

1. **`LoadRunnerData` Event**:
   - Triggers the loading of runner history data.
   - If data is empty, generates fake data and saves it using the `SetHistoryData` use case.
   - Emits `RunnerDataLoaded` state with the loaded data.
   - In case of an error, emits `RunnerDataError` state with the error message.
# Store Feature Architecture

The **Store** feature in this application is designed to manage and display product-related data such as brands, categories, and popular products. This feature utilizes Firebase for data retrieval and employs the BLoC (Business Logic Component) architecture to separate business logic from UI components.

## Architecture Overview

The Store feature is organized into three main layers:

1. **Presentation Layer**
2. **Domain Layer**
3. **Data Layer**

### Presentation Layer

The presentation layer is responsible for managing UI states and user interactions. The BLoC pattern is used to handle state management, allowing for a clear separation between UI and business logic.

#### Key Components

- **BLoC**: `StoreBloc` handles events and states related to store data.
- **Events**: Define the user actions or interactions within the store.
- **States**: Represent the UI states that result from events.

### Domain Layer

The domain layer contains the core business logic of the Store feature. It defines use cases that interact with repositories to fetch or modify data.

#### Key Components

- **Use Cases**: Encapsulate the business logic for specific operations.
  - **`GetBrands`**: Fetches the list of brands from the data source.
  - **`GetCategories`**: Retrieves the list of categories.
  - **`GetPopularProducts`**: Obtains the list of popular products.

### Data Layer

The data layer is responsible for handling data operations, including data retrieval and storage. It interacts with Firebase to fetch necessary information.

#### Key Components

- **Repositories**: Abstract interfaces that define data operations.
- **Data Sources**: Manage data retrieval and storage.
  - **Firebase**: Used to retrieve brands, categories, and popular products data.

## BLoC Pattern

The Store feature utilizes the BLoC pattern to efficiently manage state changes within the application. Below is an overview of the events and states managed by the `StoreBloc`.

### Events

- **`LoadStoreData`**: Initiates the loading of store data, including brands, categories, and popular products.
- **`RefreshStoreData`**: Refreshes the store data to ensure it is up-to-date.
- **`LoadMorePopularProducts`**: Loads additional popular products to be appended to the existing list.

### States

- **`StoreInitial`**: Represents the initial state before any data is loaded.
- **`StoreLoading`**: Indicates that the store data is currently being loaded.
- **`StoreLoaded`**: Represents the state where store data has been successfully loaded.
- **`StoreError`**: Indicates that an error occurred during data retrieval, providing an error message.

### BLoC Implementation

The `StoreBloc` manages the state of the store feature through the following processes:

1. **`LoadStoreData` Event**:
   - Fetches brands, categories, and popular products data from Firebase.
   - Emits `StoreLoaded` state with the retrieved data.
   - Emits `StoreError` state in case of any errors during the data fetching process.

2. **`RefreshStoreData` Event**:
   - Refreshes the brands, categories, and popular products data.
   - Similar to `LoadStoreData`, it emits either `StoreLoaded` or `StoreError` based on the outcome.

3. **`LoadMorePopularProducts` Event**:
   - Loads additional popular products and appends them to the existing list.
   - Emits `StoreLoaded` with the updated list or `StoreError` if any error occurs.
//////////////////////////////////////////////////


Certainly! Here\'s the complete markdown documentation for the Runner
App, including detailed notes on the History and Store features. You can
save this content as a \`.md\` file for reference:

\`\`\`markdown \# Runner App

This is a Flutter Runner App that uses Bloc for state management and
Firebase Firestore for data storage. The app includes a history section
and a store section with role-based permissions to access different
parts of the app.

\## Table of Contents

\- \[Setup Instructions\](#setup-instructions) - \[Architecture
Overview\](#architecture-overview) - \[Implementation
Details\](#implementation-details) - \[Role-Based Access Control
Setup\](#role-based-access-control-setup) - \[BLoC Implementation and
Interactions\](#bloc-implementation-and-interactions) -
\[Contributing\](#contributing) - \[License\](#license)

\## Setup Instructions

\### Prerequisites

\- \[Flutter\](https://flutter.dev/docs/get-started/install) (version
3.4.2) - \[Firebase CLI\](https://firebase.google.com/docs/cli) - A
Firebase project with Firestore and Authentication enabled.

\### Installation

1\. \*\*Clone the repository:\*\*

\`\`\`bash git clone https://github.com/AbdoAnany/runner-app.git cd
runner-app \`\`\`

2\. \*\*Install dependencies:\*\*

\`\`\`bash flutter pub get \`\`\`

3\. \*\*Configure Firebase:\*\*

Make sure to set up Firebase in your Flutter project by following the
\[official Firebase
documentation\](https://firebase.flutter.dev/docs/overview/).

\## Architecture Overview

The Runner App is designed with a modular architecture using the BLoC
pattern to ensure separation of concerns and maintainability. The
application is divided into several features, each with its own
presentation, domain, and data layers.

\### Project Structure

\`\`\`plaintext lib/ │ ├── core/ │ ├── constants/ │ ├── errors/ │ ├──
helpers/ │ ├── share/ │ ├── style/ │ ├── utils/ │ └── widgets/ │ ├──
features/ │ ├── 0_get_started/ │ │ ├──
presentation/pages/get_started_screen.dart │ ├── 1_onboarding/ │ │ ├──
presentation/pages/onboarding_screen.dart │ │ ├──
presentation/widgets/card_onboarding.dart │ ├── 2_auth/ │ ├── 3_home/ │
├── 4_history/ │ ├── 5_store/ │ └── 6_profile/ │ ├── main.dart └──
my_app.dart \`\`\`

\### Key Packages Used

\- \`carousel_slider\`: For carousel sliders in the UI. -
\`cloud_firestore\`: For Firebase Firestore integration. - \`dartz\`:
For functional programming patterns like \`Either\`. - \`equatable\`: To
simplify state comparison in BLoC. - \`firebase_auth\`: For Firebase
Authentication. - \`firebase_core\`: Core Firebase functionalities. -
\`flutter_bloc\`: For BLoC pattern implementation. - \`get_it\`: For
dependency injection. - \`shared_preferences\`: To store simple data
locally. - \`smooth_page_indicator\`: For smooth page indicators. -
\`toastification\`: For custom toast notifications.

\## Implementation Details

\### Core Features

1\. \*\*Authentication\*\* 2. \*\*History Management\*\* 3. \*\*Store
Management with Role-Based Access Control\*\*

\### Role-Based Access Control Setup

The Store feature implements role-based access control to display
different products based on user roles. The following roles are defined:

\- \*\*User\*\*: Can see only products marked as popular. -
\*\*Admin\*\*: Can see all products.

Role-based access control is achieved by using Firebase Authentication
and Firestore to determine the role of the logged-in user.

\### Package Dependencies

\`\`\`yaml dependencies: carousel_slider: \^4.2.1 cloud_firestore:
\^5.1.0 dartz: \^0.10.1 equatable: \^2.0.5 firebase_auth: \^5.1.2
firebase_core: \^3.2.0 flutter: sdk: flutter flutter_bloc: \^8.1.6
flutter_launcher_icons: \^0.13.1 flutter_native_splash: \^2.4.1
flutter_screenutil: \^5.9.3 get_it: \^7.7.0 iconsax: \^0.0.8 intl:
\^0.19.0 provider: \^6.1.2 shared_preferences: \^2.2.3
smooth_page_indicator: \^1.2.0+3 toastification: \^2.1.0

dev_dependencies: flutter_test: sdk: flutter bloc_test: \^9.0.6
flutter_lints: \^3.0.0

flutter_native_splash: color: \"#28333F\" \# Set the background color
for the splash screen image: \"assets/image/Logo.png\" \# Set the image
for the splash screen

android_12: image: \"assets/image/Logo12.png\" \# Use the same image for
Android 12+ color: \"#28333F\" \# Set the background color for Android
12+

flutter_launcher_icons: android: \"launcher_icon\" ios: true image_path:
\"assets/image/Logo.png\" min_sdk_android: 21 \# android min sdk min:16,
default 21 \`\`\`

\## BLoC Implementation and Interactions

\### Authentication (\`2_auth\` Feature)

The \`2_auth\` feature is divided into three main layers: Presentation,
Domain, and Data.

\#### Presentation Layer

This layer is responsible for managing the UI state and interactions. It
utilizes the BLoC (Business Logic Component) pattern to separate
business logic from UI components.

\##### Key Components

\- \*\*BLoC\*\*: \`AuthBloc\` manages authentication events and
states. - \*\*Events\*\*: Define the actions that can be performed. -
\*\*States\*\*: Define the UI states resulting from events.

\#### Domain Layer

This layer contains the business logic and interacts with repositories
to fulfill use cases.

\##### Key Components

\- \*\*Entities\*\*: \`UserEntity\` represents the user data in the
app. - \*\*Use Cases\*\*: Encapsulate the application\'s business logic.
 - \*\*\`LoginUseCase\`\*\*: Handles user login.  -
\*\*\`SignUpUseCase\`\*\*: Handles user registration.

\#### Data Layer

This layer handles data operations, including data retrieval and
storage.

\##### Key Components

\- \*\*Repositories\*\*: Provide abstract interfaces for data
operations.  - \*\*Implementation\*\*: \`AuthRepositoryImpl\` handles
data operations using Firebase Authentication and SharedPreferences. -
\*\*Data Sources\*\*: Manage actual data retrieval from network or local
storage.  - \*\*Remote\*\*: Interacts with Firebase for authentication.
 - \*\*Local\*\*: Utilizes SharedPreferences for storing session data.

\#### BLoC Pattern

The authentication feature uses BLoC to manage state changes in the
application. Below is an overview of the events and states managed by
the \`AuthBloc\`.

\##### Events

\- \*\*\`UserIsLogIn\`\*\*: Checks if a user is logged in based on saved
session data. - \*\*\`SignInRequested\`\*\*: Triggers a user login with
email and password. - \*\*\`SignUpRequested\`\*\*: Initiates user
registration with email, password, and role. -
\*\*\`LoadRolesRequested\`\*\*: Fetches user roles from the
repository. - \*\*\`SignOutRequested\`\*\*: Logs the user out and clears
session data. - \*\*\`ReloadState\`\*\*: Reloads the current
authentication state to reflect any changes.

\##### States

\- \*\*\`AuthInitial\`\*\*: The initial state when no authentication
process is active. - \*\*\`AuthLoading\`\*\*: Indicates an ongoing
authentication process. - \*\*\`Authenticated\`\*\*: Represents a
successfully authenticated user. - \*\*\`AuthError\`\*\*: Indicates an
error occurred during authentication, with an error message. -
\*\*\`SignUpRequestedDone\`\*\*: Indicates a successful registration
process. - \*\*\`RolesLoaded\`\*\*: Represents the successful loading of
user roles. - \*\*\`LoggedOut\`\*\*: Indicates the user has successfully
logged out.

\### History Screen (\`4_history\` Feature)

The \*\*History Screen\*\* feature is implemented using the BLoC
architecture and is responsible for managing and displaying historical
runner data.

\#### Architecture Overview

The History feature is structured into three main layers:

1\. \*\*Presentation Layer\*\* 2. \*\*Domain Layer\*\* 3. \*\*Data
Layer\*\*

\#### Presentation Layer

The presentation layer handles the UI state and user interactions. It
uses the BLoC pattern to maintain a clear separation between the
business logic and UI components.

\##### Key Components

\- \*\*BLoC\*\*: \`RunnerHistoryDataBloc\` manages events and states
related to runner data. - \*\*Events\*\*: Define the actions or
interactions that can be performed by the user. - \*\*States\*\*:
Represent the various states of the UI as a result of these events.

\#### Domain Layer

The domain layer contains the core business logic of the application,
encapsulating use cases and interacting with repositories to retrieve or
modify data.

\##### Key Components

\- \*\*Use Cases\*\*: Encapsulate the business logic of the application.
 - \*\*\`GetHistoryData\`\*\*: Retrieves historical runner data.  -
\*\*\`SetHistoryData\`\*\*: Stores runner data.

\#### Data Layer

The data layer is responsible for managing data retrieval and storage,
interfacing with remote and local data sources.

\##### Key Components

\- \*\*Repositories\*\*: Abstract interfaces that define data
operations.  - \*\*Remote Sources\*\*: Handle data operations with
Firebase Storage.

\#### BLoC

Pattern

The History feature utilizes BLoC to manage state changes in the
application. Below is an overview of the events and states managed by
the \`RunnerHistoryDataBloc\`.

\##### Events

\- \*\*\`GetRunnerHistoryData\`\*\*: Fetches historical runner data from
the repository. - \*\*\`UpdateHistoryData\`\*\*: Updates the historical
data in the repository.

\##### States

\- \*\*\`RunnerHistoryDataInitial\`\*\*: The initial state when no
runner data is loaded. - \*\*\`RunnerHistoryDataLoading\`\*\*: Indicates
ongoing retrieval of historical runner data. -
\*\*\`RunnerHistoryDataLoaded\`\*\*: Represents successfully loaded
runner data, along with the data itself. -
\*\*\`RunnerHistoryDataUpdated\`\*\*: Indicates successful update of
runner history data. - \*\*\`RunnerHistoryDataError\`\*\*: Represents an
error that occurred while retrieving or updating runner data.

\#### Example Runner Data Generation

To generate random runner data for testing purposes, you can use the
following code snippet:

\`\`\`dart import \'dart:math\';

void main() { final List\<Map\<String, dynamic\>\> runnerData =
List.generate(10, (index) { final distance = Random().nextDouble() \*
10; // Distance in kilometers final time = Random().nextInt(3600); //
Time in seconds final date = DateTime.now().subtract(Duration(days:
index));

return { \'distance\': distance.toStringAsFixed(2), \'time\': time,
\'date\': date.toIso8601String(), }; });

print(runnerData); } \`\`\`

This code generates a list of runner data with random distances, times,
and dates, useful for testing and demonstration purposes.

\### Store Screen (\`5_store\` Feature)

The Store feature in the Runner App manages the display and purchase of
products within the application, implementing role-based access control
to ensure that different users have access to specific parts of the
store based on their roles.

\#### Architecture Overview

The Store feature is divided into three main layers:

1\. \*\*Presentation Layer\*\* 2. \*\*Domain Layer\*\* 3. \*\*Data
Layer\*\*

\#### Presentation Layer

The presentation layer handles the UI state and interactions, using the
BLoC pattern to separate the business logic from the UI.

\##### Key Components

\- \*\*BLoC\*\*: \`StoreBloc\` manages store-related events and
states. - \*\*Events\*\*: Define the actions or interactions performed
by the user. - \*\*States\*\*: Represent the various states of the UI as
a result of these events.

\#### Domain Layer

The domain layer contains the core business logic of the application,
encapsulating use cases and interacting with repositories to retrieve or
modify data.

\##### Key Components

\- \*\*Entities\*\*: \`ProductEntity\` represents the product data
within the application. - \*\*Use Cases\*\*: Encapsulate the business
logic of the application.  - \*\*\`GetStoreData\`\*\*: Retrieves product
data for the store.  - \*\*\`SetStoreData\`\*\*: Stores new product
data.  - \*\*\`GetRole\`\*\*: Retrieves the role of the current user.

\#### Data Layer

The data layer manages data retrieval and storage, interfacing with
remote and local data sources.

\##### Key Components

\- \*\*Repositories\*\*: Abstract interfaces that define data
operations.  - \*\*Implementation\*\*: \`StoreRepositoryImpl\` handles
data operations with Firebase Firestore.

\#### Role-Based Access Control (RBAC)

The Store feature implements role-based access control to determine
which products are displayed to different users based on their roles.

\##### User Roles

\- \*\*User\*\*: Can view only products marked as popular. -
\*\*Admin\*\*: Can view all products.

Role-based access control is implemented by retrieving the user\'s role
from Firebase Authentication and Firestore, then filtering products
accordingly.

\#### BLoC Pattern

The Store feature uses BLoC to manage state changes in the application.
Below is an overview of the events and states managed by the
\`StoreBloc\`.

\##### Events

\- \*\*\`GetStoreData\`\*\*: Fetches product data from the repository. -
\*\*\`UpdateStoreData\`\*\*: Updates product data in the repository. -
\*\*\`GetRole\`\*\*: Retrieves the role of the current user. -
\*\*\`GetUserData\`\*\*: Fetches user-specific data, including purchased
products.

\##### States

\- \*\*\`StoreInitial\`\*\*: The initial state when no product data is
loaded. - \*\*\`StoreLoading\`\*\*: Indicates ongoing retrieval of
product data. - \*\*\`StoreLoaded\`\*\*: Represents successfully loaded
product data, along with the data itself. - \*\*\`StoreUpdated\`\*\*:
Indicates successful update of store data. - \*\*\`StoreError\`\*\*:
Represents an error that occurred while retrieving or updating store
data. - \*\*\`RoleLoaded\`\*\*: Represents successful retrieval of the
user\'s role.

\### Random Product Data Generation

For testing purposes, you can generate random product data using the
following code snippet:

\`\`\`dart import \'dart:math\';

void main() { final List\<Map\<String, dynamic\>\> productData =
List.generate(10, (index) { final price = Random().nextDouble() \* 100;
// Price in USD final isPopular = Random().nextBool(); // Randomly mark
some products as popular

return { \'name\': \'Product \$index\', \'price\':
price.toStringAsFixed(2), \'isPopular\': isPopular, \'description\':
\'This is a description for Product \$index.\', }; });

print(productData); } \`\`\`

This code generates a list of random product data, including prices and
popularity, which can be used for testing and demonstration.

\## Contributing

We welcome contributions to the Runner App! To contribute, follow these
steps:

1\. \*\*Fork the repository.\*\*

2\. \*\*Create a new branch.\*\*

\`\`\`bash git checkout -b feature/your-feature-name \`\`\`

3\. \*\*Make your changes.\*\*

4\. \*\*Commit your changes.\*\*

\`\`\`bash git commit -m \"Add your message here\" \`\`\`

5\. \*\*Push to your branch.\*\*

\`\`\`bash git push origin feature/your-feature-name \`\`\`

6\. \*\*Create a pull request.\*\*

\## License

This project is licensed under the MIT License. See the
\[LICENSE\](LICENSE) file for more information. \`\`\`

You can save this text as \`documentation.md\` for your project
documentation. If you need further adjustments or have specific
questions, feel free to ask!

