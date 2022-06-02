// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/addTodo_Screen_Provider.dart';
import '../providers/home_Screen_Provider.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Todo Text Field
              AddTodoFormCellContainer(
                headTitle: 'To-Do',
                bodyWidget: TextField(
                  onChanged: (value) {
                    Provider.of<AddTodoScreenProvider>(context, listen: false)
                        .setTodoText(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Due Date Selection
              AddTodoFormCellContainer(
                headTitle: 'Due Date',
                bodyWidget: SizedBox(
                  height: 50,
                  width: 200,
                  child: Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            const Icon(
                              Icons.date_range_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Add Todo Text Field
              AddTodoFormCellContainer(
                headTitle: 'Task Status',
                bodyWidget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<bool>(
                    onChanged: (value) {},
                    elevation: 1,
                    underline: const SizedBox(),
                    value: false,
                    items: [
                      const DropdownMenuItem(
                        value: true,
                        child: Text('Completed'),
                      ),
                      const DropdownMenuItem(
                        value: false,
                        child: Text('Not Completed'),
                      )
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
