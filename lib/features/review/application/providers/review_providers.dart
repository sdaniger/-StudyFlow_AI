import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/in_memory_review_repository.dart';
import '../../domain/repositories/review_repository.dart';
import '../../domain/services/review_schedule_policy.dart';
import '../usecases/create_review_items_for_task_usecase.dart';
import '../usecases/complete_review_usecase.dart';
import '../usecases/get_today_review_items_usecase.dart';
import '../../../../core/sample_data/sample_data.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return InMemoryReviewRepository(initialData: createSampleReviewItems());
});

final reviewSchedulePolicyProvider = Provider<ReviewSchedulePolicy>((ref) {
  return ReviewSchedulePolicy();
});

final createReviewItemsForTaskUseCaseProvider =
    Provider<CreateReviewItemsForTaskUseCase>((ref) {
  return CreateReviewItemsForTaskUseCase(
    ref.watch(reviewRepositoryProvider),
    ref.watch(reviewSchedulePolicyProvider),
  );
});

final completeReviewUseCaseProvider = Provider<CompleteReviewUseCase>((ref) {
  return CompleteReviewUseCase(ref.watch(reviewRepositoryProvider));
});

final getTodayReviewItemsUseCaseProvider =
    Provider<GetTodayReviewItemsUseCase>((ref) {
  return GetTodayReviewItemsUseCase(ref.watch(reviewRepositoryProvider));
});

final todayReviewItemsProvider = FutureProvider.autoDispose((ref) async {
  final useCase = ref.watch(getTodayReviewItemsUseCaseProvider);
  return useCase.execute();
});
