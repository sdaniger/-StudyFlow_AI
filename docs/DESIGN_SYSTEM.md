# Design System

## Concept: Opera Air-inspired Glassmorphism

- Translucent cards with blur effect
- Soft gradients
- Frosted glass aesthetics
- Minimal and calm visual hierarchy
- Dark mode support

## Color Palette

| Token | Light | Dark |
|-------|-------|------|
| Primary | `#8EA7FF` | `#8EA7FF` |
| Secondary | `#B8E7FF` | `#B8E7FF` |
| Accent | `#D7C7FF` | `#D7C7FF` |
| Background | `#F5F8FF` | `#10131F` |
| Surface | `#FFFFFF` (glass) | `#1A1D2E` (glass) |
| Text | `#1D2433` | `#F3F6FF` |
| Text Secondary | `#6B7280` | `#9CA3AF` |

## Typography

- Headlines: Bold, 20-32px
- Body: Regular, 14-16px
- Labels: Medium weight, 12-14px
- All sizes respect `AppTextStyles` in `core/theme/`

## Spacing

| Token | Size |
|-------|------|
| xs | 4px |
| sm | 8px |
| md | 16px |
| lg | 24px |
| xl | 32px |
| xxl | 48px |
| xxxl | 64px |

## Border Radius

| Token | Size |
|-------|------|
| sm | 8px |
| md | 12px |
| lg | 16px |
| xl | 24px |
| xxl | 32px |
| full | 999px |

## Shared Widgets

### GlassCard / GlassContainer
- Frosted glass background with border
- Configurable padding, margin, border radius
- Optional tap handler for interactivity

### GradientBackground
- Linear gradient background
- Adapts to light/dark mode

### PrimaryActionButton / SecondaryActionButton
- Filled (primary) and outlined (secondary) variants
- Loading state with spinner
- Icon support

### StatCard
- Dashboard metric display
- Icon + value + label

### TaskTile, HabitCheckTile, ReviewItemTile
- Consistent list item patterns
- Checkbox/circle completion toggle
- Priority/subject badges

### PomodoroTimerCircle
- Large circular timer with progress ring
- Pulse animation when running
- Play/pause/reset controls

### AiSuggestionCard, CalendarEventDraftCard, DriveSyncStatusCard
- Feature-specific information cards
- Action buttons for confirm/cancel/edit

## Responsive Layout

| Breakpoint | Layout |
|------------|--------|
| < 600px (mobile) | BottomNavigationBar |
| 600-1024px (tablet) | NavigationRail |
| >= 1024px (desktop) | NavigationRail + expanded content |
