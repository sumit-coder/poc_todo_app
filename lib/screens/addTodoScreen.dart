// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/addTodo_Screen_Provider.dart';
import '../providers/home_Screen_Provider.dart';
import '../services/microFunctions/timeAndDate.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key, required this.updateORAdd, this.currentUpdateTask}) : super(key: key);

  final String updateORAdd; // use Update for Updating Task 'Update';
  Task? currentUpdateTask;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (updateORAdd == 'Update' && currentUpdateTask != null) {
        AddTodoScreenProvider addTodoProvider =
            Provider.of<AddTodoScreenProvider>(context, listen: false);

        TimeOfDay timeOfDayFromDueDate = TimeOfDay.fromDateTime(currentUpdateTask!.dueDate);
        String timeInString = TimeAndDate().timeOfDayToNormalString(timeOfDayFromDueDate);

        // print(timeInString);
        // print(currentUpdateTask!.dueDate);

        addTodoProvider.setDueDate(currentUpdateTask!.dueDate);
        addTodoProvider.setIsCompleted(currentUpdateTask!.isCompleted);
        addTodoProvider.updateTodoText(currentUpdateTask!.task);
        addTodoProvider.setDueTime(timeOfDayFromDueDate);
        // print(currentUpdateTask!.task);
      }
    });

    return Container(
      height: 400,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          controller: provider.todoTitleTextController,
                          onChanged: (value) {
                            Provider.of<AddTodoScreenProvider>(context, listen: false)
                                .setTodoText(value);
                          },
                          style: const TextStyle(fontSize: 20, color: Colors.black),
                          decoration: const InputDecoration(
                            // fillColor: Colors.blue,
                            // filled: true,
                            contentPadding: EdgeInsets.all(15.0),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          provider.dueDateText,
                                          style: TextStyle(
                                              fontSize: 18, color: provider.dueDatetextColor),
                                        ),
                                        Icon(
                                          size: 24,
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
                        const SizedBox(width: 10),
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
                                        hour: 12,
                                        minute: 00,
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
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                          size: 25,
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
                  ],
                ),
              ),
              // Add Todo Button
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    // print(d!['tasks'][0].);
                    // Check if any this not Null then add Todo
                    if (provider.todoTitle != '') {
                      HomeScreenProvider homeScreenProvider =
                          Provider.of<HomeScreenProvider>(context, listen: false);
                      // Get Random ID
                      Random random = new Random();
                      int randomID =
                          (random.nextInt(100000) + 10) * homeScreenProvider.taskList.length;

                      //
                      DateTime dateWithTime = TimeAndDate().addTimeOfDayWithDateTime(
                          newDate: provider.dueDate, newTime: provider.dueTime);

                      if (updateORAdd != 'Update') {
                        // print(dateWithTime);

                        //add Task TO API and STATE
                        homeScreenProvider.addTask(
                          Task(
                            id: randomID,
                            task: provider.todoTitle,
                            isCompleted: false, //provider.isCompleted is then use {false}
                            dueDate: dateWithTime,
                            userId: 5,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        );
                      } else {
                        // This Will Call When User Update
                        print('Update');

                        if (currentUpdateTask != null) {
                          homeScreenProvider.updateTask(
                            currentUpdateTask!.id,
                            Task(
                              id: currentUpdateTask!.id,
                              task: provider.todoTitle,
                              isCompleted: provider.isCompleted,
                              dueDate: dateWithTime,
                              userId: currentUpdateTask!.userId,
                              createdAt: currentUpdateTask!.createdAt,
                              updatedAt: DateTime.now(),
                            ),
                          );
                        }
                      }

                      // Send Back TO Home Page
                      Navigator.pop(context);

                      // This Function will Empty all Fields form Add Todo Data
                      provider.emptyAllFields();
                    } else {
                      print('Fill all Fields');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    onPrimary: Colors.pink,
                    primary: Colors.blue,
                  ),
                  child: Text(
                    updateORAdd != 'Update' ? "Add Todo" : "Update",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Close Button
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    // print(d!['tasks'][0].);
                    provider.emptyAllFields();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(1),
                    backgroundColor:
                        MaterialStateProperty.all(const Color.fromARGB(255, 155, 155, 155)),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
        },
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
