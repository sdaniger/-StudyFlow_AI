# StudyFlow AI

AI-integrated task management app for learners. Built with Flutter for Android, Web, Windows, and Linux.

## Overview

StudyFlow AI helps students manage their study lifecycle:
- **Tasks**: Create, manage, and complete study tasks
- **Pomodoro Timer**: Focus sessions with customizable timers
- **Habit Tracker**: Build consistent study habits
- **Review Scheduler**: Spaced repetition based on the forgetting curve
- **AI Planner**: Generate study plans from goals (Mock in MVP)
- **Calendar Sync**: Preview and register events (Mock in MVP)
- **Drive Sync**: Backup and restore app data (Mock in MVP)

## Setup

```bash
# Install dependencies
flutter pub get

# Run code generation (freezed/json_serializable)
# dart run build_runner build --delete-conflicting-outputs

# Run on your platform
flutter run
```

## Directory Structure

```
lib/
  core/          # Config, theme, router, responsive, utils
  shared/        # Reusable widgets, layouts, animations
  features/      # Feature modules (tasks, pomodoro, habits, etc.)
  infrastructure/ # Database, API clients (future)
```

## MVP Features

- Task CRUD with subject/priority/filtering
- Pomodoro timer with focus/break modes
- Daily habit tracking with check-in
- Forgetting-curve based review scheduling
- Mock AI study plan generation
- Mock Google Calendar sync UI
- Mock Google Drive backup/restore
- Responsive layout (mobile/tablet/desktop)
- Glassmorphism design system
- Dark mode support

## Tech Stack

- **Flutter** (single codebase)
- **Riverpod** (state management)
- **go_router** (navigation)
- **Material 3** (design)
- **freezed** / **json_serializable** (data classes)
- **Drift** (future database migration)
- **InMemory Repository** (MVP)

## Future Plans

- Real AI API integration (OpenAI, Gemini)
- Google Calendar API integration
- Google Drive appDataFolder sync
- Push notifications
- Cloud sync (Firebase/Supabase)
- Premium features
