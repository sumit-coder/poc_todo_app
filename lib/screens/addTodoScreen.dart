// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/addTodo_Screen_Provider.dart';
import '../providers/home_Screen_Provider.dart';
import '../services/microFunctions/timeAndDate.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Consumer<AddTodoScreenProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add Todo Text Field
                        AddTodoFormCellContainer(
                          headTitle: 'To-Do',
                          bodyWidget: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              onChanged: (value) {
                                Provider.of<AddTodoScreenProvider>(context, listen: false)
                                    .setTodoText(value);
                              },
                              style: const TextStyle(fontSize: 20, color: Colors.black),
                              decoration: const InputDecoration(
                                // fillColor: Colors.blue,
                                // filled: true,
                                contentPadding: EdgeInsets.all(20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        // Due Date and Time Selection
                        Row(
                          children: [
                            Expanded(
                              child: AddTodoFormCellContainer(
                                headTitle: 'Due Date',
                                bodyWidget: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.blue,
                                    ),
                                    color: provider.dueDatebackgroundColor,
                                  ),
                                  height: 50,
                                  // width: 200,
                                  child: Material(
                                    color: provider.dueDatebackgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      onTap: () async {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(const Duration(days: 365)),
                                        ).then((selectedDate) {
                                          provider.setDueDate(selectedDate);
                                          print(selectedDate);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              provider.dueDateText,
                                              style: TextStyle(
                                                  fontSize: 18, color: provider.dueDatetextColor),
                                            ),
                                            Icon(
                                              size: 26,
                                              Icons.date_range_rounded,
                                              color: provider.dueDatetextColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: AddTodoFormCellContainer(
                                headTitle: 'Due Time',
                                bodyWidget: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.blue,
                                    ),
                                    color: provider.dueTimebackgroundColor,
                                  ),
                                  height: 50,
                                  // width: 200,
                                  child: Material(
                                    color: provider.dueTimebackgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      onTap: () async {
                                        showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                            hour: 7,
                                            minute: 15,
                                          ),
                                        ).then(
                                          (value) {
                                            if (value != null) {
                                              provider.setDueTime(value);
                                            }
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              provider.dueTimeText,
                                              style: TextStyle(
                                                  fontSize: 18, color: provider.dueTimetextColor),
                                            ),
                                            Icon(
                                              Icons.history_toggle_off_rounded,
                                              size: 30,
                                              color: provider.dueTimetextColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Add Todo Status
                        AddTodoFormCellContainer(
                          headTitle: 'Task Status',
                          bodyWidget: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              // Select Color based on is Complete is Selected
                              color: provider.isCompleted != null ? Colors.blue : Colors.white,
                              border: Border.all(width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButton<bool>(
                              onChanged: (value) {
                                // Set Selected Value to Active
                                provider.setIsCompleted(value);
                              },
                              iconEnabledColor:
                                  provider.isCompleted != null ? Colors.white : Colors.black,
                              dropdownColor: Colors.blue,
                              elevation: 2,
                              underline: const SizedBox(),
                              // Select Value of isCompleted in Provider
                              value: provider.isCompleted,
                              hint: const Text(
                                'Select Status',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: true,
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const DropdownMenuItem(
                                  value: false,
                                  child: Text(
                                    'Not Completed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add Todo Button
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // print(d!['tasks'][0].);

                        HomeScreenProvider hom =
                            Provider.of<HomeScreenProvider>(context, listen: false);
                        hom.addTask(
                          Task(
                            id: 58,
                            task: 'Learn how to make pc',
                            isCompleted: false,
                            dueDate: DateTime.now().add(const Duration(days: 2)),
                            userId: 5,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                      ),
                      child: const Text(
                        "Conform",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Close Button
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // print(d!['tasks'][0].);
                        // Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor:
                            MaterialStateProperty.all(const Color.fromARGB(255, 155, 155, 155)),
                      ),
                      child: const Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AddTodoFormCellContainer extends StatelessWidget {
  const AddTodoFormCellContainer({
    Key? key,
    required this.bodyWidget,
    required this.headTitle,
  }) : super(key: key);

  final String headTitle;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade400,
              // fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          bodyWidget,
        ],
      ),
    );
  }
}
