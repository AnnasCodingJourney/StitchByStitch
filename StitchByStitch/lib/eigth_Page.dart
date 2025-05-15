import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EigthPage extends StatefulWidget {
  const EigthPage({super.key});

  @override
  EigthPageState createState() => EigthPageState();
}

class EigthPageState extends State<EigthPage> {
  double rating = 0;
  final TextEditingController _commentController =
      TextEditingController(); // ChatGpt used to update this function that allows a comment to be typed in
  String submittedComment = ""; // ChatGpt used for this line

  //ChatGpt used to create this dispose function to show displayed text in the type a comment section
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _commentController.dispose();
    super.dispose();
  }

  int currentPageIndex = 3;

  void onTabTapped(BuildContext context, int index) {
    if (index != currentPageIndex) {
      Widget nextPage;
      switch (index) {
        case 0:
          nextPage = const SocialFeed();
          break;
        case 1:
          nextPage = const NotificationsPage();
          break;
        case 2:
          nextPage = TutorialPage();
          break;
        case 3:
          nextPage = const EventsScreen();
          break;
        default:
          return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchAppBar(),
          toolbarHeight: kToolbarHeight,
        ),

// A body with Columns and several Rows
// YT: https://www.youtube.com/watch?v=wzcJXTmxlWo

// Scrollable page: https://www.dhiwise.com/post/how-to-implement-flutter-scrollable-column

        body: SingleChildScrollView(

//headline:

            child: Column(
          children: [
            Row(
                // headline- red with the title in white and drop shadow
                children: [
                  Expanded(
                      // to align the content horizontally, since it is a Row
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 5, left: 5, right: 5, bottom: 18),
                          height: 56,
                          width: double
                              .infinity, // used to create the space on top
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 137, 57, 57),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 4)
                                // creating drop shadow: https://www.youtube.com/watch?v=bSZiF48RiNY
                                // shadows and decoration box : https://medium.com/@bosctechlabs/how-to-add-drop-shadow-effect-in-flutter-477360b21922
                              ]),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Casting on", //Title text
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)))))
                ]),

// page 6 : introduction for tutorial

// Divider with text inbetween
// https://stackoverflow.com/questions/54058228/horizontal-divider-with-text-in-the-middle-in-flutter

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Divider(
                        color: Color.fromARGB(255, 137, 57, 57),
                        height: 30,
                      )),
                ),
                Text("Beginner course",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 137, 57, 57))),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Divider(
                        color: Color.fromARGB(255, 137, 57, 57),
                        height: 30,
                      )),
                ),
              ],
            ),

// Introduction headline

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 30,
                      width: 250,
                      child: Text(
                        "Introduction",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),

// Text block 1

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 114,
                      width: 250,
                      child: Text(
                        "In the last tutorial, we talked about different needles, yarns and gauge. While the gauge is important when you start a new project, we will not consider it for now, but will come back to it in the intermediate tutorial. ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

// Text block 2

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 100,
                      width: 250,
                      child: Text(
                        "For this tutorial we will focus on how to start a knitting project and practice this, before we actually start a real project and consider the gauge and measurements. ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

// Text block 3

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 114,
                      width: 250,
                      child: Text(
                        "For now, you can just use any needles or yarn you have available, no matter what the gauge is. I would recommend using a lighter coloured yarn such as a cream colour or white and big needles (6-9mm), this is easier to help detect errors. ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

// Text block 4

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 80,
                      width: 250,
                      child: Text(
                        "Now that you have your needles and your yarn in your hands, you are ready to start a knitting project! But how do you start your project?",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

// Text block 5

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 80,
                      width: 250,
                      child: Text(
                        "We have to cast our project on. This means we need to put the yarn on our needles in a way that we can work with these stitches",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

// Video page page 7

// title 1

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 29,
                      width: 250,
                      child: Text(
                        "1.Step- The slip knot",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),

// image 1: slip knot

            // image size and fit : https://medium.com/@omershafique/flutter-boxfit-types-7852a56edd21
            // image size and fit : https://img.ly/blog/how-to-resize-images-in-flutter/#:~:text=If%20you%20are%20dealing%20with,on%20the%20scale%20you%20define.
            Row(children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 18),
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/slipknot.jpeg',
                        fit: BoxFit.cover,
                      )))
            ]),

// descriptive text under image 1:

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 65,
                      width: 347,
                      child: Text(
                        "This video talks you through the first step of casting on a project- the slip knot. Practice a few times to master making a slip knot.",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

//title 2

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 60,
                      width: 373,
                      child: Text(
                        "2. Step - Casting on the first stitches",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),

            // Image 2: casting on first stitches

            Row(children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 18),
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/caston.jpeg',
                        fit: BoxFit.cover,
                      )))
            ]),

// descriptive text under image 2:

            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 18, left: 43, right: 10),
                      height: 65,
                      width: 347,
                      child: Text(
                        "This video shows how you put the first stitches onto the needles. This can be tricky at first, so feel free to pause the video and practice a few times.",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),

            //Rating page -page 8

// text with rating number 4.8

            Row(children: [
              Container(
                margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                height: 60,
                width: 77,
                child: Text(
                  rating.toStringAsFixed(
                      1), //ChatGpt used to update this line, so that it reflects the actual rating someone has given and not an imaginary rating ,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 48,
                      fontWeight: FontWeight.w700),
                ),
              ),

// Displaying the star rating- ChatGpt used for this part.
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                ignoreGestures: true,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {},
              ),
            ]),

// Row with text- most helpful reviews

            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 43, right: 10),
                    height: 26,
                    width: 217,
                    child: Text(
                      "Most helpful reviews: ",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                  height: 129,
                  width: 349,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                        )
                      ]),
                  child: Opacity(
                    opacity: 0.5,
                    // Opacity: https://www.youtube.com/watch?v=IgrQHPYnjb4
                    child: submittedComment
                            .isNotEmpty //ChatGpt to update this child and the if statement to display the comment that will be typed in by the user
                        ? Text(
                            submittedComment,
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        : Container(),
                  ),
                ),
                // creating drop shadow: https://www.youtube.com/watch?v=bSZiF48RiNY
              ),
            ]),

// Row with Text - tap to rate

            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 18, bottom: 18, left: 43, right: 10),
                    height: 40,
                    width: 290,
                    child: Text(
                      "Tap to rate: ",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),

//Row with just stars that can be clicked on for rating

//ChatGpt used to update rating bar, as my own code didn't work, also allows half star ratings
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
              ],
            ),

            // A box with dropped shadow and a type to rate text

            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 18, left: 43, right: 10),
                  height: 95,
                  width: 349,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                        )
                      ]),

                  //ChatGpt used to update the Text to Textfield and allowing user to type in their comment and submit it, which updates the section above
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Type your comment..",
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    textInputAction: TextInputAction
                        .done, //allows submitting comment when you click on enter
                    onSubmitted: (comment) {
                      setState(() {
                        submittedComment = comment;
                        _commentController.clear();
                      });
                    },
                  ),
                )

                    // creating drop shadow: https://www.youtube.com/watch?v=bSZiF48RiNY
                    ),
              ],
            ),
          ],
        )),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        ));
  }
}
