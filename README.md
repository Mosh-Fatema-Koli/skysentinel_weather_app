SkySentinel Weather Alerter
1. Project Title and Description

SkySentinel is a Flutter mobile application that monitors the user’s current location weather and sends alerts for specific conditions, such as rain or extreme heat. It includes a daily weather dashboard, a 5-day forecast, and customizable weather alerts.

2. Project Structure / Approaches

Architecture: Layered architecture with separation of UI, Cubit (state management), Repository (data handling), and Services (API, Notifications, Location).

Cubits Used:

LocationCubit – Handles GPS permission and coordinates fetching.
WeatherCubit – Fetches current weather and 5-day forecast using OpenWeatherMap API.
SettingsCubit – Manages user-defined alert thresholds like temperature or rain notifications.

Folder Structure:

lib/
 ├─ main.dart
 ├─ blocs/
 │   ├─ weather_cubit.dart
 │   ├─ weather_state.dart
 │   ├─ location_cubit.dart
 │   ├─ location_state.dart
 │   ├─ settings_cubit.dart
 │   └─ settings_state.dart
 ├─ models/
 │   └─ weather_model.dart
 ├─ repository/
 │   └─ weather_repository.dart
 ├─ services/
 │   ├─ weather_api.dart
 │   └─ notification_service.dart
 ├─ screens/
 │   ├─ dashboard_screen.dart
 │   ├─ forecast_screen.dart
 │   └─ alert_screen.dart
 └─ utils/
     └─ constants.dart
3. Generative AI Usage

Generative AI tools were used primarily for debugging and troubleshooting issues during development. These tools helped identify configuration problems, dependency conflicts, and plugin integration errors.

4. How to Run
Clone the repository:
git clone https://github.com/<your-username>/skysentinel.git
cd skysentinel
Install dependencies:
flutter pub get
Ensure Android setup:
Minimum SDK: 21
NDK Version: 27.0.12077973
Java Version: 11
Run the app:
flutter run
Build APK for release (optional):
flutter build apk --release
