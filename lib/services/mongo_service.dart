// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mongo_connect/models/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer' as developer;
import '../models/post_model.dart';

class MongoDBService {
  // Uncomment the correct URL as needed.
  // static const String MONGO_URL = "mongodb+srv://admin:admin@e2e-test-db.vkml0lr.mongodb.net/";
  static const String MONGO_URL =
      "mongodb+srv://admin:admin@e2e-test-db.vkml0lr.mongodb.net/ancientflip-test-db?retryWrites=true&w=majority";

  static const String USER_COLLECTION = "users";
  static const String POST_COLLECTION = "posts";

  late Db _db;
  late DbCollection _users;
  late DbCollection _posts;

  // Singleton pattern
  static final MongoDBService _instance = MongoDBService._internal();

  factory MongoDBService() {
    return _instance;
  }

  MongoDBService._internal();

  // Initialize the database connection
  Future<void> connect() async {
    try {
      _db = await Db.create(MONGO_URL);
      await _db.open();
      _users = _db.collection(USER_COLLECTION);
      _posts = _db.collection(POST_COLLECTION); // ✅ Add posts collection
      developer.log('Connected to MongoDB');
      developer.log("_users db : ${_users.db}");
      developer.log("_users collection : ${_users.collectionName}");
      developer.log("_posts collection : ${_posts.collectionName}");
    } catch (e) {
      developer.log('Error connecting to MongoDB: $e');
      rethrow;
    }
  }

  // Close the database connection
  Future<void> close() async {
    await _db.close();
  }

  // ✅ Fetch paginated users
  Future<List<UserModel>> getAllUsers({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final users = await _users
          .find(where.sortBy('createdAt') // Sort alphabetically by username
              // .skip((pageNumber - 1) * pageSize) // Skip previous pages
              // .limit(pageSize), // Limit users per page
              )
          .toList(); // Convert stream to list

      for (var user in users) {
        developer
            .log("User Raw Data: $user"); // Debugging: Print raw MongoDB data
      }

      return users.map((json) => UserModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      developer.log('Error fetching users: $e');
      developer
          .log('StackTrace: $stackTrace'); // Print detailed error stack trace
      rethrow;
    }
  }

  // ✅ Fetch user by ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final user = await _users.findOne(where.eq('objectId', id));
      return user != null ? UserModel.fromJson(user) : null;
    } catch (e) {
      developer.log('Error fetching user by ID: $e');
      rethrow;
    }
  }

  // ✅ Fetch user by username
  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final user = await _users.findOne(where.eq('username', username));
      return user != null ? UserModel.fromJson(user) : null;
    } catch (e) {
      developer.log('Error fetching user by username: $e');
      rethrow;
    }
  }

  // // ✅ Create new user
  Future<bool> createUser(UserModel user, BuildContext context) async {
    try {
      // Check if username already exists
      final existingUser =
          await _users.findOne(where.eq('username', user.username));

      if (existingUser != null) {
        // Username already exists, show snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username "${user.username}" already exists!'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        return false; // User creation failed
      }

      // No duplicate found, proceed with user creation
      await _users.insert(user.toJson());
      developer.log("User created successfully: ${user.username}");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User "${user.username}" created successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      return true; // User creation successful
    } catch (e) {
      developer.log('Error creating user: $e');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating user: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );

      return false; // User creation failed
    }
  }

  // ✅ Fetch all posts
  Future<List<PostModel>> getAllPosts() async {
    try {
      final posts = await _posts
          .find(where.limit(100).sortBy(
                "createdAt",
                descending: true,
              ))
          .toList();
      return posts.map((json) => PostModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      developer.log('Error fetching posts: $e');
      developer.log('StackTrace: $stackTrace');
      rethrow;
    }
  }

  // ✅ Fetch paginated posts
  Future<List<PostModel>> getPostsPaginated(
      {int pageNumber = 1, int pageSize = 10}) async {
    try {
      final posts = await _posts
          .find(
            where
                .sortBy('createdAt', descending: true) // Sort by newest first
                .skip((pageNumber - 1) * pageSize)
                .limit(pageSize),
          )
          .toList();

      return posts.map((json) => PostModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      developer.log('Error fetching paginated posts: $e');
      developer.log('StackTrace: $stackTrace');
      rethrow;
    }
  }

  // ✅ Provide access to collections dynamically
  DbCollection getCollection(String collectionName) {
    if (collectionName == USER_COLLECTION) return _users;
    if (collectionName == POST_COLLECTION) return _posts;
    throw Exception("Collection '$collectionName' not found");
  }
}
