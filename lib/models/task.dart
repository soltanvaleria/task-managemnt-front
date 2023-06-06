import 'package:task_management_front/models/subtasks.dart';
import 'package:flutter/material.dart';
import 'package:task_management_front/constants/colors.dart';

import '../constants/enums.dart';

class Task {
  String? title;
  String? description;
  Priority? priority;
  num? left;
  num? done;
  Color? darkColor;
  Color? lightColor;
  List<Subtask>? subtasksList;

  Task(
      {this.title,
      this.description,
      this.priority,
      this.left,
      this.done,
      this.subtasksList,
      this.darkColor,
      this.lightColor});

  static List<Task> generateTasks() {
    List<Task> tasks = [
      Task(
          title: 'Personal',
          left: 1,
          done: 1,
          priority: Priority.LOW,
          subtasksList: Subtask.generateSubtasks()),
      Task(
          title: 'Work',
          left: 0,
          done: 3,
          priority: Priority.HIGH,
          subtasksList: Subtask.generateSubtasks()),
      Task(
          title: 'Work',
          left: 0,
          done: 3,
          subtasksList: Subtask.generateSubtasks()),
      Task(
          title: 'Work',
          left: 0,
          done: 3,
          priority: Priority.MEDIUM,
          subtasksList: Subtask.generateSubtasks()),
    ];
    for (Task task in tasks) {
      task.setColorsByPriority();
    }

    return tasks;
  }

  void setColorsByPriority() {
    switch (priority) {
      case Priority.HIGH:
        darkColor = highRedDark;
        lightColor = highRedLight;
        break;
      case Priority.MEDIUM:
        darkColor = mediumRedDark;
        lightColor = mediumRedLight;
        break;
      case Priority.LOW:
        darkColor = lowGreenDark;
        lightColor = lowGreenLight;
        break;
      default:
        darkColor = kBlueDark;
        lightColor = kBlueLight;
        break;
    }
  }
}
