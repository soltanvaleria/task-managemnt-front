import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/enums.dart';
import '../../../models/subtasks.dart';

class NewSubtaskForm extends StatefulWidget {
  final int? taskId;

  const NewSubtaskForm({super.key, required this.taskId});
  @override
  State<NewSubtaskForm> createState() => _NewSubtaskFormState();
}

class _NewSubtaskFormState extends State<NewSubtaskForm> {
  Subtask _subtask = Subtask();

  TextEditingController _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          _subtask.title = value;
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
          _subtask.description = value;
        }
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Colors.blue, // Customize the header color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _subtask.deadline) {
      setState(() {
        _subtask.deadline = picked;
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(_subtask.deadline!);
      });
    }
  }

  void _clearDate() {
    setState(() {
      _dateController.clear();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Widget _buildDeadline() {
    return Column(
      children: [
        TextFormField(
          style: TextStyle(fontSize: 25),
          controller: _dateController,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: 'Deadline',
            suffixIcon: _subtask.deadline != null
                ? IconButton(
                    onPressed: _clearDate,
                    icon: Icon(Icons.clear),
                  )
                : Icon(Icons.calendar_today),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildType() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Type', style: TextStyle(fontSize: 25, color: Colors.grey[700])),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  value: SubtaskType.CODING,
                  groupValue: _subtask.type,
                  onChanged: (val) {
                    setState(() {
                      _subtask.type = val;
                    });
                  },
                  title: Text('Codding'),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: SubtaskType.TESTING,
                  groupValue: _subtask.type,
                  onChanged: (val) {
                    setState(() {
                      _subtask.type = val;
                    });
                  },
                  title: Text('Testing'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void createSubTask()async{
      final isValid = _formKey.currentState?.validate();
      if (isValid!){
        try{
          _formKey.currentState?.save();
          await Provider.of<Subtask>(context, listen: false).createSubTask(_subtask, widget.taskId);
          Navigator.of(context).pop();
        }catch(error){
          print(error);
        }
      }
    }
    return Scaffold(
        resizeToAvoidBottomInset:false,
      appBar: _buildAppBar(context),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitleField(),
              _buildDescriptionField(),
              _buildDeadline(),
              _buildType(),
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
        onPressed: createSubTask,
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
