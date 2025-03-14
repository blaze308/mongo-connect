import 'package:flutter/material.dart';
import 'package:mongo_connect/models/user_model.dart';
import 'package:mongo_connect/services/mongo_utils.dart';

import 'services/mongo_service.dart';

// ignore: must_be_immutable
class UserScreen extends StatefulWidget {
  String userId;
  UserScreen({super.key, required this.userId});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late MongoDBService _mongoDBService;
  late Future<UserModel?> _userFuture;
  final String _usersCollection = 'users'; // Collection name

  @override
  void initState() {
    super.initState();
    _mongoDBService = MongoDBService();
    _userFuture = _fetchUser();
  }

  Future<UserModel?> _fetchUser() async {
    await _mongoDBService.connect();
    return _mongoDBService.getUserById(widget.userId);
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

    // Refresh the user data
    setState(() {
      _userFuture = _fetchUser();
    });
  }

  Future<void> _toggleAvatarFramePermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUseAvatarFrame(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the user data
    setState(() {
      _userFuture = _fetchUser();
    });
  }

  Future<void> _togglePartyThemePermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUsePartyTheme(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the user data
    setState(() {
      _userFuture = _fetchUser();
    });
  }

  Future<void> _toggleEntranceEffectPermission(
      String userId, bool currentValue) async {
    await MongoDBUtils.setCanUseEntranceEffect(
      _usersCollection,
      userId,
      !currentValue,
    );

    // Refresh the user data
    setState(() {
      _userFuture = _fetchUser();
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
        title: const Text("User Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("User not found."));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.avatar.isNotEmpty
                          ? NetworkImage(user.avatar["url"] ?? "")
                          : null,
                      child: user.avatar.isEmpty
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email ?? "No email",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "${user.first_name} ${user.last_name}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(height: 32),

                // User Bio
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(user.bio),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // MVP Status
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MVP Status",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<DateTime?>(
                          future: MongoDBUtils.getMVPMember(
                              _usersCollection, user.objectId),
                          builder: (context, mvpSnapshot) {
                            if (mvpSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            bool isMVP =
                                mvpSnapshot.hasData && mvpSnapshot.data != null;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    isMVP
                                        ? "Active since ${mvpSnapshot.data!.toLocal().toString().split('.')[0]}"
                                        : "Not an MVP member",
                                  ),
                                ),
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
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Permissions
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "User Permissions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Avatar Frame Permission
                        FutureBuilder<bool>(
                          future: MongoDBUtils.getCanUseAvatarFrame(
                              _usersCollection, user.objectId),
                          builder: (context, avatarFrameSnapshot) {
                            if (avatarFrameSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            }

                            bool canUseAvatarFrame =
                                avatarFrameSnapshot.data ?? false;
                            return SwitchListTile(
                              title: const Text("Avatar Frame"),
                              subtitle: Text(
                                  canUseAvatarFrame ? "Enabled" : "Disabled"),
                              value: canUseAvatarFrame,
                              onChanged: (value) =>
                                  _toggleAvatarFramePermission(
                                      user.objectId, canUseAvatarFrame),
                            );
                          },
                        ),

                        const Divider(),

                        // Party Theme Permission
                        FutureBuilder<bool>(
                          future: MongoDBUtils.getCanUsePartyTheme(
                              _usersCollection, user.objectId),
                          builder: (context, partyThemeSnapshot) {
                            if (partyThemeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            }

                            bool canUsePartyTheme =
                                partyThemeSnapshot.data ?? false;
                            return SwitchListTile(
                              title: const Text("Party Theme"),
                              subtitle: Text(
                                  canUsePartyTheme ? "Enabled" : "Disabled"),
                              value: canUsePartyTheme,
                              onChanged: (value) => _togglePartyThemePermission(
                                  user.objectId, canUsePartyTheme),
                            );
                          },
                        ),

                        const Divider(),

                        // Entrance Effect Permission
                        FutureBuilder<bool>(
                          future: MongoDBUtils.getCanUseEntranceEffect(
                              _usersCollection, user.objectId),
                          builder: (context, entranceEffectSnapshot) {
                            if (entranceEffectSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            }

                            bool canUseEntranceEffect =
                                entranceEffectSnapshot.data ?? false;
                            return SwitchListTile(
                              title: const Text("Entrance Effect"),
                              subtitle: Text(canUseEntranceEffect
                                  ? "Enabled"
                                  : "Disabled"),
                              value: canUseEntranceEffect,
                              onChanged: (value) =>
                                  _toggleEntranceEffectPermission(
                                      user.objectId, canUseEntranceEffect),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Reported Content
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Reported Content",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Reported Comments
                        const Text(
                          "Reported Comments",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<List<String>>(
                          future: MongoDBUtils.getReportedCommentID(
                              _usersCollection, user.objectId),
                          builder: (context, commentSnapshot) {
                            if (commentSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            }

                            List<String> reportedComments =
                                commentSnapshot.data ?? [];

                            if (reportedComments.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No reported comments"),
                              );
                            }

                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 150,
                              child: ListView.builder(
                                itemCount: reportedComments.length,
                                itemBuilder: (context, idx) {
                                  return ListTile(
                                    title: Text(
                                        "Comment ID: ${reportedComments[idx]}"),
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
                                          _userFuture = _fetchUser();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Reported Replies
                        const Text(
                          "Reported Replies",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<List<String>>(
                          future: MongoDBUtils.getReportedReplyID(
                              _usersCollection, user.objectId),
                          builder: (context, replySnapshot) {
                            if (replySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            }

                            List<String> reportedReplies =
                                replySnapshot.data ?? [];

                            if (reportedReplies.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No reported replies"),
                              );
                            }

                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 150,
                              child: ListView.builder(
                                itemCount: reportedReplies.length,
                                itemBuilder: (context, idx) {
                                  return ListTile(
                                    title: Text(
                                        "Reply ID: ${reportedReplies[idx]}"),
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
                                          _userFuture = _fetchUser();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
