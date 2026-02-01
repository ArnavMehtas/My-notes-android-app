import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        
            children: [
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration:  const InputDecoration(
                  hintText: 'Email',
                )
              ),
          
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Password',
                )
              ),
          
          
              TextButton(
                onPressed: () async {   
                  final email = _email.text;
                  final password = _password.text;
      
                  try{
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password
                    );
                    // ignore: avoid_print
                    print(userCredential);
                  } on FirebaseAuthException catch(e){
                    if (e.code == 'weak-password') {
                      // ignore: avoid_print
                      print('The password provided is too weak.');
                    }       
                    else if (e.code == 'email-already-in-use') {
                      // ignore: avoid_print
                      print('The account already exists for that email.');
                    } 
                    else if (e.code == 'invalid-email') {
                      // ignore: avoid_print
                      print('The email address is not valid.');
                    }
                  } 
                  
                  
                }, 
                child: const Text('Register'),),

                TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', 
                  (route) => false
                  );
              },
              child: const Text('Login karlo if already registered'),),

            ],
          ),      
    );
  }
}

