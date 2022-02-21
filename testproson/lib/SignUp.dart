import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testproson/ContWithEmail.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: signUpShow, child: Text('SignUp'),),
            ElevatedButton(onPressed: signInShow,child: Text('SignIn'),),
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 4),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Create Password'),
              obscureText: true,
            ),
        SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Rewrite Password'),
            obscureText: true,
          ),
            SizedBox(height: 20),
            Text('Sed ut perspiciatis unde omnis iste natus Privacy Policy laudantium, totam rem aperiam, ea'),
            SizedBox(height: 100),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
              ),
              icon: Icon(Icons.lock_open, size: 32),
              label: Text('Continue', style: TextStyle(fontSize: 24)),
              onPressed: signUp,
            )
          ],
        ),

      ),
    );
  }
  void signUpShow() {

  }

  void signInShow() {
    Navigator.push(
        context,MaterialPageRoute(builder: (context) => ContWithEmail()));
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
  }

}
