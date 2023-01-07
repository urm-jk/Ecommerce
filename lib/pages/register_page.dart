import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/my_textfield.dart';
import 'package:ecommerce/components/login_with.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signInUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try creating the user
    try {
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: eMailController.text,
          password: passwordController.text,
        );
      }else{
        wrongPasswordMessage();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //Wrong email
      if (e.code == 'user not found') {
      }
      //Wrong password
      else if (e.code == 'wrong-password') {
        //show error to user
        wrongPasswordMessage();
      }
    }

    //pop the loading circle
    Navigator.pop(context);
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            'Oops! Your Password Is Not Correct',
            style: TextStyle(color: Color(0xFFFB7181)),
          ),
        );
      },
    );
  }

  void loginWithGF() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 155),
                //logo
                Image.asset(
                  'assets/log_in_page/logo.png',
                  width: 72,
                  height: 72,
                ),
                const SizedBox(height: 21.46),

                //Welcome to Lafyuu
                const Text(
                  '''Let's get started''',
                  style: TextStyle(
                      color: Color(0xFF223263),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 9.76),
                const Text(
                  'Create a new account',
                  style: TextStyle(color: Color(0xFF9098B1), fontSize: 16),
                ),
                const SizedBox(height: 28),

                MyTextField(
                  controller: nameController,
                  hintText: 'Full Name',
                  obscureText: false,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),

                //Your Email
                MyTextField(
                  controller: eMailController,
                  hintText: 'Your Email',
                  obscureText: false,
                  prefixIcon: Icon(
                    Icons.local_post_office_outlined,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),

                //Password

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Password again',
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),

                //Sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signInUserUp,
                ),

                const SizedBox(height: 21),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''have an account''',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Color(0xFF40BFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
