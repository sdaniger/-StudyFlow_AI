# Architecture

## Clean Architecture + Feature-first Modules

```
Presentation Layer (UI/Screens/Widgets/Controllers/Providers)
    ↓ depends on
Application Layer (UseCases/Services)
    ↓ depends on
Domain Layer (Entities/Repository Interfaces/Services) ← NO external dependencies
    ↑ implemented by
Data Layer (Repository Implementations/DTO/Mappers/Data Sources)
    ↓ depends on
Infrastructure Layer (Drift/HTTP/AI/Calendar/Drive/Notification)
```

## Key Rules

1. **Domain is pure Dart** - No Flutter, Drift, HTTP, or Google API dependencies
2. **Interface in Domain, Implementation in Data** - Repository interfaces live in `domain/repositories/`
3. **Offline-first** - Local DB is the source of truth; remote is sync-only
4. **Dependency direction always points to Domain** - UI, Application, Data all depend on Domain, never vice versa

## Offline-first Design

- InMemory repositories for MVP
- Drift/SQLite for production
- Sync queue for pending changes
- `updatedAt` timestamps on all entities for conflict resolution

## Feature Structure

Each feature follows the same four-layer pattern:

```
feature_name/
  domain/
    entities/      # Business models (freezed/equatable)
    repositories/  # Abstract interfaces
  application/
    usecases/      # Business logic operations
    providers/     # Riverpod providers for DI
  data/
    repositories/  # Concrete implementations (InMemory/Drift/API)
    dto/           # Data transfer objects
    mappers/       # Entity <-> DTO mappers
  presentation/
    screens/       # Full-page widgets
    widgets/       # Feature-specific widgets
    controllers/   # State management (StateNotifier/ChangeNotifier)
```

## Data Flow Example: Task Completion

```
User taps complete
  → TaskController.completeTask()
    → CompleteTaskUseCase.execute()
      → TaskRepository.update() (marks done)
      → ReviewSchedulePolicy.generate() (creates review schedule)
      → ReviewRepository.saveAll() (saves review items)
```

## External Service Abstraction

All external services (AI, Calendar, Drive, Notifications) are behind interfaces:

- `AiPlannerRepository` → `MockAiPlannerRepository` / `RealAiPlannerRepository`
- `CalendarRepository` → `MockCalendarRepository` / `GoogleCalendarRepository`
- `DriveSyncRepository` → `MockDriveSyncRepository` / `GoogleDriveRepository`
- `NotificationRepository` → `LocalNotificationRepository` / `PushNotificationRepository`
