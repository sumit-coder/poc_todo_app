import 'package:flutter/material.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:poc_demo_app/providers/home_Screen_Provider.dart';
import 'package:poc_demo_app/services/API/api.dart';
import 'package:provider/provider.dart';

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
                  if (provider.tasksLodedeFromApi == false) {
                    provider.getTasks(0);
                  }
                  if (provider.tasksLodedeFromApi == false) {
                    // This Will return Loading Incicator while data if loading form API
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    // This Will return when data is loaded form API
                    return Expanded(
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
                  onPressed: () async {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
