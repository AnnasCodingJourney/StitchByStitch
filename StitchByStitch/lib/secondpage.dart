import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/social_feed.dart';
import 'package:flutter_application_1/welcome_page.dart'; // Import WelcomePage
import 'package:flutter_application_1/image_provider_class.dart';

class Secondpage extends StatefulWidget {
  final String username;

  const Secondpage({super.key, required this.username});

  @override
  SecondpageState createState() => SecondpageState();
}

class SecondpageState extends State<Secondpage> {
  late ImageProviderClass imageProvider;

  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<ImageProviderClass>(context, listen: false);
  }

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Add the image to the provider's imagePaths for the user
      imageProvider.addImage(pickedFile.path);
      imageProvider.saveImages(widget.username); // Save the updated images
    }
  }

  // Show the image in a dialog with options for removal
  void _showImageDialog(BuildContext context, String imagePath, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(File(imagePath), fit: BoxFit.cover),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    _showConfirmationDialog(context, imagePath, index);
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Confirmation dialog before deleting the image
  void _showConfirmationDialog(
      BuildContext context, String imagePath, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you really want to delete this image?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                // Remove the image from the provider
                imageProvider.removeImage(index);
                imageProvider
                    .saveImages(widget.username); // Save the updated images
                Navigator.of(context).pop(); // Close the confirmation dialog
                Navigator.of(context).pop(); // Close the image dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Show help dialog
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Help"),
          content: Text(
              "You can upload permanent posts here. If you want to delete them click on them and click on the X. These posts do not appear in the feed. Only weekly challenges do adn stay there for 7 days."),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog if "Cancel" is pressed
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                // Navigate to the WelcomePage on logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WelcomePage()), // Navigate to WelcomePage
                );
              },
            ),
          ],
        );
      },
    );
  }

  int currentPageIndex = 0;

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
        body: Consumer<ImageProviderClass>(
          builder: (context, imageProvider, child) {
            final images = imageProvider.imagePaths;
            final imageCount =
                images.length; // Get the current number of images

            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 53),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          iconSize: 24,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SocialFeed()));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 53),
                        child: Text(
                          "My account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showHelpDialog(
                              context); // Show the alert dialog when tapped
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 53, left: 106),
                          height: 16,
                          width: 53,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 137, 57, 57),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 4),
                              ]),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Help",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 53, left: 10),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.settings),
                          iconSize: 24,
                          onSelected: (value) {
                            if (value == 'Logout') {
                              _showLogoutDialog(
                                  context); // Show the logout confirmation dialog
                            }
                          },
                          offset: Offset(10, 35),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'Logout',
                                child: Text('Logout'),
                              ),
                            ];
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 18, left: 28),
                        height: 80,
                        width: 80,
                        child: ClipOval(
                          child: Image.network(
                            'https://moderncat.com/wp-content/uploads/2014/03/bigstock-46771525_Andrey_Kuzmin-1-940x640.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 18, left: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "annas.knittingjourney",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 18),
                                  child: Text(
                                      "$imageCount", // Show the number of images
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 18),
                                  child: Text("Permanent Posts",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 18, left: 28),
                          height: 70,
                          width: 364,
                          child: Text(
                            "Hello and welcome to my knitting journey. I am a knitting beginner and I would love to improve my knitting skills.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GridView.builder(
                      shrinkWrap:
                          true, // Make the GridView take only the space it needs
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for the grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Set the number of items per row
                        crossAxisSpacing: 8.0, // Horizontal space between items
                        mainAxisSpacing: 8.0, // Vertical space between items
                        childAspectRatio: 0.5, // Makes each item square-shaped
                      ),
                      itemCount:
                          images.length + 1, // Image count + 1 for the pink box
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // The first item is the "add image" pink box
                          return GestureDetector(
                            onTap:
                                _pickImage, // Open the image picker when clicked
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 255, 225, 225), // Light pink color
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(Icons.add_circle_outline,
                                    size: 50, color: Colors.black),
                              ),
                            ),
                          );
                        } else {
                          // Display uploaded images, starting from the second index
                          int imageIndex = index -
                              1; // Adjust the index to account for the pink box
                          return GestureDetector(
                            onTap: () {
                              // Open image in dialog when tapped and pass the index for removal
                              _showImageDialog(
                                  context, images[imageIndex], imageIndex);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(images[
                                      imageIndex])), // Show the uploaded image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        ));
  }
}
