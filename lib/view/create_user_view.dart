import 'package:flutter/material.dart';
import 'forms.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
        centerTitle: true,
      ),
      body: const Forms(),
    );
  }
}
