import '../errors/app_error.dart';

sealed class AppResult<T> {
  const AppResult();
}

class AppSuccess<T> extends AppResult<T> {
  final T data;
  const AppSuccess(this.data);
}

class AppFailure<T> extends AppResult<T> {
  final AppError error;
  const AppFailure(this.error);
}
