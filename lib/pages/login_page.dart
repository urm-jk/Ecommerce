import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/my_textfield.dart';
import 'package:ecommerce/components/login_with.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  void signInUser() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: eMailController.text,
        password: passwordController.text,
      );
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
                const SizedBox(height: 68),
                //logo
                Image.asset(
                  'assets/log_in_page/logo.png',
                  width: 72,
                  height: 72,
                ),
                const SizedBox(height: 21.46),

                //Welcome to Lafyuu
                const Text(
                  'Welcome to Lafyuu',
                  style: TextStyle(
                      color: Color(0xFF223263),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 9.76),
                const Text(
                  'Sign in to continue',
                  style: TextStyle(color: Color(0xFF9098B1), fontSize: 16),
                ),
                const SizedBox(height: 28),

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

                //Sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signInUser,
                ),

                const SizedBox(height: 21),
                //or
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: Color(0xFFEBF0FF),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Color(0xFF9098B1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: Color(0xFFEBF0FF),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //Google
                LoginWith(
                  loginWith: loginWithGF,
                  text: 'Login with Google',
                  Image:
                      Image.asset('assets/log_in_page/google.png', width: 40.0),
                ),
                const SizedBox(height: 6),
                //Facebook

                LoginWith(
                  loginWith: loginWithGF,
                  text: 'Login with Facebook',
                  Image: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/log_in_page/facebook.png',
                        width: 22.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                //ForgotPassword

                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF40BFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 26),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Don't have a account?''',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 4
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register',
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
