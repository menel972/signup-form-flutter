import 'package:flutter/material.dart';
import 'package:forms/service/user_model.dart';
import 'package:intl/intl.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  DateTime? userDate = DateTime.now();
  bool hidden = true;
// NOTE : un booleen pour montrer ou cacher les caractères du mdp

  late FocusNode _pseudo;
  late FocusNode _mdp;

  User newUser =
      User(email: '', pseudo: '', dateDeNaissance: DateTime.now(), mdp: '');

  pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6552)),
      firstDate: DateTime.utc(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 6552)),
    );
    setState(() {
      userDate = date;
      newUser.dateDeNaissance = userDate!;
    });
  }

  void createUser() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vos données sont enregistrées !'),
          backgroundColor: Colors.indigo[200],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Le formulaire n\'est pas valide !'),
          backgroundColor: Colors.red[200],
        ),
      );
    }
  }
  // NOTE : Création de l'utilisateur

  @override
  void initState() {
    _pseudo = FocusNode();
    _mdp = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _pseudo.dispose();
    _mdp.dispose();
    _formkey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'S\'enregistrer',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Icon(Icons.alternate_email),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      validator: ((value) {
                        RegExp exp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                        if (value!.isEmpty) {
                          return 'Remplissez ce champs...';
                        } else if (!exp.hasMatch(value)) {
                          return 'L\'email utilisée n\'est pas valide';
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_pseudo),
                      onSaved: (value) => setState(() {
                        newUser.email = value!;
                      }),
                    ),
                  ),
                ],
              ),
              // NOTE : MAIL

              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(Icons.person_outline),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      validator: (value) =>
                          value!.isEmpty ? 'Remplissez ce champs...' : null,
                      decoration: InputDecoration(
                        labelText: 'Pseudo',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _pseudo,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_mdp),
                      onSaved: (value) => setState(() {
                        newUser.pseudo = value!;
                      }),
                    ),
                  ),
                ],
              ),
              // NOTE : PSEUDO
              const SizedBox(height: 12),
              TextButton.icon(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.all(1)),
                ),
                onPressed: () => pickDate(),
                icon: const Icon(Icons.calendar_today),
                label: Text.rich(
                  TextSpan(
                      style: Theme.of(context).textTheme.labelMedium,
                      text: 'Date de naissance : ',
                      children: [
                        TextSpan(
                          text: userDate!.day != DateTime.now().day
                              ? DateFormat('dd/MM/y').format(userDate!)
                              : '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ]),
                ),
              ),

              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(Icons.lock_outline_rounded),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      validator: (value) {
                        RegExp exp = RegExp(
                            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*_-]).{8,}");

                        if (value!.isEmpty) {
                          return 'Remplissez ce champs...';
                        } else if (!exp.hasMatch(value)) {
                          return 'min : 8 Car - 1 Maj - 1 Min - - 1 Num -1 Car Spé...';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidden,
                      decoration: InputDecoration(
                        labelText: 'Mot De Passe',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusNode: _mdp,
                      onFieldSubmitted: (value) => createUser(),
                      onSaved: (value) => setState(() {
                        newUser.mdp = value!;
                      }),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      hidden = !hidden;
                    }),
                    icon: Icon(
                      hidden == true
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ],
              ),
              // NOTE : MDP

              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    style: Theme.of(context).textTheme.labelSmall,
                    text: 'En cliquant sur continuer, vous acceptez nos ',
                    children: const [
                      TextSpan(
                        text: 'Conditions d\'Utilisation',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'et notre',
                      ),
                      TextSpan(
                        text: 'Gestion de vos données personelles',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => createUser(),
                child: Text(
                  'Continuer',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
