import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int frequency;

  @HiveField(2)
  int completionTarget;

  @HiveField(3)
  int completed;

  Habit({
    required this.name,
    this.frequency = 0,
    required this.completionTarget,
    this.completed = 0,
  });

  double get progressPercentage {
    if (completionTarget == 0) {
      return 0;
    } else {
      return (completed / completionTarget).clamp(0.0, 1.0) * 100;
    }
  }
}
