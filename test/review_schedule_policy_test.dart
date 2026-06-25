import 'package:flutter_test/flutter_test.dart';
import 'package:studyflow_ai/features/review/domain/services/review_schedule_policy.dart';

void main() {
  group('ReviewSchedulePolicy', () {
    test('generates correct review dates', () {
      final policy = ReviewSchedulePolicy();
      final learnedAt = DateTime(2026, 6, 26);

      int counter = 0;
      final items = policy.generateSchedule(
        sourceTaskId: 'task-1',
        title: 'Test Review',
        learnedAt: learnedAt,
        generateId: () {
          counter++;
          return 'id-$counter';
        },
      );

      expect(items.length, 5);
      expect(items[0].nextReviewAt, DateTime(2026, 6, 27));
      expect(items[1].nextReviewAt, DateTime(2026, 6, 29));
      expect(items[2].nextReviewAt, DateTime(2026, 7, 3));
      expect(items[3].nextReviewAt, DateTime(2026, 7, 10));
      expect(items[4].nextReviewAt, DateTime(2026, 7, 26));
    });

    test('increments review count', () {
      final policy = ReviewSchedulePolicy();
      final items = policy.generateSchedule(
        sourceTaskId: 'task-1',
        title: 'Test',
        learnedAt: DateTime(2026, 6, 26),
        generateId: () => 'id',
      );

      expect(items[0].reviewCount, 1);
      expect(items[1].reviewCount, 2);
      expect(items[2].reviewCount, 3);
      expect(items[3].reviewCount, 4);
      expect(items[4].reviewCount, 5);
    });
  });
}
