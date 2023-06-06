import 'package:flutter/material.dart';

import '../../constants/enums.dart';
import '../../models/task.dart';

class NewTaskForm extends StatefulWidget {
  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  Task _task = Task();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPriority() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Priority',
              style: TextStyle(fontSize: 25, color: Colors.grey[700])),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_task.priority == Priority.HIGH) {
                        _task.priority =
                            null; // Deselect the item if it's already selected
                      } else {
                        _task.priority = Priority.HIGH;
                      }
                    });
                  },
                  child: RadioListTile(
                    value: Priority.HIGH,
                    groupValue: _task.priority,
                    onChanged: null,
                    title: Text('High'),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_task.priority == Priority.MEDIUM) {
                        _task.priority =
                            null; // Deselect the item if it's already selected
                      } else {
                        _task.priority = Priority.MEDIUM;
                      }
                    });
                  },
                  child: RadioListTile(
                    value: Priority.MEDIUM,
                    groupValue: _task.priority,
                    onChanged: null,
                    title: Text('Medium'),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_task.priority == Priority.LOW) {
                        _task.priority =
                            null; // Deselect the item if it's already selected
                      } else {
                        _task.priority = Priority.LOW;
                      }
                    });
                  },
                  child: RadioListTile(
                    value: Priority.LOW,
                    groupValue: _task.priority,
                    onChanged: null,
                    title: Text('Low'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      style: TextStyle(fontSize: 25),
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Title is required';
        }
        return null; // Return null to indicate no validation error
      },
      onSaved: (String? value) {
        if (value != null) {
          _task.title = value;
        }
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      style: TextStyle(fontSize: 25),
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Description is required';
        }
        return null; // Return null to indicate no validation error
      },
      onSaved: (String? value) {
        if (value != null) {
          _task.description = value;
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitleField(),
              _buildDescriptionField(),
              _buildPriority(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          _formKey.currentState!.save();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
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
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        'Adding New Task',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
      centerTitle: true,
    ),
  );
}
