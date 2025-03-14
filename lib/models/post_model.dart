class PostModel {
  final String? objectId; // Parse Server ID
  final DateTime createdAt;
  final DateTime updatedAt;
  final String authorId; // Reference to UserModel
  final String? lastLikeAuthorId; // Reference to LastLikeAuthor
  final List<PostImage> listOfImages;
  final String text;
  final List<String> targetPeople;
  final List<String> targetPeopleIds;
  final int numberOfPictures;
  final List<String> likes;
  final String? video;
  final String? thumbnail;
  final List<String> comments;

  PostModel({
    this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.authorId,
    this.lastLikeAuthorId,
    required this.listOfImages,
    required this.text,
    required this.targetPeople,
    required this.targetPeopleIds,
    required this.numberOfPictures,
    required this.likes,
    this.video,
    this.thumbnail,
    required this.comments,
  });

  /// Factory method to create a `PostModel` from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      objectId: json['objectId'],
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      authorId: json['AuthorId'],
      lastLikeAuthorId: json['LastLikeAuthor'] is Map<String, dynamic>
          ? json['LastLikeAuthor']['objectId'] as String
          : null,
      listOfImages: (json['list_of_images'] as List<dynamic>?)
              ?.map((img) => PostImage.fromJson(img))
              .toList() ??
          [],
      text: json['text'] ?? '',
      targetPeople: List<String>.from(json['target_people'] ?? []),
      targetPeopleIds: List<String>.from(json['target_people_ids'] ?? []),
      numberOfPictures: json['numer_of_pictures'] ?? 0,
      likes: List<String>.from(json['likes'] ?? []),
      video: json.containsKey('video') && json['video'] != null
          ? json['video']['url']
          : null,
      thumbnail: json.containsKey('thumbnail') && json['thumbnail'] != null
          ? json['thumbnail']['url']
          : null,
      comments: List<String>.from(json['comments'] ?? []),
    );
  }

  /// Convert `PostModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      "objectId": objectId,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "AuthorId": authorId,
      "LastLikeAuthorId": lastLikeAuthorId,
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

  /// Check if the post should be displayed
  bool shouldDisplay() {
    return text.isNotEmpty || listOfImages.isNotEmpty || video != null;
  }

  /// Helper function to parse DateTime safely
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}

/// Helper model for images in posts
class PostImage {
  final String name;
  final String url;

  PostImage({required this.name, required this.url});

  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
    };
  }
}
