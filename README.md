# ☀️ WeatherWise: An iOS Weather Forecast App

## Project Description

WeatherWise is a modern iOS application designed to provide users with **real-time weather information** for their current location and the ability to search for weather conditions in specific cities worldwide. It offers a comprehensive overview of today's weather and an upcoming weekly forecast on the main screen, with a dedicated detail screen providing **in-depth information** for any selected day, including an hourly forecast chart.

This project was developed as a technical assessment for an iOS Developer position, focusing on demonstrating strong **Swift coding practices**, adherence to **architectural patterns (MVVM)**, and building a small, clean, and maintainable product.

## Features

  * **Current Location Weather:** Automatically displays weather conditions for the user's current geographical location upon app launch.
  * **Location Search:** Allows users to search for weather forecasts in any desired city globally.
  * **Main Screen Overview:**
      * Displays current city name, today's temperature, and concise weather conditions (e.g., "Sunny," "Partly Cloudy," "Rain").
      * Presents a list of the upcoming 7-day weather forecast (overview only).
  * **Detailed Forecast Screen:**
      * Accessible by tapping on any day (today, tomorrow, etc.) from the main screen.
      * Provides in-depth weather metrics: **wind speed, humidity, atmospheric pressure, and visibility**.
      * **Bonus:** Includes an **hourly forecast chart** for the selected day, offering a visual representation of temperature changes throughout the hours.

-----

## API Used

This application leverages the **OpenWeatherMap API** ([https://openweathermap.org/api](https://openweathermap.org/api)) for fetching all weather-related data. The free tier of their API provides sufficient data for all implemented features.

-----

## Architecture

The application is built using the **MVVM (Model-View-ViewModel)** architectural pattern.

  * **Models:** Represent the raw data structures directly mapped from the OpenWeatherMap API responses.
  * **Views:** Responsible solely for displaying UI elements and reacting to user interactions. They observe changes in their corresponding ViewModels.
  * **View Models:** Act as an abstraction of the View, containing all the presentation logic. They transform model data into a format consumable by the Views, handle business logic, and expose data through observable properties.

This choice allows for **clear separation of concerns**, improved **testability** of business logic, and easier collaboration on UI and logic independently, leading to a more robust and maintainable codebase.

-----

## Technologies Used

  * **Swift 6.0**
  * **SwiftUI** (chosen for its declarative syntax, rapid UI development, and natural fit with MVVM)
  * **Charts Framework (Apple's)** (for rendering the hourly forecast chart on the detail screen)

-----


## Bonus Points Addressed

  * **Adaptive Layout:** The UI is designed with SwiftUI's intrinsic layout system, ensuring it adapts gracefully across various iOS device form factors (iPhone, iPad) and orientations (portrait, landscape) without requiring manual constraint adjustments.
  * **Unit Testing:** Basic unit tests are included for key ViewModels and the networking service to ensure the reliability and correctness of the application's core logic and data handling.

-----

## Future Improvements / Considerations

  * **Persistent Storage:** Implement Core Data or SwiftData for caching weather data to allow offline access.
  * **User Favorites:** Allow users to save favorite locations for quick access.
  * **Notifications:** Implement local notifications for daily weather summaries.
  * **More Advanced Charting:** Explore more advanced charting libraries for richer data visualization.