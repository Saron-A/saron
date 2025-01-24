import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/habit_model.dart';

class HabitTile extends StatefulWidget {
  const HabitTile({super.key});

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  final habitList = Hive.box<Habit>('mybox');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habitList.length,
      itemBuilder: (context, index) {
        Habit habits = habitList.getAt(index) as Habit;

        double progress;
        if (habits.completionTarget == 0) {
          progress = 0; // No progress if target is 0
        } else {
          progress = habits.completed / habits.completionTarget;
        }
        return ListTile(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  habitList.deleteAt(index);
                });
              },
              icon: const Icon(Icons.remove)),
          title: Text(habits.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: progress, // Value between 0.0 and 1.0
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}% completed - ${habits.completed}/${habits.completionTarget}',
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                if (habits.completed < habits.completionTarget) {
                  habits.completed++;
                  habits.save();
                }
              });
            },
          ),
        );
      },
    );
  }
}
