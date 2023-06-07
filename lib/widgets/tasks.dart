import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_front/models/task_list.dart';
import 'package:task_management_front/screens/detail/detail.dart';

import '../models/task.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskListProvider = Provider.of<TaskList>(context);
    taskListProvider.fetchTaskList();
    final tasksList = taskListProvider.getTaskList;
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: tasksList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => _buildTask(context, tasksList[index]),
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    final taskProvider = Provider.of<Task>(context);
    deleteTask() async{
      try{
        await taskProvider.deleteTask(task.id);
        Navigator.of(context).pop();
      }catch (error){
        print(error);
      }
    }

    cloneTask() async{
      try{
        await taskProvider.clone(task.id);
      }catch (error){
        print(error);
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(task)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: task.lightColor,
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
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
                                title: const Text('Subtask Description'),
                                content: Text(task.description ?? ""),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (value == 'clone') {
                          cloneTask();
                        } else if (value == 'edit') {
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                    onPressed: deleteTask,
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'description',
                            child: Text('See description'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'clone',
                            child: Text('Clone'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
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
                const SizedBox(height: 30),
                Text(
                  task.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildTaskStatus(task.darkColor ?? Colors.black,
                        task.lightColor ?? Colors.black, '${task.left} left'),
                    const SizedBox(width: 5),
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
