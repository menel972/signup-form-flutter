import 'package:flutter/material.dart';
import 'view/create_user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,

          // NOTE : TextTheme
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
            // NOTE : HeadlineLarge

            labelMedium: TextStyle(
              fontSize: 16,
              color: Colors.indigo[200],
            ),
            // NOTE : LabelMedium

            labelSmall: TextStyle(
              fontSize: 14,
              color: Colors.indigo[200],
            ),
            // NOTE : labelSmall

            bodyMedium: TextStyle(
              fontSize: 18,
              color: Colors.indigo[900],
            ),
            // NOTE : BodySmall

            displayMedium: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            // NOTE : DisplayMedium
          ),

          // NOTE : Input
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo[200]!),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[400]!),
            ),
          ),

          // NOTE : Icon
          iconTheme: IconThemeData(
            color: Colors.indigo[800],
          ),
        ),
        home: const CreateUserView());
  }
}
