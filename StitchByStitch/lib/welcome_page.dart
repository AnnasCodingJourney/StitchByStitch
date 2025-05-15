import 'package:flutter/material.dart';
import 'package:flutter_application_1/log_in.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:flutter_application_1/social_feed.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

//welcome page to choose whether to login, sign up or continue without making account
//help from https://www.youtube.com/watch?v=Dh-cTQJgM-Q&t=1s tutorial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                label: 'Welcome to Stitch by Stitch!',
                child: Image.asset('assets/images/welcome_page.jpg'),
              ),
            ),
          ),

          // login button
          Positioned(
            top: 440, // this height puts buttons under background image text
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
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
                                const LoginPage(), //goes to login page
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
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
                        'Log in',
                        style:
                            TextStyle(color: Color.fromARGB(255, 137, 57, 57)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40), // space between buttons

                  // sign up button
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
                                const SignUpPage(), //goes to signup page
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 137, 57, 57)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 110,
                  ),

                  //added a link to continue without account (for testing purposes more than anything)
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // full width of screen to try and centre text
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextButton(
                          onPressed: () {
                            // navigate to the home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SocialFeed(), //goes to home screen
                              ),
                            );
                          },
                          child: const Text(
                            'Continue without making an account',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 137, 57, 57),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign
                                .center, // centres text - there is probably a better way
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
