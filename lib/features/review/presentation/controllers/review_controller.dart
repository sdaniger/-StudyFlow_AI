import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/review_item.dart';
import '../../application/providers/review_providers.dart';

class ReviewController {
  final Ref _ref;

  ReviewController(this._ref);

  Future<void> completeReview(ReviewItem item, int confidence) async {
    final useCase = _ref.read(completeReviewUseCaseProvider);
    await useCase.execute(item, confidence);
    _ref.invalidate(todayReviewItemsProvider);
  }
}

final reviewControllerProvider = Provider<ReviewController>((ref) {
  return ReviewController(ref);
});
