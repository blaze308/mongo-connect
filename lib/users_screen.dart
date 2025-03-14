import 'package:flutter/material.dart';
import 'package:mongo_connect/models/user_model.dart';
import 'package:mongo_connect/services/mongo_utils.dart';
import 'services/mongo_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late MongoDBService _mongoDBService;
  late Future<List<UserModel>> _usersFuture;
  final String _usersCollection = 'users'; // Collection name

  @override
  void initState() {
    super.initState();
    _mongoDBService = MongoDBService();
    _usersFuture = _fetchUsers();
  }

  Future<List<UserModel>> _fetchUsers() async {
    await _mongoDBService.connect();

    // Instead of using the service directly, we'll use the MongoDBUtils
    // But we still need to get all users, so we'll keep this method
    return _mongoDBService.getAllUsers();
  }

  Future<void> _toggleMVPStatus(String userId, bool isCurrentlyMVP) async {
    if (isCurrentlyMVP) {
      // User is already MVP, do nothing or handle differently
    } else {
      // Set user as MVP
      await MongoDBUtils.setMVPMember(
        _usersCollection,
        userId,
        DateTime.now(),
      );
    }

    // Refresh the users list
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  Future<void> _toggleAvatarFramePermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUseAvatarFrame(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the users list
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  Future<void> _togglePartyThemePermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUsePartyTheme(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the users list
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  Future<void> _toggleEntranceEffectPermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUseEntranceEffect(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the users list
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  Future<void> _addNewUser() async {
    UserModel newUser = UserModel(
      username: "newUser123",
      name: "New User",
      bio: "Hello, I just joined!",
      avatar: {
        "url":
            "https://plus.unsplash.com/premium_photo-1676998930980-fc6d4922c0b7?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bmV3JTIwdXNlcnxlbnwwfHwwfHx8MA%3D%3D"
      },
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastOnline: DateTime.now(),
      birthday: DateTime(2000, 1, 1),
      first_name: "New",
      last_name: "User",
      gender: "Male",
      live_cover: {},
      password: "password123",
      geopoint: {},
      using_avatar_frame: {},
      using_entrance_effect: {},
      using_party_theme: {},
    );

    // Add the user to the database
    await _mongoDBService.createUser(newUser, context);

    // Set default permissions for new user
    await MongoDBUtils.setCanUseAvatarFrame(
        _usersCollection, newUser.objectId, false);
    await MongoDBUtils.setCanUsePartyTheme(
        _usersCollection, newUser.objectId, false);
    await MongoDBUtils.setCanUseEntranceEffect(
        _usersCollection, newUser.objectId, false);

    // Refresh the users list
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  @override
  void dispose() {
    _mongoDBService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found."));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundImage: user.avatar.isNotEmpty
                        ? NetworkImage(user.avatar["url"] ?? "")
                        : null,
                    child:
                        user.avatar.isEmpty ? const Icon(Icons.person) : null,
                  ),
                  title: Text(user.username),
                  subtitle: Text(user.email ?? "No email"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bio: ${user.bio}"),
                          const SizedBox(height: 8),
                          FutureBuilder<DateTime?>(
                            future: MongoDBUtils.getMVPMember(
                                _usersCollection, user.objectId),
                            builder: (context, mvpSnapshot) {
                              bool isMVP = mvpSnapshot.hasData &&
                                  mvpSnapshot.data != null;
                              return Row(
                                children: [
                                  Text(
                                      "MVP Status: ${isMVP ? 'Active since ${mvpSnapshot.data!.toLocal()}' : 'Not MVP'}"),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _toggleMVPStatus(user.objectId, isMVP),
                                    child:
                                        Text(isMVP ? "Revoke MVP" : "Make MVP"),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<bool>(
                            future: MongoDBUtils.getCanUseAvatarFrame(
                                _usersCollection, user.objectId),
                            builder: (context, avatarFrameSnapshot) {
                              bool canUseAvatarFrame =
                                  avatarFrameSnapshot.data ?? false;
                              return Row(
                                children: [
                                  Text(
                                      "Avatar Frame: ${canUseAvatarFrame ? 'Enabled' : 'Disabled'}"),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: canUseAvatarFrame,
                                    onChanged: (value) =>
                                        _toggleAvatarFramePermission(
                                            user.objectId, canUseAvatarFrame),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<bool>(
                            future: MongoDBUtils.getCanUsePartyTheme(
                                _usersCollection, user.objectId),
                            builder: (context, partyThemeSnapshot) {
                              bool canUsePartyTheme =
                                  partyThemeSnapshot.data ?? false;
                              return Row(
                                children: [
                                  Text(
                                      "Party Theme: ${canUsePartyTheme ? 'Enabled' : 'Disabled'}"),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: canUsePartyTheme,
                                    onChanged: (value) =>
                                        _togglePartyThemePermission(
                                            user.objectId, canUsePartyTheme),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<bool>(
                            future: MongoDBUtils.getCanUseEntranceEffect(
                                _usersCollection, user.objectId),
                            builder: (context, entranceEffectSnapshot) {
                              bool canUseEntranceEffect =
                                  entranceEffectSnapshot.data ?? false;
                              return Row(
                                children: [
                                  Text(
                                      "Entrance Effect: ${canUseEntranceEffect ? 'Enabled' : 'Disabled'}"),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: canUseEntranceEffect,
                                    onChanged: (value) =>
                                        _toggleEntranceEffectPermission(
                                            user.objectId,
                                            canUseEntranceEffect),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<List<String>>(
                            future: MongoDBUtils.getReportedCommentID(
                                _usersCollection, user.objectId),
                            builder: (context, commentSnapshot) {
                              List<String> reportedComments =
                                  commentSnapshot.data ?? [];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Reported Comments: ${reportedComments.length}"),
                                  if (reportedComments.isNotEmpty)
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount: reportedComments.length,
                                        itemBuilder: (context, idx) {
                                          return ListTile(
                                            dense: true,
                                            title: Text(reportedComments[idx]),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                await MongoDBUtils
                                                    .removeReportedCommentID(
                                                  _usersCollection,
                                                  user.objectId,
                                                  reportedComments[idx],
                                                );
                                                setState(() {
                                                  _usersFuture = _fetchUsers();
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<List<String>>(
                            future: MongoDBUtils.getReportedReplyID(
                                _usersCollection, user.objectId),
                            builder: (context, replySnapshot) {
                              List<String> reportedReplies =
                                  replySnapshot.data ?? [];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Reported Replies: ${reportedReplies.length}"),
                                  if (reportedReplies.isNotEmpty)
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount: reportedReplies.length,
                                        itemBuilder: (context, idx) {
                                          return ListTile(
                                            dense: true,
                                            title: Text(reportedReplies[idx]),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                await MongoDBUtils
                                                    .removeReportedReplyID(
                                                  _usersCollection,
                                                  user.objectId,
                                                  reportedReplies[idx],
                                                );
                                                setState(() {
                                                  _usersFuture = _fetchUsers();
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewUser,
        tooltip: 'Add New User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
