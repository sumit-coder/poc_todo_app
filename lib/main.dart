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
        home: HomeScreen(),
      ),
    );
  }
}
