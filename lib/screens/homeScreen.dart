import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:poc_demo_app/providers/home_Screen_Provider.dart';
import 'package:poc_demo_app/services/API/api.dart';
import 'package:provider/provider.dart';

import '../models/links.dart';
import 'addTodoScreen.dart';
import 'widgets/snackBars.dart';
import 'widgets/todoCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Today Text
              const Text(
                'TODAY',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Scrolling Card Container
              Consumer<HomeScreenProvider>(
                builder: (context, provider, child) {
                  // this Will Called only one Time for getting Todos Form API
                  if (provider.tasksLodedeFromApi == false && provider.retryButtonNeed == false) {
                    provider.getTasks();
                  }
                  if (provider.tasksLodedeFromApi == false) {
                    // This Will return Loading Incicator or Retry Button while data if loading form API

                    if (provider.retryButtonNeed == true) {
                      // this will return ReTry Button if no there is no Internet
                      return Center(
                        child: Material(
                          elevation: 2,
                          child: IconButton(
                            onPressed: () {
                              // this will retry to get Data Form API and Show Message for it
                              provider.getTasks().then(
                                // after re-calling getTask show SnackBar (NoInternet)
                                (value) {
                                  if (value == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(noInternetSnackBar);
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              Icons.replay_rounded,
                              color: Colors.grey.shade800,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    } else {
                      // This Will Return Progress Indicator
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    // This Will return when data is loaded form API
                    return Expanded(
                      child: NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (notification.metrics.atEdge) {
                            if (notification.metrics.pixels == 0) {
                              // print('At top');
                            } else {
                              // print('At bottom');
                              // This Will New Todo When user Scroll to end
                              Provider.of<HomeScreenProvider>(context, listen: false)
                                  .lazyLoadingLoadTodos();
                            }
                          }
                          return true;
                        },
                        child: SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          closeWhenTapped: true,
                          child: ListView.builder(
                            itemCount: provider.taskList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // Get Current from List of Task
                              Task currentTask = provider.taskList[index];

                              return TodoCard(
                                onCeckboxClicked: () {
                                  provider.isCompletedTodo(currentTask.id);
                                },
                                onTodoDelete: () {
                                  provider.deleteTask(currentTask.id);
                                },
                                onTodoEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddTodoScreen(),
                                    ),
                                  );
                                  print('Edit ToDo');
                                },
                                todoData: Task(
                                  id: currentTask.id,
                                  task: currentTask.task,
                                  isCompleted: currentTask.isCompleted,
                                  dueDate: currentTask.dueDate,
                                  userId: currentTask.userId,
                                  createdAt: currentTask.createdAt,
                                  updatedAt: currentTask.updatedAt,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              // Add Todo Button
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    // print(d!['tasks'][0].);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTodoScreen()),
                    );
                    // Provider.of<HomeScreenProvider>(context, listen: false).updateTask(
                    //   44,
                    //   Task(
                    //     id: 58,
                    //     task: 'Make New App',
                    //     isCompleted: true,
                    //     dueDate: DateTime.now().add(const Duration(days: 5)),
                    //     userId: 5,
                    //     createdAt: DateTime.now(),
                    //     updatedAt: DateTime.now(),
                    //   ),
                    // );
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(1),
                  ),
                  child: const Text(
                    "Add Todo",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
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
