import 'package:flutter/material.dart';
import 'package:flutter_application_1/log_in.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'user_service.dart';
import 'user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}


// ChatGpt used to make the sign up work with data persistance and user data saved for login


class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final UserService _userService = UserService();

  Future<void> _signUp() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final email = _emailController.text.trim();

    // Validate the password
    if (!_isPasswordValid(password)) {
      _showErrorMessage("Password must be at least 6 characters long, contain a capital letter, and a special character.");
      return;
    }

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      _showErrorMessage("Please fill in all fields.");
      return;
    }

    // Check if the email already exists
    bool emailExists = await _userService.checkEmailExists(email);

    if (emailExists) {
      _showEmailErrorDialog();
      return;
    }

    User newUser = User(username: username, password: password, email: email, uploads: []);

    try {
      // Add the user to the data (JSON file)
      await _userService.addUser(newUser);

      // Show success message
      _showSuccessMessage("Account created successfully!");

      // Clear the input fields after sign up
      _usernameController.clear();
      _passwordController.clear();
      _emailController.clear();

      // After successful sign up, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      _showErrorMessage("Error creating account. Please try again.");
    }
  }

  // Check if password meets the required conditions
  bool _isPasswordValid(String password) {
    final passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');
    return passwordRegEx.hasMatch(password);
  }

  // Show an error message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Show a success message
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Show the dialog when the email is already used
  void _showEmailErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email already in use'),
          content: const Text(
            'You seem to already have an account. Login or click on Forgot password.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and navigate to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and show the forgot password message
                Navigator.of(context).pop(); // Close the dialog
                _showForgotPasswordDialog();
              },
              child: const Text('Forgot password'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show the forgot password dialog
  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Forgot Password?"),
          content: const Text("Email instructions sent to your email."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

//help from https://www.youtube.com/watch?v=Dh-cTQJgM-Q&t=1s tutorial
//no functionality yet

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
              fit: BoxFit.cover,
              child: Semantics(
                label: "Create an account",
                child: Image.asset('assets/images/sign_up.jpg'),
              ),
            ),
          ),

          //added a link to continue without account
          Positioned(
            top: 340,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextButton(
                    onPressed: () {
                      // navigate to the home screen
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SocialFeed()), //goes to home screen

                      );
                    },
                    child: const Text(
                      'Continue without making an account',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 137, 57, 57),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // positioned moves buttons down below log in text
          Positioned(
            top: 415,
            left: 0,
            right: 0,
            child: Column(children: [
              // row for login and sign up buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    shadowColor: Colors.black,
                    child: OutlinedButton(
                      onPressed: () {
                        // navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage(), //goes to log-in page
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
                        backgroundColor:
                            const Color.fromARGB(146, 255, 232, 220),
                      ),
                      child: const Text(
                        'Log in',
                        style:
                            TextStyle(color: Color.fromARGB(255, 137, 57, 57)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
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
                          width: 0,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        backgroundColor: Color.fromARGB(255, 137, 57, 57),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 25), // space between buttons and form fields

              // name text field
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
                          vertical:
                              8, //height of boxes - can make thinner if needed
                          horizontal: 12,
                        )),
                    keyboardType: TextInputType.phone,
                    onTap: () {
                      FocusScope.of(context).isFirstFocus;
                    }),
              ),

              const SizedBox(height: 20), // space between email and name fields
              
              // email text field

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical:
                              8, //height of boxes - can make thinner if needed
                          horizontal: 12,
                        )),
                    keyboardType: TextInputType.phone,
                    onTap: () {
                      FocusScope.of(context).isFirstFocus;
                    }),
              ),

              const SizedBox(height: 20),

              // password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                    obscureText: true,
                    controller: _passwordController, // hides password text
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical:
                              8, //height of boxes - can make thinner if needed
                          horizontal: 12,
                        )),
                    keyboardType: TextInputType.phone,
                    onTap: () {
                      FocusScope.of(context).isFirstFocus;
                    }),
              ),

              const SizedBox(
                  height: 25), // space between form fields and sign up button

              // sign up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  shadowColor: Colors.black,
                  child: OutlinedButton(
                    onPressed: _signUp,
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
                      backgroundColor: Color.fromARGB(146, 255, 232, 220),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Color.fromARGB(255, 137, 57, 57)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}


