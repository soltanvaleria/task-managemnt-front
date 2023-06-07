import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_front/constants/enums.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_front/models/http_config.dart';


class Subtask with ChangeNotifier{
  int? id;
  String? title;
  String? description;
  SubtaskType? type;
  bool? isCompleted;
  DateTime? deadline;
  IconData? iconData;

  factory Subtask.fromJson(dynamic data) {
    var subtask = Subtask.builder(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      type: SubtaskType.values.byName(data['type']),
      deadline: DateTime.parse(data['deadline']),
      isCompleted: data['done']
    );
    if (subtask.type == SubtaskType.CODING) {
      subtask.iconData = Icons.code_rounded; // Exemplu de icon pentru SubtaskType.TYPE_1
    } else if (subtask.type == SubtaskType.TESTING) {
      subtask.iconData = Icons.task_rounded; // Exemplu de icon pentru SubtaskType.TYPE_2
    }
    return subtask;
  }
  Future<void> createSubTask(Subtask subtask, int? taskId) async{
    try{
      final subtaskToJson = {
        'title': subtask.title,
        'description': subtask.description,
        'type': subtask.type?.index,
        'deadline': DateFormat('dd-MM-yyyy HH:mm').format(subtask.deadline!),
        'taskId': taskId,
      };
      await http.post(Uri.http(HttpConfig.domain, '/tasks/subtasks'),
        headers: HttpConfig.headers,
        body: jsonEncode(subtaskToJson),
      );
    }catch (error){
      print(error);
      rethrow;
    }
  }
  Subtask.builder(
      {this.title,
        this.description,
        this.type,
        this.isCompleted,
        this.iconData,
        required this.deadline,
        this.id}
      );
  Subtask(
      {this.title,
      this.description,
      this.type,
      this.isCompleted,
      this.iconData,
      this.id});
  
}
