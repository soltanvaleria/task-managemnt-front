import 'package:flutter/material.dart';
import 'package:task_management_front/constants/enums.dart';

import '../constants/colors.dart';

class Subtask{
  String? title;
  String? description;
  SubtaskType? type;
  bool?  isCompleted;
  DateTime? deadline;
  IconData? iconData;


  Subtask({this.title, this.description, this.type,
      this.isCompleted, this.deadline, this.iconData});

  static List<Subtask> generateSubtasks() {
    return [
      Subtask(
        title: 'First',
        deadline: DateTime.now(),
        description: "SJHGFGHJHGFCGHJHGHHGHJHG",
        iconData: Icons.code_rounded,
        type: SubtaskType.CODDING
      ),
      Subtask(
        title: 'Second',
        deadline: DateTime.now(),
        description: "SJHGFGHJHGFCGHJHGHHGHJHG",
        iconData: Icons.find_in_page_rounded,
        type: SubtaskType.TESTING

      ),

    ];
  }
}