# StudySpace
Your helper for improving productivity as a student.

# Introduction
StudySpace is a productivity application targeted towards students. The app consists of three key features: a calendar for deadline tracking and scheduling, a task list, and a Pomodoro study timer.  As academic tools increasingly become digital, StudySpace combines all your study tools on one digitized platform allowing all your digital learning materials to coexist in one place. This application was developed in Kotlin on Android Studio, and can be run from a phone or phone emulator. Each instance of the application will also have to connect to its own SQLite database that stores information about tasks and taks categories.

# Visual Demonstration
https://youtu.be/arqrQT-Kxzk

# User Instructions

## Overview
This app combines a simple daily task organizer with a built‑in countdown timer. Users can select dates on a calendar, create categories, add tasks for specific days and run a timer without leaving the app.

---

## Calendar Screen

### Opening the App
The app launches directly to the **Calendar** screen.

### Selecting Dates
- Tap any date to view tasks assigned to that day.
- Use the **<** and **>** icons to switch between months.
- Categories appear on every date, but **tasks are tied to the selected date**.

### Categories
- Tap the **+** button to create a new category.
- Categories appear across all dates.
- Long‑press a category name to delete it.
- Categories cannot be renamed.

### Tasks
- Add tasks under any category for the selected date.
- Tasks belong only to the date they were created on.
- Tap the circle icon next to a task to complete and immediately delete it.
- Tasks cannot be deleted manually except by completing them.

### Navigation
- Tap **Go to Timer** to switch to the Timer screen.

---

## Timer Screen

### Setting the Timer
You can set the countdown in two ways:

#### Preset Buttons
- **25 min**
- **5 min**
- **15 min**

Tapping a preset instantly fills the timer with that value.

#### Manual Entry
Enter hours, minutes, and seconds directly into the **HH : MM : SS** fields.

### Running the Timer
- Tap **Start** to begin the countdown.
- Tap **Reset** to clear the timer and enter a new value.
- The timer continues running even if you switch back to the Calendar screen.
- The timer does not prevent the phone from sleeping.
- The app does not send notifications or alerts when the timer finishes.

### Navigation
- Tap **Go to Calendar** to return to the Calendar screen.

---

## Requirements
- No runtime permissions required.
- Minimum Android version: **Android 7.0 (API 24)**. Target/compile SDK: **35**.


# Developer Instructions

This is a native Android app written in Kotlin, built with Gradle — there is no Node/npm toolchain involved.

## Project Structure
The entire app lives in the `PersistentTimerApp/` directory, which is the Gradle project root:
- `PersistentTimerApp/app/src/main/java/com/example/persistenttimerapp/` — Kotlin source
  - `StudySpaceMainActivity.kt` — Calendar + task list screen (the app's launch screen)
  - `TimerActivity.kt` — Pomodoro timer screen
  - `DataHelper.kt` — SharedPreferences-backed timer state
  - `data/` — Room database (`AppDatabase.kt`, `AppDao.kt`), entities (`Task.kt`, `Category.kt`), and `StudyViewModel.kt`
- `PersistentTimerApp/app/src/main/res/` — layouts, drawables, and string/color resources

## How to build and run locally
### Option A: Android Studio (recommended)
1. Install [Android Studio](https://developer.android.com/studio).
2. Clone the repository: `git clone https://github.com/waffleriles/StudySpace.git`
3. Open `PersistentTimerApp/` (not the repo root) as the project in Android Studio.
4. Let Gradle sync finish, then click **Run** with an emulator or a connected device selected.

### Option B: Command line
1. Clone the repository and `cd PersistentTimerApp`.
2. Build a debug APK: `./gradlew assembleDebug` (use `gradlew.bat` on Windows).
3. Install it on a connected device/emulator: `./gradlew installDebug`.
4. Run unit tests: `./gradlew test`.

## Requirements to build
- JDK 11+ (bundled with recent Android Studio versions).
- Android SDK with `compileSdk` 35 installed (Android Studio's SDK Manager handles this automatically).
- No API keys, environment variables, or backend services are required — the app only reads/writes a local SQLite database via Room.

## Modifications
- **UI / screens**: Edit the Activities in `app/src/main/java/com/example/persistenttimerapp/` and their matching layout XML in `app/src/main/res/layout/`.
- **Data model**: Add or change fields on `Task`/`Category` under `data/entities/`, and update queries in `AppDao.kt`.
- **Business logic**: `StudyViewModel.kt` is where new operations on tasks/categories should live; Activities call into it rather than touching the DAO directly.
- **Dependencies**: Add libraries in `PersistentTimerApp/app/build.gradle.kts`, or update versions in `PersistentTimerApp/gradle/libs.versions.toml`.

# Known Issues and Future Expansion
## Account Security
Implementing an account and security feature that allows users to login and save any of their tasks to their account. Adding security also allows account security within our application.
## Improved UI/UX
Conducting thorough user research to identify pain points for users and create better experience for student productivity.
## Lock Feature
Adding a lock feature where once you start your study session, notifications are disabled. As well as making apps that the user selects to be disabled while in the session.
## Web App Capability
Creating a browser version for web accessibility so users can access their productivity tools even without their phones.
