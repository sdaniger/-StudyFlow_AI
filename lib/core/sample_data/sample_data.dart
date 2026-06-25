import 'package:uuid/uuid.dart';
import '../../features/tasks/domain/entities/task.dart';
import '../../features/tasks/domain/entities/task_status.dart';
import '../../features/tasks/domain/entities/task_priority.dart';
import '../../features/habits/domain/entities/habit.dart';
import '../../features/habits/domain/entities/habit_frequency.dart';
import '../../features/review/domain/entities/review_item.dart';
import '../../features/review/domain/entities/review_status.dart';

const _uuid = Uuid();

List<Task> createSampleTasks() {
  final now = DateTime.now();
  return [
    Task(
      id: _uuid.v4(),
      title: '英単語 Unit 1 を25語覚える',
      subject: 'English',
      status: TaskStatus.todo,
      priority: TaskPriority.high,
      dueDate: now.add(const Duration(days: 1)),
      estimatedMinutes: 30,
      createdAt: now,
      updatedAt: now,
    ),
    Task(
      id: _uuid.v4(),
      title: '数学の二次関数を3問解く',
      subject: 'Mathematics',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      dueDate: now.add(const Duration(days: 1)),
      estimatedMinutes: 45,
      createdAt: now,
      updatedAt: now,
    ),
    Task(
      id: _uuid.v4(),
      title: '物理の力学ノートを復習する',
      subject: 'Physics',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      dueDate: now.add(const Duration(days: 2)),
      estimatedMinutes: 60,
      createdAt: now,
      updatedAt: now,
    ),
  ];
}

List<ReviewItem> createSampleReviewItems() {
  final now = DateTime.now();
  final learnedAt = now.subtract(const Duration(days: 1));
  return [
    ReviewItem(
      id: _uuid.v4(),
      sourceTaskId: 'sample-1',
      title: '英単語 Unit 1 復習',
      subject: 'English',
      learnedAt: learnedAt,
      nextReviewAt: now,
      reviewCount: 1,
      status: ReviewStatus.scheduled,
      createdAt: now,
      updatedAt: now,
    ),
    ReviewItem(
      id: _uuid.v4(),
      sourceTaskId: 'sample-2',
      title: '二次関数の解法復習',
      subject: 'Mathematics',
      learnedAt: learnedAt,
      nextReviewAt: now,
      reviewCount: 1,
      status: ReviewStatus.scheduled,
      createdAt: now,
      updatedAt: now,
    ),
  ];
}

List<Habit> createSampleHabits() {
  final now = DateTime.now();
  return [
    Habit(
      id: _uuid.v4(),
      title: '毎日英単語',
      subject: 'English',
      frequency: HabitFrequency.daily,
      targetCount: 1,
      createdAt: now,
      updatedAt: now,
    ),
    Habit(
      id: _uuid.v4(),
      title: '数学を1問解く',
      subject: 'Mathematics',
      frequency: HabitFrequency.daily,
      targetCount: 1,
      createdAt: now,
      updatedAt: now,
    ),
    Habit(
      id: _uuid.v4(),
      title: '10分読書',
      frequency: HabitFrequency.daily,
      targetCount: 1,
      createdAt: now,
      updatedAt: now,
    ),
  ];
}
