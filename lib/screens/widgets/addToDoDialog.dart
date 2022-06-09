import 'package:flutter/material.dart';
import 'package:poc_demo_app/models/task.dart';

import '../addTodoScreen.dart';

getAddTodoDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(0),
        title: Text(
          'Add Todo',
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              AddTodoScreen(
                updateORAdd: 'add',
              ),
            ],
          ),
        ),
      );
    },
  );
}

getUpdateTodoDialog(BuildContext context, Task taskToUpdate) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(0),
        title: Text(
          'Add Todo',
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              AddTodoScreen(
                updateORAdd: 'Update',
                currentUpdateTask: taskToUpdate,
              ),
            ],
          ),
        ),
      );
    },
  );
}
