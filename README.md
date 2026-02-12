# City Events Explorer

A Flutter application to browse, search, and bookmark city events. Built as a coding challenge for DRIBBA.

This project showcases a clean, scalable, and testable Flutter application architecture.

## Features

- **Browse Events**: Scroll through a list of upcoming events with lazy loading for a smooth user experience.
- **Search**: Find events by name with a debounced search input.
- **Filter**: Filter events by a specific date range.
- **Favorites**: Save your favorite events, which persist locally across app restarts.
- **Event Details**: View complete event details, including a full description and a static map preview of the location.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- You need to have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (stable channel).

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/your-username/city_events_explorer.git
   ```

2. **Navigate to the project directory:**
   ```sh
   cd city_events_explorer
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Run the application:**
   ```sh
   flutter run
   ```

## Architecture

The project follows the principles of **Clean Architecture**, separating the code into three main layers:

- **Data**: Contains the data sources (local JSON file) and repository implementations.
- **Domain**: Includes the business logic, entities, and repository interfaces. This layer is independent of any framework.
- **Presentation**: Holds the UI (Widgets) and state management logic (Providers), organized by feature.

This layered approach ensures a clear separation of concerns, making the app easier to test, maintain, and scale.

## Tech Stack & Libraries

- **State Management**: `flutter_riverpod` for its compile-safe dependency injection and robust state management capabilities.
- **Navigation**: `go_router` for a declarative, URL-based routing solution.
- **Local Persistence**: `shared_preferences` for storing favorite events.
- **Testing**: `flutter_test`, `mocktail` for unit and widget testing.
- **CI/CD**: GitHub Actions to ensure code quality with every commit.
