import 'package:flutter/material.dart';
import 'package:poc_demo_app/models/task.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todoData,
    required this.onCeckboxClicked,
    required this.onTodoDelete,
    required this.onTodoLongPress,
  }) : super(key: key);

  final Task todoData;
  final Function onCeckboxClicked;
  final VoidCallback onTodoDelete;
  final VoidCallback onTodoLongPress;

  @override
  Widget build(BuildContext context) {
    String getRightDateFormate() {
      String currentdate =
          "${todoData.dueDate.year}/${todoData.dueDate.month}/${todoData.dueDate.day}";

      return currentdate;
    }

    Widget getTodoDueDatePriorityContainer() {
      DateTime cardDuteDate = todoData.dueDate;

      DateTime dateAfterTwoDays = DateTime.now().add(const Duration(days: 1));

      // this check if current todos duedate is less then 2 Days
      if (cardDuteDate.year <= dateAfterTwoDays.year &&
          cardDuteDate.month <= dateAfterTwoDays.month &&
          cardDuteDate.day <= dateAfterTwoDays.day) {
        return Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color.fromARGB(255, 255, 230, 228),
            ),
            child: const Text(
              'High',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 255, 140, 132),
              ),
            ),
          ),
        ); // this is High Priority Box
      } else {
        return Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color.fromARGB(255, 192, 255, 210),
            ),
            child: const Text(
              'Low',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 60, 221, 66),
              ),
            ),
          ),
        ); // this is Low Priority Box
      }
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: InkWell(
          onLongPress: onTodoLongPress,
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
                    todoData.isCompleted == true
                        ? IconButton(
                            onPressed: onTodoDelete,
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 111, 101),
                            ),
                          )
                        : Container(),
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
                      getTodoDueDatePriorityContainer(), // this give Low Hige Small card
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
