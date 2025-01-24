import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/habit_model.dart';
import 'package:flutter_application_1/habit_tile.dart';
import 'package:flutter_application_1/notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController habitController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController notiController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  Box<Habit> habitBox = Hive.box<Habit>('mybox'); // Initialized directly

  Notifications notifications = Notifications();

  @override
  void initState() {
    super.initState();
    notifications.initNotifications(); // Initialize notifications
  }

  void saveHabit() {
    final String habitName = habitController.text;
    int target = int.tryParse(targetController.text) ?? 0;

    final newHabit = Habit(
      name: habitName,
      completionTarget: target,
    );

    if (habitBox != null) {
      setState(() {
        habitBox.put(habitName, newHabit);
      });

      // Clear input fields
      habitController.clear();
      targetController.clear();
    }
  }

  void addMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 122, 179, 207),
          title: Text('Add Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: habitController,
                decoration: InputDecoration(labelText: 'Habit Name'),
              ),
              TextField(
                controller: targetController,
                decoration: InputDecoration(labelText: 'Target'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                saveHabit();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void notifyUser() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Notification"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: notiController,
                decoration:
                    InputDecoration(hintText: "Title of the notification"),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(hintText: "Time of notification"),
              )
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  notifications.showNotifications(
                    title: notiController.text,
                    body: timeController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              )
            ],
          );
        });
  }

  void resetWeeklyProgress() {
    if (habitBox != null && habitBox!.isNotEmpty) {
      setState(() {
        for (int i = 0; i < habitBox!.length; i++) {
          final habit = habitBox!.getAt(i);
          if (habit != null) {
            habit.completed = 0; // Reset progress
            habit.save(); // Save the updated habit
          }
        }
      });

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weekly progress has been reset!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No habits to reset.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(
            "Consistency builds character",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 99, 193, 240),
      ),
      backgroundColor: const Color.fromARGB(255, 221, 241, 249),
      body: habitBox.isEmpty
          ? Center(child: Text('No habits added yet.'))
          : HabitTile(),
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: notifyUser,
              backgroundColor: Color.fromARGB(255, 99, 193, 240),
              child: Icon(
                Icons.notifications,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: addMyDialog,
              backgroundColor: Color.fromARGB(255, 99, 193, 240),
              child: Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 100, // Adjust position to avoid overlap
            child: FloatingActionButton(
              onPressed: resetWeeklyProgress,
              backgroundColor: Color.fromARGB(255, 99, 193, 240),
              child: Icon(
                Icons.refresh, // Icon for reset
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
