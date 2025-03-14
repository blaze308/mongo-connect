import 'package:mongo_dart/mongo_dart.dart';

class PostModel {
  final String objectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Author reference
  final DbRef authorRef;
  final DbRef? lastLikeAuthorRef;

  final List<PostImage> listOfImages;
  final String text;
  final List<String> targetPeople;
  final List<String> targetPeopleIds;
  final int numberOfPictures;
  final List<String> likes;
  final String? video;
  final String? thumbnail;
  final List<String> comments;
  final String? authorId;
  final String? lastLikeAuthorId;

  PostModel({
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.authorRef,
    this.lastLikeAuthorRef,
    required this.listOfImages,
    required this.text,
    required this.targetPeople,
    required this.targetPeopleIds,
    required this.numberOfPictures,
    required this.likes,
    this.video,
    this.thumbnail,
    required this.comments,
    this.authorId,
    this.lastLikeAuthorId,
  });

  /// Factory method to create a `PostModel` from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      // Preserve string-based objectId, use a default if not present
      objectId: json['objectId'] ?? json['_id']?.toString() ?? ObjectId().oid,

      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),

      // Handle Author reference
      authorRef: json['Author'] != null
          ? DbRef('users', ObjectId.parse(json['Author']['objectId']))
          : DbRef('users', ObjectId()),

      // Handle Last Like Author reference
      lastLikeAuthorRef: json['LastLikeAuthor'] != null
          ? DbRef('users', ObjectId.parse(json['LastLikeAuthor']['objectId']))
          : null,

      // Parse list of images
      listOfImages: (json['list_of_images'] as List?)
              ?.map((img) => PostImage.fromJson(img))
              .toList() ??
          [],

      text: json['text'] ?? '',

      // Handling target people
      targetPeople: List<String>.from(json['target_people'] ?? []),
      targetPeopleIds: List<String>.from(json['target_people_ids'] ?? []),

      numberOfPictures: json['numer_of_pictures'] ?? 0,

      // Handling likes
      likes: List<String>.from(json['likes'] ?? []),

      // Video and thumbnail handling
      video: json['video'] is Map ? json['video']['url'] : json['video'],
      thumbnail: json['thumbnail'] is Map
          ? json['thumbnail']['url']
          : json['thumbnail'],

      // Comments
      comments: List<String>.from(json['comments'] ?? []),

      // Additional IDs
      authorId: json['AuthorId'],
      lastLikeAuthorId: json['LastLikeAuthor'] != null
          ? json['LastLikeAuthor']['objectId']
          : null,
    );
  }

  /// Convert `PostModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      "objectId": objectId,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "Author": {
        "\$ref": authorRef.collection,
        "\$id": authorRef.id,
      },
      "AuthorId": authorId,
      "LastLikeAuthor": lastLikeAuthorRef != null
          ? {
              "\$ref": lastLikeAuthorRef!.collection,
              "\$id": lastLikeAuthorRef!.id,
            }
          : null,
      "list_of_images": listOfImages.map((img) => img.toJson()).toList(),
      "text": text,
      "target_people": targetPeople,
      "target_people_ids": targetPeopleIds,
      "numer_of_pictures": numberOfPictures,
      "likes": likes,
      "video": video,
      "thumbnail": thumbnail,
      "comments": comments,
    };
  }

  /// Helper function to parse DateTime safely
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is Map && value['__type'] == 'Date') {
      return DateTime.tryParse(value['iso']) ?? DateTime.now();
    }
    return DateTime.now();
  }

  /// Check if the post should be displayed
  bool shouldDisplay() {
    return text.isNotEmpty || listOfImages.isNotEmpty || video != null;
  }

  /// Method to merge a new post with an existing one
  PostModel merge(PostModel newPost) {
    return PostModel(
      objectId: objectId, // Keep original objectId
      createdAt: createdAt, // Keep original creation date
      updatedAt: newPost.updatedAt, // Update with new timestamp

      // Merge other fields
      authorRef: newPost.authorRef,
      lastLikeAuthorRef: newPost.lastLikeAuthorRef ?? lastLikeAuthorRef,

      // Combine lists or use new lists
      listOfImages: [...listOfImages, ...newPost.listOfImages],
      text: newPost.text.isNotEmpty ? newPost.text : text,
      targetPeople: [...targetPeople, ...newPost.targetPeople],
      targetPeopleIds: [...targetPeopleIds, ...newPost.targetPeopleIds],
      numberOfPictures: newPost.numberOfPictures > 0
          ? newPost.numberOfPictures
          : numberOfPictures,
      likes: [...likes, ...newPost.likes],
      video: newPost.video ?? video,
      thumbnail: newPost.thumbnail ?? thumbnail,
      comments: [...comments, ...newPost.comments],
      authorId: newPost.authorId ?? authorId,
      lastLikeAuthorId: newPost.lastLikeAuthorId ?? lastLikeAuthorId,
    );
  }
}

/// Helper model for images in posts
class PostImage {
  final String name;
  final String url;

  PostImage({required this.name, required this.url});

  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
    };
  }
}
