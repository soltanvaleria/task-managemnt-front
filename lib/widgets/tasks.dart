import 'package:flutter/material.dart';
import 'package:task_management_front/constants/colors.dart';
import 'package:task_management_front/screens/detail/detail.dart';

import '../models/task.dart';

class Tasks extends StatelessWidget {
  final List<Task> tasksList = Task.generateTasks();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: tasksList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => _buildTask(context, tasksList[index]),
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(task)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: task.lightColor,
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.task_rounded,
                      color: task.darkColor,
                      size: 45,
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'description') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Subtask Description'),
                                content: Text(task.description ?? ""),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (value == 'clone') {
                        } else if (value == 'edit') {
                        } else if (value == 'delete') {}
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'description',
                            child: Text('See description'),
                          ),
                          PopupMenuItem<String>(
                            value: 'clone',
                            child: Text('Clone'),
                          ),
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: task.darkColor,
                        size: 35,
                      ),
                    ),
                  ],
                ), // Icon
                SizedBox(height: 30),
                Text(
                  task.title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    _buildTaskStatus(task.darkColor ?? Colors.black,
                        task.lightColor ?? Colors.black, '${task.left} left'),
                    SizedBox(width: 5),
                    _buildTaskStatus(Colors.white,
                        task.darkColor ?? Colors.black, '${task.done} done'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: txColor),
      ),
    );
  }
}
