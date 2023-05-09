import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/providers/todo_provider.dart';
import '../models/todo_model.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        // if (value == null || value.isEmpty) {
        //   return 'Please enter an email';
        // }
        // return null;
        return EmailValidator.validate(value!) ? null: "Please enter a valid email";
      }, 
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }else if(value.length < 6){
          return 'Password too short';
        }
        return null;
      }, 
    );

    final fname = TextFormField(
      controller: fnameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a first name';
        }
        return null;
      }, 
    );

    final lname = TextFormField(
      controller: lnameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a last name';
        }
        return null;
      }, 
    );

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {

          //validation
          if(_formKey.currentState!.validate()){
            _formKey.currentState?.save();
            Todo temp = Todo(
                email: emailController.text,
                fName: fnameController.text,
                lName: lnameController.text,
          );
           context.read<TodoListProvider>().addTodo(temp);
          //to sign up
          await context
              .read<AuthProvider>()
              .signUp(emailController.text, passwordController.text);
          
          if (context.mounted) Navigator.pop(context);
          }
            
          
          
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    final MyForms = Form(key: _formKey,child: Column(children: [
      fname,
            lname,
            email,
            password,
            SignupButton,
            backButton,
    ],));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            MyForms,
            
          ],
        ),
      ),
    );
  }
}
