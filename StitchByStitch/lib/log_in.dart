import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'user_service.dart';


// ChatGpt used for login data persistance. Making authentication work.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();
  bool _isLoginFailed = false;

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Check if the user exists and the password matches
    bool isValidUser = await _userService.authenticateUser(username, password);

    // Check if the widget is still mounted before calling setState
    if (!mounted) return;

    setState(() {
      _isLoginFailed = !isValidUser;
    });

    // If login is valid, navigate to home screen
    if (isValidUser) {
      if (!mounted) return; // Ensure the widget is still mounted before navigating
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SocialFeed()),
      );
    } else {
      _showErrorMessage("Incorrect username or password.");
    }
  }

  // Show an error message
  void _showErrorMessage(String message) {
    if (!mounted) return; // Ensure the widget is still mounted before showing SnackBar

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Show Forgot Username/Password Dialog
  void _showForgotDialog() {
    if (!mounted) return; // Ensure the widget is mounted before showing the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forgot Username/Password?'),
          content: const Text('Do you want to reset your username or password?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showEmailInstructionsDialog();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        );
      },
    );
  }

  // Show instructions sent to email dialog
  void _showEmailInstructionsDialog() {
    if (!mounted) return; // Ensure the widget is still mounted before showing the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instructions Sent'),
          content: const Text('Follow instructions sent to your email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


//help from https://www.youtube.com/watch?v=Dh-cTQJgM-Q&t=1s tutorial


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // stops the background from jumping up when entering details
      body: Stack(
        children: [
          //added a background colour in case image doesn't load fully
          Container(
            color: Color.fromARGB(146, 255, 232, 220),
          ),

          // background image
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover, // makes background image fill screen
              child: Image.asset('assets/images/log_in.jpg'),
            ),
          ),

          // positioned moves buttons down below login text
          Positioned(
            top: 415,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // row for login and sign up buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      child: OutlinedButton(
                        onPressed: _login, //log in button updated with chatGpt
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(160, 50),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 137, 57, 57),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // space between buttons
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      child: OutlinedButton(
                        onPressed: () {
                          // navigate to the signup screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpPage(), //goes to sign-up page
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(160, 50),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          backgroundColor: Color.fromARGB(146, 255, 232, 220),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 137, 57, 57)),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 25), // space between buttons and form fields

                // email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, // height of boxes
                        horizontal: 12,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress, // Better for email
                  ),
                ),

                const SizedBox(
                    height: 20), // space between email and password fields

                // password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true, // hides password text
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, // height of boxes
                        horizontal: 12,
                      ),
                    ),
                    keyboardType: TextInputType.text, // Text input for password
                  ),
                ),

                const SizedBox(
                    height: 25), // space between form and login button

                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    shadowColor: Colors.black,
                    child: OutlinedButton(
                      onPressed: _login,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.2,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        backgroundColor:
                            Color.fromARGB(146, 255, 232, 220), // Red color
                      ),
                      child: const Text(
                        'Log in',
                        style:
                            TextStyle(color: Color.fromARGB(255, 137, 57, 57)),
                      ),
                    ),
                  ),
                ),

                // Conditionally show the error message if login failed
                if (_isLoginFailed)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Incorrect username or password",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                
                
                const SizedBox(
                    height:
                        8), // space between login button and forgot password

                // forgot password text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextButton(
                    onPressed: _showForgotDialog,
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 63, 63, 63),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

