# Weather App - Flutter

This is a simple Weather App built using Flutter, leveraging the OpenWeatherMap API to fetch and display weather information.

## Overview

The app allows users to see current weather conditions for a specified location. It utilizes the OpenWeatherMap API for real-time weather data.

## Prerequisites

* Flutter SDK (version 3.27.2)
* An OpenWeatherMap API key

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone <repository_url>
    cd <repository_directory>
    git checkout b development
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Add your OpenWeatherMap API key:**

    * Open the file `lib/core/api/api_helpers.dart`.
    * Replace `YOUR_API_KEY` with your actual API key:

        ```dart
        class ApiHelpers {
          static const String apiKey = 'YOUR_API_KEY'; // Replace with your API key
          // ... other code
        }
        ```

    * **Important:**
        * To obtain an API key, you need to create an account on OpenWeatherMap: [OpenWeatherMap Registration](https://openweathermap.org/).
        * After creating an account, you can find your API keys here: [OpenWeatherMap API Keys](https://home.openweathermap.org/api_keys).

4.  **Run the app:**

    * Connect a physical device or start an emulator.
    * Run the following command:

        ```bash
        flutter run
        ```

## Flutter SDK Version

This app was developed using Flutter SDK version **3.27.2**. Ensure you have the same version installed to avoid compatibility issues. You can check your Flutter version by running:

```bash
flutter --version