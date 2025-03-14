class InstallationModel {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String installationId;
  final String deviceToken;
  final String deviceType;
  final String pushType;
  final String? gcmSenderId;
  final String timeZone;
  final String localeIdentifier;
  final int badge;
  final String appVersion;
  final String appName;
  final String appIdentifier;
  final String userId;

  InstallationModel({
    required this.createdAt,
    required this.updatedAt,
    required this.installationId,
    required this.deviceToken,
    required this.deviceType,
    required this.pushType,
    this.gcmSenderId,
    required this.timeZone,
    required this.localeIdentifier,
    required this.badge,
    required this.appVersion,
    required this.appName,
    required this.appIdentifier,
    required this.userId,
  });

  /// Factory method to create `InstallationModel` from JSON
  factory InstallationModel.fromJson(Map<String, dynamic> json) {
    return InstallationModel(
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      installationId: json['installationId'],
      deviceToken: json['deviceToken'],
      deviceType: json['deviceType'],
      pushType: json['pushType'],
      gcmSenderId: json['GCMSenderId'],
      timeZone: json['timeZone'],
      localeIdentifier: json['localeIdentifier'],
      badge: json['badge'] ?? 0,
      appVersion: json['appVersion'],
      appName: json['appName'],
      appIdentifier: json['appIdentifier'],
      userId: json['user']?['objectId'] ?? '', // Extracting user reference
    );
  }

  /// Convert `InstallationModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "installationId": installationId,
      "deviceToken": deviceToken,
      "deviceType": deviceType,
      "pushType": pushType,
      "GCMSenderId": gcmSenderId,
      "timeZone": timeZone,
      "localeIdentifier": localeIdentifier,
      "badge": badge,
      "appVersion": appVersion,
      "appName": appName,
      "appIdentifier": appIdentifier,
      "user": userId, // Storing reference as a string (MongoDB ObjectId)
    };
  }

  /// Helper function to parse DateTime safely
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}
