import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:provider/provider.dart';

import '../../services/microFunctions/todoDueDatePriorityTag.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todoData,
    required this.onCeckboxClicked,
    required this.onTodoDelete,
    required this.onTodoEdit,
  }) : super(key: key);

  final Task todoData;
  final Function onCeckboxClicked;
  final VoidCallback onTodoDelete;
  final VoidCallback onTodoEdit;

  @override
  Widget build(BuildContext context) {
    String getRightDateFormate() {
      String currentdate =
          "${todoData.dueDate.year}/${todoData.dueDate.month}/${todoData.dueDate.day}";

      return currentdate;
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      child: Material(
        color: todoData.isCompleted == true ? Color.fromARGB(255, 228, 234, 255) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: Builder(builder: (context) {
          return Slidable(
            // key: KeyData(todoData.id.toString()),
            key: ValueKey(todoData.id),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(
                onDismissed: () {
                  // Remove this Slidable from the widget tree.
                  onTodoDelete();
                },
              ),
              motion: const DrawerMotion(),
              extentRatio: 0.5,
              children: [
                CustomSlidableAction(
                  padding: EdgeInsets.all(0),
                  onPressed: (context) {
                    onTodoEdit();
                  },
                  child: Container(
                    color: Color.fromARGB(255, 85, 178, 255),
                    // width: 50,
                    height: double.maxFinite,
                    child: const Center(
                      child: Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    // elevation: 2,
                    color: const Color.fromARGB(255, 255, 96, 85),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        onTodoDelete();
                      },
                      child: Container(
                        // width: 50,
                        height: double.maxFinite,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        // height: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Check box And Delete Button Section
                Container(
                  child: Column(
                    children: [
                      Checkbox(
                        value: todoData.isCompleted,
                        activeColor: const Color.fromARGB(255, 82, 177, 255),
                        onChanged: (bool) {
                          onCeckboxClicked();
                        },
                      ),
                    ],
                  ),
                ),
                // Todo Title Date etc Section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todoData.task, // Task Text
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              getRightDateFormate(), // Due Date of Task
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        getTodoDueDatePriorityContainer(
                            todoData.dueDate), // this give Low Hige Small card
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
