# Habit Tracker App

This is a Flutter-based habit tracking application that helps users build consistency and achieve their goals by tracking weekly progress for habits. The app features persistent storage, progress visualization, and a simple user interface.

## Features

1. **Add New Habits**: Users can add habits with a name and a weekly target.
2. **Track Weekly Progress**: A progress bar shows the completion percentage for each habit based on weekly targets.
3. **Delete Habits**: Users can remove habits they no longer want to track.
4. **Persistent Data Storage**: All habit data is stored locally using Hive to ensure that data is preserved even after the app is closed.

## Technologies Used

1. **Flutter**: For building the app's UI and logic.
2. **Hive**: A lightweight, fast, and offline key-value database for persistent storage.
3. **Dart**: The programming language used in Flutter development.

## Project Structure

```
lib/
|-- main.dart            # App entry point
|-- home_page.dart       # Contains the main UI and habit list
|-- habit_tile.dart      # UI component for individual habits
|-- habit_model.dart     # Data model for Habit objects
```

## How It Works

### Adding a New Habit

1. Tap the "+" button on the home screen.
2. Enter the habit name and target weekly frequency in the dialog box.
3. Tap "Save" to add the habit to the list.

### Tracking Progress

1. Each habit displays a progress bar showing the completion percentage.
2. The percentage is calculated as:
   ```dart
   progressPercentage = (completed / completionTarget).clamp(0.0, 1.0) * 100;
   ```

### Deleting a Habit

1. Tap the delete icon next to a habit to remove it.

---

### Home Page

Displays all added habits with their weekly progress.

### Add Habit Dialog

Allows users to input a habit name and target.

---
