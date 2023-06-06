import 'package:flutter/material.dart';
import '../../models/task.dart';
import 'newTask/newSubtaskForm.dart';

class DetailPage extends StatefulWidget {
  final Task task;

  DetailPage(this.task);

  State<DetailPage> createState() => _DetailPage(this.task);
}

class _DetailPage extends State<DetailPage> {
  final Task task;

  _DetailPage(this.task);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort_rounded),
                iconSize: 35,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Deadline') {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2024),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        // Procesează data selectată
                      }
                    });
                  } else if (value == 'Type') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildTypeDialog(context),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Type',
                      child: Text('Type'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Deadline',
                      child: Text('Deadline'),
                    ),
                  ];
                },
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ],
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: task.subtasksList?.length,
              itemBuilder: (context, index) {
                var subtask = task.subtasksList![index];
                return CheckboxListTile(
                  title: Text(
                    '${subtask.title}',
                    style: subtask.isCompleted == true
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)
                        : TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${subtask.deadline?.day}-${subtask.deadline?.month}-${subtask.deadline?.year}',
                        style: subtask.isCompleted == true
                            ? TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                      ),
                      Text(
                        '${subtask.description}',
                        style: subtask.isCompleted == true
                            ? TextStyle(decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                    ],
                  ),
                  value: subtask.isCompleted ?? false,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                          } else if (value == 'delete') {}
                        },
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
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
                          color: Colors.grey,
                          size: 35,
                        ),
                      ),
                      Icon(
                        subtask.iconData,
                        color:
                            subtask.isCompleted == true ? null : Colors.black,
                        size: 35,
                      ),
                    ],
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      subtask.isCompleted = value;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewSubtaskForm()));
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            iconSize: 40,
          ),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title} tasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'You have ${task.left} tasks for today!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home_rounded)),
            BottomNavigationBarItem(
                label: 'Person', icon: Icon(Icons.person_rounded)),
          ],
        ),
      ),
    );
  }

  _buildTypeDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Select Type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Coding'),
            onTap: () {
              // Procesează selecția tipului Coding
              print('Selected type: Coding');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Testing'),
            onTap: () {
              // Procesează selecția tipului Testing
              print('Selected type: Testing');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
