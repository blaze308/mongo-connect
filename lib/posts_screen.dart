// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'models/post_model.dart';
// import 'models/user_model.dart';
// import 'services/mongo_service.dart';

// class AllPostsPage extends StatefulWidget {
//   @override
//   _AllPostsPageState createState() => _AllPostsPageState();
// }

// class _AllPostsPageState extends State<AllPostsPage> {
//   final MongoDBService _mongoService = MongoDBService();
//   List<PostModel> _posts = [];
//   Map<String, UserModel> _usersCache = {}; // Cache to store user data
//   bool _isLoading = true;
//   bool _hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPosts();
//   }

//   Future<void> _fetchPosts() async {
//     try {
//       await _mongoService.connect();
//       List<PostModel> posts = await _mongoService.getAllPosts();
//       posts = posts
//           .where((post) => post.shouldDisplay())
//           .toList(); // ✅ Filter posts

//       // Fetch users only if not cached
//       for (var post in posts) {
//         if (!_usersCache.containsKey(post.authorId)) {
//           UserModel? user = await _mongoService.getUserById(post.authorId);
//           if (user != null) _usersCache[post.authorId] = user;
//         }
//       }

//       setState(() {
//         _posts = posts;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching posts: $e');
//       setState(() {
//         _isLoading = false;
//         _hasError = true;
//       });
//     } finally {
//       await _mongoService.close();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('All Posts')),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _hasError
//               ? Center(child: Text('Error loading posts'))
//               : ListView.builder(
//                   itemCount: _posts.length,
//                   itemBuilder: (context, index) {
//                     final post = _posts[index];
//                     final user = _usersCache[post.authorId];

//                     return Card(
//                       margin: EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListTile(
//                             leading: user?.avatar["url"] != null
//                                 ? CircleAvatar(
//                                     backgroundImage:
//                                         NetworkImage(user!.avatar["url"]!))
//                                 : Icon(Icons.person),
//                             title: Text(user?.name ?? 'Unknown'),
//                           ),
//                           if (post.text.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 post.text,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           if (post.listOfImages.isNotEmpty)
//                             Image.network(post.listOfImages.first.url,
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover),
//                           if (post.video != null)
//                             VideoPlayerWidget(videoUrl: post.video!),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }

// /// ✅ Widget for playing videos
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {}); // Update UI when initialized
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _togglePlay() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? GestureDetector(
//             onTap: _togglePlay,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//                 if (!_isPlaying)
//                   Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
//               ],
//             ),
//           )
//         : Center(child: CircularProgressIndicator());
//   }
// }
