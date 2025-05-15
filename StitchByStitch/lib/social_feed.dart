import 'package:flutter/material.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/functions.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:flutter_application_1/search_bar.dart';
import 'package:flutter_application_1/secondpage.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

// chatGPT was used to ensure data persistance and work with share preferences. Keep image upload persistance in app and for user

class SocialFeed extends StatefulWidget {
  const SocialFeed({super.key});

  @override
  _SocialFeedState createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  final List<Map<String, dynamic>> posts = [];
  final TextEditingController _descriptionController = TextEditingController();
  int currentPageIndex = 2;

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
  void initState() {
    super.initState();
    _loadPosts(); // Load posts when the feed is first shown Generated with ChatGPT to ensure data persistance
  }

  // Load posts for the user from SharedPreferences - ChatGpt genereated this for data persistance
  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? postPaths =
        prefs.getStringList("new_user_posts"); // Key specific to the user

    setState(() {
      posts.addAll(postPaths!.map((path) {
        return {
          "username": "annas.knittingjourney",
          "profileImage":
              "https://moderncat.com/wp-content/uploads/2014/03/bigstock-46771525_Andrey_Kuzmin-1-940x640.jpg",
          "postImage": path,
          "caption": "",
          "timeAgo": DateTime.now(),
          "likes": 0,
          "comments": [],
          "shares": 0,
        };
      }).toList());
    });
  }

  // Save the posts for the user- ChatGpt used for saving posts
  Future<void> _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postPaths =
        posts.map((post) => post['postImage'] as String).toList();
    prefs.setStringList("new_user_posts", postPaths); // Save paths for the user
  }

  // Pick an image from gallery and show description dialog ChatGpt used for adding the Image picker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        posts.insert(0, {
          "username": "annas.knittingjourney",
          "profileImage": "https://via.placeholder.com/150",
          "postImage": pickedFile.path,
          "caption": "", // Initially empty caption
          "timeAgo": DateTime.now(),
          "likes": 0,
          "comments": [],
          "shares": 0,
        });
      });
      _savePosts(); // Save the new post to SharedPreferences
      _showDescriptionDialog(posts[0]);
    }
  }

  // Show description dialog after picking an image -ChatGpt used to integrate the image description under post
  void _showDescriptionDialog(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Description"),
          content: TextField(
            controller: _descriptionController,
            decoration:
                const InputDecoration(hintText: "Enter description here..."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  post["caption"] = _descriptionController.text;
                });
                _descriptionController.clear();
                _savePosts(); // Save the updated post to SharedPreferences
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  // Handle delete post action ChatGpt used to delete post.
  void _deletePost(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Post"),
          content: const Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  posts.removeAt(index); // Remove the post from the list
                });
                _savePosts(); // Save the updated list of posts
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without deleting
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Show information about the weekly challenge ChatGpt used to make this display information
  void _showWeeklyChallengeInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Weekly Challenge Information"),
          content: const Text(
            "This post only stays on the feed for 7 days and is then removed, "
            "this is why it doesn't appear on your profile. For a permanent image post, "
            "go to your profile and upload the image there.",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchAppBar(),
          leading: GestureDetector(
            onTap: () {
              // Navigate to the second page when the avatar is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Secondpage(username: "annas.knittingjourney")),
              );
            },
          ),
        ),
        body: Column(
          children: [
            // Weekly Challenge Banner as a clickable button
            GestureDetector(
              onTap: _showWeeklyChallengeInfo,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 137, 57, 57),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                ),
                child: const Center(
                  child: Text(
                    "Weekly challenge!\nUpload your first ever knitted project here",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Upload Button
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 225, 225),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 4, offset: Offset(0, 5)),
                ],
              ),
              child: GestureDetector(
                onTap: _pickImage,
                child: const Center(
                  child: Icon(Icons.file_upload_outlined,
                      color: Colors.black, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Expanded ListView to prevent scrolling overlap with AppBar
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index]; // Get each post data
                  return PostCard(
                    index: index, // Pass the index for deletion
                    username: post["username"],
                    profileImage: post["profileImage"],
                    postImage: post["postImage"],
                    caption: post["caption"],
                    timeAgo: post["timeAgo"],
                    likes: post["likes"],
                    comments: List<String>.from(post["comments"]),
                    shares: post["shares"],
                    onDelete: _deletePost, // Pass the delete callback
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onTap: (index) => onTabTapped(context, index),
        ));
  }
}

class PostCard extends StatefulWidget {
  final int index;
  final String username;
  final String profileImage;
  final String postImage;
  final String caption;
  final DateTime timeAgo;
  final int likes;
  final List<String> comments;
  final int shares;
  final Function(int) onDelete; // Function for deleting a post

  const PostCard({
    super.key,
    required this.index,
    required this.username,
    required this.profileImage,
    required this.postImage,
    required this.caption,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.onDelete, // Add this callback to delete a post
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  bool isLiked = false;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
      } else {
        likes++;
      }
      isLiked = !isLiked;
    });
  }

  void addComment() {
    setState(() {
      if (commentController.text.isNotEmpty) {
        widget.comments.add(commentController.text); //add comment to the list
        commentController.clear(); // clear the input field
      }
    });
  }

  //share post functionality with share_plus
  void sharePost() {
    Share.share("Check out this post: ${widget.postImage}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // White background
      margin: const EdgeInsets.only(bottom: 8), // Space between posts
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            title: Text(
              widget.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.timeAgo.hour}:${widget.timeAgo.minute}', // Example time format
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    // Show the delete confirmation dialog
                    widget.onDelete(widget.index);
                  },
                ),
              ],
            ),
          ),
          // Post Image
          GestureDetector(
            onDoubleTap: toggleLike,
            child: Image.file(
              File(widget.postImage),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400, // Set a fixed height for consistency
            ),
          ),
          // Post Caption
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.caption),
          ),
          // Post Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: toggleLike,
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(likes.toString()),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.mode_comment_outlined),
                    const SizedBox(width: 4),
                    Text(widget.comments.length.toString()),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: sharePost,
                        child: const Icon(Icons.share_outlined)),
                    const SizedBox(width: 4),
                    Text(widget.shares.toString()),
                  ],
                ),
              ],
            ),
          ),
          // Comment Section
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                  color: Color.fromARGB(255, 255, 225, 225),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Comments:",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      ),
                      for (var comment in widget.comments)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            comment,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // comment input box
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 2,
                                color: const Color.fromARGB(255, 107, 107, 107),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 2,
                                color: const Color.fromARGB(255, 107, 107, 107),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 3.5,
                                color: Color.fromARGB(255, 137, 57, 57),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //send comment icon
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color:
                                Color.fromARGB(255, 137, 57, 57), // Icon color
                          ),
                          onPressed: addComment,
                        ),
                      ),
                    ],
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
