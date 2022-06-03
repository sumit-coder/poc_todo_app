import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/addTodo_Screen_Provider.dart';
import 'providers/home_Screen_Provider.dart';
import 'screens/addTodoScreen.dart';
import 'screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddTodoScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto-Medium',
          // useMaterial3: true,
        ),
        home: AddTodoScreen(),
        // home: Scaffold(
        //   body: GestureDetector(
        //     onPanUpdate: (details) {
        //       // Swiping in right direction.
        //       if (details.delta.dx > 0) {
        //         print('object');
        //       }

        //       // Swiping in left direction.
        //       if (details.delta.dx < 0) {
        //         print('left');
        //       }
        //     },
        //     child: ListView.builder(
        //       itemCount: 5,
        //       itemBuilder: (context, index) {
        //         // final item = items[index];
        //         return Container(
        //           height: 100,
        //           margin: EdgeInsets.all(20),
        //           color: Colors.red,
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
