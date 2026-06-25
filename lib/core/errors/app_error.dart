sealed class AppError {
  const AppError();
  String get message;
}

class NetworkError extends AppError {
  final String? details;
  const NetworkError([this.details]);
  @override
  String get message => details ?? 'Network error occurred';
}

class AuthError extends AppError {
  final String? details;
  const AuthError([this.details]);
  @override
  String get message => details ?? 'Authentication error';
}

class ValidationError extends AppError {
  final String? details;
  const ValidationError([this.details]);
  @override
  String get message => details ?? 'Validation error';
}

class DatabaseError extends AppError {
  final String? details;
  const DatabaseError([this.details]);
  @override
  String get message => details ?? 'Database error';
}

class AiApiError extends AppError {
  final String? details;
  const AiApiError([this.details]);
  @override
  String get message => details ?? 'AI API error';
}

class CalendarApiError extends AppError {
  final String? details;
  const CalendarApiError([this.details]);
  @override
  String get message => details ?? 'Calendar API error';
}

class DriveApiError extends AppError {
  final String? details;
  const DriveApiError([this.details]);
  @override
  String get message => details ?? 'Drive API error';
}

class NotificationError extends AppError {
  final String? details;
  const NotificationError([this.details]);
  @override
  String get message => details ?? 'Notification error';
}

class UnknownError extends AppError {
  final String? details;
  const UnknownError([this.details]);
  @override
  String get message => details ?? 'Unknown error';
}
