import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_management_front/models/subtask_list.dart';
import 'package:task_management_front/models/subtasks.dart';
import 'package:task_management_front/screens/home/home.dart';

import 'models/task.dart';
import 'models/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskList()),
        ChangeNotifierProvider(create: (context) => Task()),
        ChangeNotifierProvider(create: (context) => Subtask()),
        ChangeNotifierProvider(create: (context) => SubtaskList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TaskManagement',
        home: HomePage(), //HomePage(),
      ),
    );
  }
}
