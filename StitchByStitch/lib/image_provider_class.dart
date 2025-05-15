/* ChatGpt used for generating image_provider class. 
This loads images to sharedPreferences and helps accessing them.
Technically not needed, could be handled with JSON file but that didn't work. 
Data persistance for userer's upload 
part of Provider package in flutter 
*/


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProviderClass with ChangeNotifier {
  List<String> _imagePaths = [];  // List to store image paths

  List<String> get imagePaths => _imagePaths; // getter to access imagePaths

  // Load images for a specific username
  Future<void> loadImages(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? loadedPaths = prefs.getStringList(username);
    _imagePaths = loadedPaths!; //Assigns retrieved images to the _imagePaths list.
      notifyListeners();  // Notify listeners (UI) about the change
  }

  // Save images to SharedPreferences for the specific username
  Future<void> saveImages(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); //Reads the list of images stored for the username.
    prefs.setStringList(username, _imagePaths);  // Save image paths for the user
  }

  // Add a new image path
  void addImage(String path) {
    _imagePaths.add(path);
    notifyListeners();  // Notify listeners (UI) about the change
  }

  // Remove an image path
  void removeImage(int index) {
    _imagePaths.removeAt(index);
    notifyListeners();  // Notify listeners (UI) about the change
  }

  // Set image paths (can be used to load saved images)
  void setImages(List<String> paths) {
    _imagePaths = paths;
    notifyListeners();  // Notify listeners (UI) about the change
  }
}
