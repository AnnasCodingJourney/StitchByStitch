/*
ChatGpt used for generating user_service.dart.
Manages all operations related to user data, 
such as saving, loading, authentication, adding images, 
updating user details, and deleting users. 
It interacts with the JSON file where user data is stored.
*/



import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'user_model.dart';

class UserService {
  final String _fileName = "users.json";

  /// Load users from the JSON file
  Future<UserList> loadUsers() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      // Return empty UserList if file does not exist
      if (!file.existsSync()) return UserList(users: []);

      String jsonString = await file.readAsString();
      Map<String, dynamic> jsonData = json.decode(jsonString);

      return UserList.fromJson(jsonData);
    } catch (e) {
      print("Error loading users: $e");
      return UserList(users: []);
    }
  }

  /// Save the updated user list to the JSON file
  Future<void> saveUsers(UserList userList) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      String jsonString = json.encode(userList.toJson());
      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error saving users: $e");
    }
  }

  /// Add a new user to the JSON file
  Future<void> addUser(User user) async {
    UserList userList = await loadUsers();
    userList.users.add(user);
    await saveUsers(userList);
  }

  /// Authenticate user by checking username and password
  Future<bool> authenticateUser(String username, String password) async {
    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.username == username && user.password == password) {
        return true; // Login successful
      }
    }
    return false; // Login failed
  }

  /// Retrieve a user by username
  Future<User?> getUser(String username) async {
    UserList userList = await loadUsers();
    try {
      return userList.users.firstWhere((user) => user.username == username);
    } catch (e) {
      return null; // User not found
    }
  }

  /// Add an image path to a specific user's uploads
  Future<void> addImageToUser(String username, String imagePath) async {
    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.username == username) {
        user.uploads.add(imagePath);  // Add image path to the user's uploads
        await saveUsers(userList);    // Save updated users to the file
        return;
      }
    }
  }

  /// Delete a user account
  Future<void> deleteUser(String username) async {
    UserList userList = await loadUsers();
    userList.users.removeWhere((user) => user.username == username);
    await saveUsers(userList);
  }

  /// Update a user's password
  Future<bool> updateUserPassword(String username, String newPassword) async {
    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.username == username) {
        user.password = newPassword;
        await saveUsers(userList);
        return true; // Password updated successfully
      }
    }
    return false; // User not found
  }

  /// Update a user's email
  Future<bool> updateUserEmail(String username, String newEmail) async {
    if (await checkEmailExists(newEmail)) return false; // Prevent duplicate emails

    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.username == username) {
        user.email = newEmail;
        await saveUsers(userList);
        return true; // Email updated successfully
      }
    }
    return false; // User not found
  }

  /// Check if an email already exists in the user data
  Future<bool> checkEmailExists(String email) async {
    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.email == email) {
        return true;  // Email already exists
      }
    }
    return false;  // Email does not exist
  }

  /// Update a user's uploaded images
  Future<void> updateUserUploads(String username, List<String> newUploads) async {
    UserList userList = await loadUsers();
    for (var user in userList.users) {
      if (user.username == username) {
        user.uploads = newUploads;  // Update the uploads list with the new images
        await saveUsers(userList);  // Save the updated user list back to the file
        return;
      }
    }
  }
}
