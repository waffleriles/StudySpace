# StudySpace (iOS)

Native SwiftUI rewrite of the Android StudySpace app: a calendar with
color-coded task categories, and a Pomodoro-style countdown timer.
Requires iOS 17+ (uses SwiftData for persistence, the modern Swift
equivalent of the Room database on the Android side).

## Setting up the Xcode project

This folder only contains Swift source files. Xcode's `.xcodeproj` format
isn't plain portable text, so rather than hand-writing one, create the
project shell yourself in Xcode and drop these files in:

1. Open Xcode → File → New → Project → iOS → App.
2. Product Name: `StudySpace`. Interface: **SwiftUI**. Storage: **SwiftData**.
   Language: **Swift**.
3. Save the project anywhere you like (for example, next to this repo
   checkout, or inside `ios/StudySpace/Xcode/` here).
4. In the generated project, delete the auto-created `ContentView.swift`
   and `Item.swift` — this folder provides equivalents for both.
5. In Finder, drag this directory's `Sources/` folder into Xcode's
   Project Navigator. Check "Copy items if needed" and make sure your
   app target's checkbox is ticked in the dialog.
6. In the target's Build Settings, set the deployment target to **iOS 17.0**.
7. Build and run (`Cmd+R`) on the iOS Simulator, or on a device signed
   in with your Apple ID.

## What's implemented

- **Calendar**: month grid with prev/next navigation, date selection,
  color-coded dots per date based on that day's tasks.
- **Categories**: add with a name + color swatch picker; delete via the
  context menu (long-press / right-click) on a category's name.
- **Tasks**: scoped to a category + specific date; add inline, swipe to
  delete, tap the circle to mark complete (which removes it, same
  behavior as the Android app).
- **Timer**: 25/5/15 min presets or manual H:M:S entry; start/stop/reset.
  Unlike the Android version, the timer schedules a local notification
  for when it finishes, so it still alerts you even if the app is
  backgrounded.

## Known gaps vs. the Android version

- No automated tests yet.
- Visual styling is plain system styling — not yet matched beyond the
  shared category color palette.
