// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:mongo_connect/services/mongo_utils.dart';

class UserModel {
  final String objectId;
  final int uid;
  final Map<String, String> avatar;
  final String bio;
  final String first_name;
  final String gender;
  final String last_name;
  final Map<String, String> live_cover;
  final String name;
  final String password;
  final String username;
  final DateTime birthday;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? super_vip;
  final DateTime? dailyGift;
  final DateTime? diamond_vip;
  final DateTime lastOnline;
  final DateTime? normal_vip;
  final bool accept_calls;
  final bool emailVerified;
  final String? email;
  final bool accountDeleted;
  final Map<String, dynamic> authData;
  final List<String> app_language;
  final List<Map<String, dynamic>> blockedUsers;
  final List<String> blockedUsersIDs;
  final bool can_use_entrance_effect;
  final bool can_use_using_avatar_frame;
  final bool can_use_using_party_theme;
  final List<String> chat_with_users;
  final String? country;
  final String? country_code;
  final String? country_dial_code;
  final num credit;
  final num creditSent;
  final String? currency_code;
  final String? currency_symbiol;
  final num diamonds;
  final num diamondsTotal;
  final String? email_public;
  final String? fan_club_name;
  final List<String> followers;
  final List<String> following;
  final bool hasGeopoint;
  final bool has_password;
  final Map<String, dynamic> geopoint;
  final bool invisible_visitor;
  final bool inviteQuestion;
  final String? invitedByUser;
  final bool live_opening_alert;
  final List<Map<String, dynamic>> list_of_images;
  final bool message_notification_switch;
  final bool mysterious_man;
  final bool mystery_man;
  final List<String> my_obtained_items;
  final bool photo_verified;
  final String? phone_number;
  final String? phone_number_full;
  final int platformSpeakerNumber;
  final List<String> post_ids_list;
  final bool prefLocationType;
  final int prefMaxAge;
  final int prefMinAge;
  final String? profile_language;
  final List<String> reported_comments;
  final List<String> reportedPostsID;
  final String? reportedPostReason;
  final String? role;
  final String? secondary_password;
  final bool sound;
  final String? select_payment_method;
  final String? usdt_contact_address;
  final Map<String, String> using_avatar_frame;
  final String? using_avatar_frame_id;
  final Map<String, String> using_entrance_effect;
  final String? using_entrance_effect_id;
  final Map<String, String> using_party_theme;
  final String? using_party_theme_id;
  final String? user_state_in_app;
  final bool vibrate;

  UserModel({
    String? objectId,
    required this.avatar,
    required this.bio,
    required this.birthday,
    required this.createdAt,
    required this.first_name,
    required this.gender,
    required this.last_name,
    required this.live_cover,
    required this.name,
    required this.password,
    required this.updatedAt,
    required this.username,
    required this.lastOnline,
    required this.geopoint,
    required this.using_avatar_frame,
    required this.using_entrance_effect,
    required this.using_party_theme,
    this.accept_calls = false,
    this.emailVerified = false,
    this.email,
    this.accountDeleted = false,
    this.authData = const {},
    this.app_language = const [],
    this.blockedUsers = const [],
    this.blockedUsersIDs = const [],
    this.can_use_entrance_effect = false,
    this.can_use_using_avatar_frame = false,
    this.can_use_using_party_theme = false,
    this.chat_with_users = const [],
    this.country,
    this.country_code,
    this.country_dial_code,
    this.credit = 0,
    this.creditSent = 0,
    this.currency_code,
    this.currency_symbiol,
    this.dailyGift,
    this.diamonds = 0,
    this.diamondsTotal = 0,
    this.diamond_vip,
    this.email_public,
    this.fan_club_name,
    this.followers = const [],
    this.following = const [],
    this.hasGeopoint = false,
    this.has_password = false,
    this.invisible_visitor = false,
    this.inviteQuestion = false,
    this.invitedByUser,
    this.live_opening_alert = false,
    this.list_of_images = const [],
    this.message_notification_switch = false,
    this.mysterious_man = false,
    this.mystery_man = false,
    this.my_obtained_items = const [],
    this.normal_vip,
    this.photo_verified = false,
    this.phone_number,
    this.phone_number_full,
    this.platformSpeakerNumber = 0,
    this.post_ids_list = const [],
    this.prefLocationType = false,
    this.prefMaxAge = 0,
    this.prefMinAge = 0,
    this.profile_language,
    this.reported_comments = const [],
    this.reportedPostsID = const [],
    this.reportedPostReason,
    this.role,
    this.secondary_password,
    this.sound = false,
    this.super_vip,
    this.select_payment_method,
    this.usdt_contact_address,
    this.using_avatar_frame_id,
    this.using_entrance_effect_id,
    this.using_party_theme_id,
    this.user_state_in_app,
    this.vibrate = false,
    int? uid,
  })  : uid = uid ?? generateUId(),
        objectId = objectId ?? generateObjectId();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      objectId: json["objectId"] ?? generateObjectId(),
      uid: json['uid'],
      avatar: Map<String, String>.from(json['avatar'] ?? {}),
      bio: json['bio'] ?? '',
      birthday: _parseDateTime(json['birthday']),
      createdAt: _parseDateTime(json['createdAt']),
      first_name: json['first_name'] ?? '',
      gender: json['gender'] ?? '',
      last_name: json['last_name'] ?? '',
      live_cover: Map<String, String>.from(json['live_cover'] ?? {}),
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      updatedAt: _parseDateTime(json['updatedAt']),
      username: json['username'] ?? '',
      lastOnline: _parseDateTime(json['lastOnline']),
      geopoint: Map<String, dynamic>.from(json['geopoint'] ?? {}),
      using_avatar_frame:
          Map<String, String>.from(json['using_avatar_frame'] ?? {}),
      using_entrance_effect:
          Map<String, String>.from(json['using_entrance_effect'] ?? {}),
      using_party_theme:
          Map<String, String>.from(json['using_party_theme'] ?? {}),
      accept_calls: json['accept_calls'] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      email: json['email'],
      accountDeleted: json['accountDeleted'] ?? false,
      authData: json['authData'] ?? {},
      app_language: List<String>.from(json['app_language'] ?? []),
      blockedUsers: List<Map<String, dynamic>>.from(json['blockedUsers'] ?? []),
      blockedUsersIDs: List<String>.from(json['blockedUsersIDs'] ?? []),
      can_use_entrance_effect: json['can_use_entrance_effect'] ?? false,
      can_use_using_avatar_frame: json['can_use_using_avatar_frame'] ?? false,
      can_use_using_party_theme: json['can_use_using_party_theme'] ?? false,
      chat_with_users: List<String>.from(json['chat_with_users'] ?? []),
      country: json['country'],
      country_code: json['country_code'],
      country_dial_code: json['country_dial_code'],
      credit: json['credit'] ?? 0,
      creditSent: json['creditSent'] ?? 0,
      currency_code: json['currency_code'],
      currency_symbiol: json['currency_symbiol'],
      dailyGift: _parseDateTime(json['dailyGift']),
      diamonds: json['diamonds'] ?? 0,
      diamondsTotal: json['diamondsTotal'] ?? 0,
      diamond_vip: _parseDateTime(json['diamond_vip']),
      email_public: json['email_public'],
      fan_club_name: json['fan_club_name'],
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      hasGeopoint: json['hasGeopoint'] ?? false,
      has_password: json['has_password'] ?? false,
      invisible_visitor: json['invisible_visitor'] ?? false,
      inviteQuestion: json['inviteQuestion'] ?? false,
      invitedByUser: json['invitedByUser'],
      live_opening_alert: json['live_opening_alert'] ?? false,
      list_of_images:
          List<Map<String, dynamic>>.from(json['list_of_images'] ?? []),
      message_notification_switch: json['message_notification_switch'] ?? false,
      mysterious_man: json['mysterious_man'] ?? false,
      mystery_man: json['mystery_man'] ?? false,
      my_obtained_items: List<String>.from(json['my_obtained_items'] ?? []),
      normal_vip: _parseDateTime(json['normal_vip']),
      photo_verified: json['photo_verified'] ?? false,
      phone_number: json['phone_number'],
      phone_number_full: json['phone_number_full'],
      platformSpeakerNumber: json['platformSpeakerNumber'] ?? 0,
      post_ids_list: List<String>.from(json['post_ids_list'] ?? []),
      prefLocationType: json['prefLocationType'] ?? false,
      prefMaxAge: json['prefMaxAge'] ?? 0,
      prefMinAge: json['prefMinAge'] ?? 0,
      profile_language: json['profile_language'],
      reported_comments: List<String>.from(json['reported_comments'] ?? []),
      reportedPostsID: List<String>.from(json['reportedPostsID'] ?? []),
      reportedPostReason: json['reportedPostReason'],
      role: json['role'],
      secondary_password: json['secondary_password'],
      sound: json['sound'] ?? false,
      super_vip: _parseDateTime(json['super_vip']),
      select_payment_method: json['select_payment_method'],
      usdt_contact_address: json['usdt_contact_address'],
      using_avatar_frame_id: json['using_avatar_frame_id'],
      using_entrance_effect_id: json['using_entrance_effect_id'],
      using_party_theme_id: json['using_party_theme_id'],
      user_state_in_app: json['user_state_in_app'],
      vibrate: json['vibrate'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      "objectId": objectId,
      "uid": uid,
      "avatar": avatar,
      "bio": bio,
      "birthday": birthday.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
      "first_name": first_name,
      "gender": gender,
      "last_name": last_name,
      "live_cover": live_cover,
      "name": name,
      "password": password,
      "updatedAt": updatedAt.toIso8601String(),
      "username": username,
      "lastOnline": lastOnline.toIso8601String(),
      "geopoint": geopoint,
      "using_avatar_frame": using_avatar_frame,
      "using_entrance_effect": using_entrance_effect,
      "using_party_theme": using_party_theme,
      "accept_calls": accept_calls,
      "emailVerified": emailVerified,
      "email": email,
      "accountDeleted": accountDeleted,
      "authData": authData,
      "app_language": app_language,
      "blockedUsers": blockedUsers,
      "blockedUsersIDs": blockedUsersIDs,
      "can_use_entrance_effect": can_use_entrance_effect,
      "can_use_using_avatar_frame": can_use_using_avatar_frame,
      "can_use_using_party_theme": can_use_using_party_theme,
      "chat_with_users": chat_with_users,
      "country": country,
      "country_code": country_code,
      "country_dial_code": country_dial_code,
      "credit": credit,
      "creditSent": creditSent,
      "currency_code": currency_code,
      "currency_symbiol": currency_symbiol,
      "dailyGift": dailyGift?.toIso8601String(),
      "diamonds": diamonds,
      "diamondsTotal": diamondsTotal,
      "diamond_vip": diamond_vip?.toIso8601String(),
      "email_public": email_public,
      "fan_club_name": fan_club_name,
      "followers": followers,
      "following": following,
      "hasGeopoint": hasGeopoint,
      "has_password": has_password,
      "invisible_visitor": invisible_visitor,
      "inviteQuestion": inviteQuestion,
      "invitedByUser": invitedByUser,
      "live_opening_alert": live_opening_alert,
      "list_of_images": list_of_images,
      "message_notification_switch": message_notification_switch,
      "mysterious_man": mysterious_man,
      "mystery_man": mystery_man,
      "my_obtained_items": my_obtained_items,
      "normal_vip": normal_vip?.toIso8601String(),
      "photo_verified": photo_verified,
      "phone_number": phone_number,
      "phone_number_full": phone_number_full,
      "platformSpeakerNumber": platformSpeakerNumber,
      "post_ids_list": post_ids_list,
      "prefLocationType": prefLocationType,
      "prefMaxAge": prefMaxAge,
      "prefMinAge": prefMinAge,
      "profile_language": profile_language,
      "reported_comments": reported_comments,
      "reportedPostsID": reportedPostsID,
      "reportedPostReason": reportedPostReason,
      "role": role,
      "secondary_password": secondary_password,
      "sound": sound,
      "super_vip": super_vip?.toIso8601String(),
      "select_payment_method": select_payment_method,
      "usdt_contact_address": usdt_contact_address,
      "using_avatar_frame_id": using_avatar_frame_id,
      "using_entrance_effect_id": using_entrance_effect_id,
      "using_party_theme_id": using_party_theme_id,
      "user_state_in_app": user_state_in_app,
      "vibrate": vibrate,
    };

    return json;
  }

  // Helper function to parse DateTime safely
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now(); // Default to current time if null
    }
    if (value is DateTime) {
      return value; // Already a DateTime
    }
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  static int generateUId() {
    Random rnd = Random();
    return 1000000000 + rnd.nextInt(999999999);
  }

  static String generateObjectId({int length = 10}) {
    const String chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final Random random = Random.secure();
    return List.generate(
      length,
      (_) {
        var randomNum = chars[random.nextInt(chars.length)];
        return randomNum;
      },
    ).join();
  }

  // 📒GETTERS and SETTERS
  // Getter for reported reply IDs from MongoDB
  Future<List<String>> getReportedReplyID(String collectionName) async {
    return await MongoDBUtils.getReportedReplyID(
      collectionName,
      objectId,
    );
  }

  Future<void> setReportedReplyID(String collectionName, String replyID) async {
    await MongoDBUtils.setReportedReplyID(
      collectionName,
      objectId,
      replyID,
    );
  }

  Future<void> removeReportedReplyID(
      String collectionName, String replyID) async {
    await MongoDBUtils.removeReportedReplyID(
      collectionName,
      objectId,
      replyID,
    );
  }

  Future<List<String>> getReportedCommentID(String collectionName) async {
    return await MongoDBUtils.getReportedCommentID(
      collectionName,
      objectId,
    );
  }

  Future<void> setReportedCommentID(
      String collectionName, String commentID) async {
    await MongoDBUtils.setReportedCommentID(
      collectionName,
      objectId,
      commentID,
    );
  }

  Future<void> removeReportedCommentID(
      String collectionName, String commentID) async {
    await MongoDBUtils.removeReportedCommentID(
      collectionName,
      objectId,
      commentID,
    );
  }

  // MVP Member
  Future<DateTime?> getMVPMember(String collectionName) async {
    return await MongoDBUtils.getMVPMember(
      collectionName,
      objectId,
    );
  }

  Future<void> setMVPMember(String collectionName, DateTime mvpMember) async {
    await MongoDBUtils.setMVPMember(
      collectionName,
      objectId,
      mvpMember,
    );
  }

  // canUseAvatarFrame
  Future<bool> getCanUseAvatarFrame(String collectionName) async {
    return await MongoDBUtils.getCanUseAvatarFrame(
      collectionName,
      objectId,
    );
  }

  Future<void> setCanUseAvatarFrame(String collectionName, bool value) async {
    await MongoDBUtils.setCanUseAvatarFrame(
      collectionName,
      objectId,
      value,
    );
  }

  // canUsePartyTheme
  Future<bool> getCanUsePartyTheme(String collectionName) async {
    return await MongoDBUtils.getCanUsePartyTheme(
      collectionName,
      objectId,
    );
  }

  Future<void> setCanUsePartyTheme(String collectionName, bool value) async {
    await MongoDBUtils.setCanUsePartyTheme(
      collectionName,
      objectId,
      value,
    );
  }

  // canUseEntranceEffect
  Future<bool> getCanUseEntranceEffect(String collectionName) async {
    return await MongoDBUtils.getCanUseEntranceEffect(
      collectionName,
      objectId,
    );
  }

  Future<void> setCanUseEntranceEffect(
      String collectionName, bool value) async {
    await MongoDBUtils.setCanUseEntranceEffect(
      collectionName,
      objectId,
      value,
    );
  }

  Future<Map<String, String>?> getLiveCover(String collectionName) async {
    return await MongoDBUtils.getLiveCover(collectionName, objectId);
  }

  Future<void> setLiveCover(String collectionName,
      {required String name, required String url}) async {
    await MongoDBUtils.setLiveCover(collectionName, objectId,
        name: name, url: url);
  }

  Future<Map<String, String>?> getEntranceEffect(String collectionName) async {
    return await MongoDBUtils.getEntranceEffect(collectionName, objectId);
  }

  Future<void> setEntranceEffect(
      String collectionName, Map<String, String> entranceEffect) async {
    await MongoDBUtils.setEntranceEffect(
        collectionName, objectId, entranceEffect);
  }

  Future<String?> getEntranceEffectId(String collectionName) async {
    return await MongoDBUtils.getEntranceEffectId(collectionName, objectId);
  }

  Future<void> setEntranceEffectId(
      String collectionName, String entranceEffectId) async {
    await MongoDBUtils.setEntranceEffectId(
        collectionName, objectId, entranceEffectId);
  }

  // Party Theme Methods
  Future<Map<String, String>?> getPartyTheme(String collectionName) async {
    return await MongoDBUtils.getPartyTheme(collectionName, objectId);
  }

  Future<void> setPartyTheme(String collectionName,
      {required String name, required String url}) async {
    await MongoDBUtils.setPartyTheme(collectionName, objectId,
        name: name, url: url);
  }

  Future<String?> getPartyThemeId(String collectionName) async {
    return await MongoDBUtils.getPartyThemeId(collectionName, objectId);
  }

  Future<void> setPartyThemeId(
      String collectionName, String partyThemeId) async {
    await MongoDBUtils.setPartyThemeId(collectionName, objectId, partyThemeId);
  }

  // Avatar Frame Methods
  Future<Map<String, String>?> getAvatarFrame(String collectionName) async {
    return await MongoDBUtils.getAvatarFrame(collectionName, objectId);
  }

  Future<void> setAvatarFrame(String collectionName,
      {required String name, required String url}) async {
    await MongoDBUtils.setAvatarFrame(collectionName, objectId,
        name: name, url: url);
  }

  Future<String?> getAvatarFrameId(String collectionName) async {
    return await MongoDBUtils.getAvatarFrameId(collectionName, objectId);
  }

  Future<void> setAvatarFrameId(
      String collectionName, String avatarFrameId) async {
    await MongoDBUtils.setAvatarFrameId(
        collectionName, objectId, avatarFrameId);
  }

  // Obtained Items Methods
  Future<List<String>> getMyObtainedItems(String collectionName) async {
    return await MongoDBUtils.getMyObtainedItems(collectionName, objectId);
  }

  Future<void> setMyObtainedItems(String collectionName, String itemId) async {
    await MongoDBUtils.setMyObtainedItems(collectionName, objectId, itemId);
  }

  Future<void> removeMyObtainedItems(
      String collectionName, String itemId) async {
    await MongoDBUtils.removeMyObtainedItems(collectionName, objectId, itemId);
  }

  // Fan Club Methods
  Future<String?> getMyFanClubId(String collectionName) async {
    return await MongoDBUtils.getMyFanClubId(collectionName, objectId);
  }

  Future<void> setMyFanClubId(String collectionName, String fanClubId) async {
    await MongoDBUtils.setMyFanClubId(collectionName, objectId, fanClubId);
  }

  Future<String?> getMyFanClubName(String collectionName) async {
    return await MongoDBUtils.getMyFanClubName(collectionName, objectId);
  }

  Future<void> setMyFanClubName(
      String collectionName, String fanClubName) async {
    await MongoDBUtils.setMyFanClubName(collectionName, objectId, fanClubName);
  }

  Future<List<String>> getMyFanClubMembers(String collectionName) async {
    return await MongoDBUtils.getMyFanClubMembers(collectionName, objectId);
  }

  Future<void> setMyFanClubMembers(
      String collectionName, String memberId) async {
    await MongoDBUtils.setMyFanClubMembers(collectionName, objectId, memberId);
  }

  Future<void> removeMyFanClubMembers(
      String collectionName, String memberId) async {
    await MongoDBUtils.removeMyFanClubMembers(
        collectionName, objectId, memberId);
  }

  Future<List<String>> getJoinedFanClubIds(String collectionName) async {
    return await MongoDBUtils.getJoinedFanClubIds(collectionName, objectId);
  }

  Future<void> setJoinedFanClubIds(
      String collectionName, String fanClubId) async {
    await MongoDBUtils.setJoinedFanClubIds(collectionName, objectId, fanClubId);
  }

  Future<void> removeJoinedFanClubId(
      String collectionName, String fanClubId) async {
    await MongoDBUtils.removeJoinedFanClubId(
        collectionName, objectId, fanClubId);
  }

  // Face Authentication
  Future<bool> getIsFaceAuthenticated(String collectionName) async {
    return await MongoDBUtils.getIsFaceAuthenticated(collectionName, objectId);
  }

  Future<void> setIsFaceAuthenticated(
      String collectionName, bool isAuthenticated) async {
    await MongoDBUtils.setIsFaceAuthenticated(
        collectionName, objectId, isAuthenticated);
  }

  // Payment Methods
  Future<String?> getSelectedPaymentMethod(String collectionName) async {
    return await MongoDBUtils.getSelectedPaymentMethod(
        collectionName, objectId);
  }

  Future<void> setSelectedPaymentMethod(
      String collectionName, String paymentMethod) async {
    await MongoDBUtils.setSelectedPaymentMethod(
        collectionName, objectId, paymentMethod);
  }

  Future<String?> getUsdtContactAddress(String collectionName) async {
    return await MongoDBUtils.getUsdtContactAddress(collectionName, objectId);
  }

  Future<void> setUsdtContactAddress(
      String collectionName, String usdtContactAddress) async {
    await MongoDBUtils.setUsdtContactAddress(
        collectionName, objectId, usdtContactAddress);
  }

  Future<String?> getWalletAddress(String collectionName) async {
    return await MongoDBUtils.getWalletAddress(collectionName, objectId);
  }

  Future<void> setWalletAddress(
      String collectionName, String walletAddress) async {
    await MongoDBUtils.setWalletAddress(
        collectionName, objectId, walletAddress);
  }

  Future<String?> getPayoneerName(String collectionName) async {
    return await MongoDBUtils.getPayoneerName(collectionName, objectId);
  }

  Future<void> setPayoneerName(
      String collectionName, String payoneerName) async {
    await MongoDBUtils.setPayoneerName(collectionName, objectId, payoneerName);
  }

  Future<String?> getPayPalName(String collectionName) async {
    return await MongoDBUtils.getPayPalName(collectionName, objectId);
  }

  Future<void> setPayPalName(String collectionName, String payPalName) async {
    await MongoDBUtils.setPayPalName(collectionName, objectId, payPalName);
  }

  // Virtual Currency (PCoins)
  Future<int> getPCoins(String collectionName) async {
    return await MongoDBUtils.getPCoins(collectionName, objectId);
  }

  Future<void> setPCoins(String collectionName, int amount) async {
    await MongoDBUtils.setPCoins(collectionName, objectId, amount);
  }

  Future<void> removePCoins(String collectionName, int amount) async {
    await MongoDBUtils.removePCoins(collectionName, objectId, amount);
  }

  // Guardian of King
  Future<bool> isGuardianOfKing(String collectionName) async {
    return await MongoDBUtils.isGuardianOfKing(collectionName, objectId);
  }

  Future<DateTime?> getGuardianOfKing(String collectionName) async {
    return await MongoDBUtils.getGuardianOfKing(collectionName, objectId);
  }

  Future<void> setGuardianOfKing(String collectionName, DateTime date) async {
    await MongoDBUtils.setGuardianOfKing(collectionName, objectId, date);
  }

  // Guardian of Gold
  Future<bool> isGuardianOfGold(String collectionName) async {
    return await MongoDBUtils.isGuardianOfGold(collectionName, objectId);
  }

  Future<DateTime?> getGuardianOfGold(String collectionName) async {
    return await MongoDBUtils.getGuardianOfGold(collectionName, objectId);
  }

  Future<void> setGuardianOfGold(String collectionName, DateTime date) async {
    await MongoDBUtils.setGuardianOfGold(collectionName, objectId, date);
  }

  // Guardian of Silver
  Future<bool> isGuardianOfSilver(String collectionName) async {
    return await MongoDBUtils.isGuardianOfSilver(collectionName, objectId);
  }

  Future<DateTime?> getGuardianOfSilver(String collectionName) async {
    return await MongoDBUtils.getGuardianOfSilver(collectionName, objectId);
  }

  Future<void> setGuardianOfSilver(String collectionName, DateTime date) async {
    await MongoDBUtils.setGuardianOfSilver(collectionName, objectId, date);
  }

  // People Guarding Me
  Future<List<String>> getPeopleGuardingMe(String collectionName) async {
    return await MongoDBUtils.getPeopleGuardingMe(collectionName, objectId);
  }

  Future<void> setPeopleGuardingMe(String collectionName, String userID) async {
    await MongoDBUtils.setPeopleGuardingMe(collectionName, objectId, userID);
  }

  Future<void> removePeopleGuardingMe(
      String collectionName, String userID) async {
    await MongoDBUtils.removePeopleGuardingMe(collectionName, objectId, userID);
  }

  // My Guardians
  Future<List<String>> getMyGuardians(String collectionName) async {
    return await MongoDBUtils.getMyGuardians(collectionName, objectId);
  }

  Future<void> setMyGuardians(String collectionName, String userID) async {
    await MongoDBUtils.setMyGuardians(collectionName, objectId, userID);
  }

  Future<void> removeMyGuardians(String collectionName, String userID) async {
    await MongoDBUtils.removeMyGuardians(collectionName, objectId, userID);
  }

  // Vibrate
  Future<bool> getVibrate(String collectionName) async {
    return await MongoDBUtils.getVibrate(collectionName, objectId);
  }

  Future<void> setVibrate(String collectionName, bool isVibrate) async {
    await MongoDBUtils.setVibrate(collectionName, objectId, isVibrate);
  }

  // Sound
  Future<bool> getSound(String collectionName) async {
    return await MongoDBUtils.getSound(collectionName, objectId);
  }

  Future<void> setSound(String collectionName, bool isSound) async {
    await MongoDBUtils.setSound(collectionName, objectId, isSound);
  }

  Future<bool> getAcceptCalls(String collectionName) async {
    return await MongoDBUtils.getAcceptCalls(collectionName, objectId);
  }

  Future<void> setAcceptCalls(String collectionName, bool value) async {
    await MongoDBUtils.setAcceptCalls(collectionName, objectId, value);
  }

  Future<bool> getMessageNotificationSwitch(String collectionName) async {
    return await MongoDBUtils.getMessageNotificationSwitch(
        collectionName, objectId);
  }

  Future<void> setMessageNotificationSwitch(
      String collectionName, bool value) async {
    await MongoDBUtils.setMessageNotificationSwitch(
        collectionName, objectId, value);
  }

  Future<bool> getLiveOpeningAlert(String collectionName) async {
    return await MongoDBUtils.getLiveOpeningAlert(collectionName, objectId);
  }

  Future<void> setLiveOpeningAlert(String collectionName, bool value) async {
    await MongoDBUtils.setLiveOpeningAlert(collectionName, objectId, value);
  }

  Future<bool> isDiamondVip(String collectionName) async {
    return await MongoDBUtils.isDiamondVip(collectionName, objectId);
  }

  Future<DateTime?> getDiamondVip(String collectionName) async {
    return await MongoDBUtils.getDiamondVip(collectionName, objectId);
  }

  Future<void> setDiamondVip(String collectionName, DateTime date) async {
    await MongoDBUtils.setDiamondVip(collectionName, objectId, date);
  }

  Future<bool> isSuperVip(String collectionName) async {
    return await MongoDBUtils.isSuperVip(collectionName, objectId);
  }

  Future<DateTime?> getSuperVip(String collectionName) async {
    return await MongoDBUtils.getSuperVip(collectionName, objectId);
  }

  Future<void> setSuperVip(String collectionName, DateTime date) async {
    await MongoDBUtils.setSuperVip(collectionName, objectId, date);
  }

  Future<bool> getInvisibleVisitor(String collectionName) async {
    return await MongoDBUtils.getInvisibleVisitor(collectionName, objectId);
  }

  Future<void> setInvisibleVisitor(String collectionName, bool value) async {
    await MongoDBUtils.setInvisibleVisitor(collectionName, objectId, value);
  }

  Future<bool> getMysteriousMan(String collectionName) async {
    return await MongoDBUtils.getMysteriousMan(collectionName, objectId);
  }

  Future<void> setMysteriousMan(String collectionName, bool value) async {
    await MongoDBUtils.setMysteriousMan(collectionName, objectId, value);
  }

  Future<bool> getMysteryMan(String collectionName) async {
    return await MongoDBUtils.getMysteryMan(collectionName, objectId);
  }

  Future<void> setMysteryMan(String collectionName, bool value) async {
    await MongoDBUtils.setMysteryMan(collectionName, objectId, value);
  }

  Future<String> getAppLanguage(String collectionName) async {
    return await MongoDBUtils.getAppLanguage(collectionName, objectId);
  }

  Future<void> setAppLanguage(String collectionName, String language) async {
    await MongoDBUtils.setAppLanguage(collectionName, objectId, language);
  }

  Future<void> removeAppLanguage(String collectionName, String language) async {
    await MongoDBUtils.removeAppLanguage(collectionName, objectId, language);
  }

  Future<List<String>> getCloseFriends(String collectionName) async {
    return await MongoDBUtils.getCloseFriends(collectionName, objectId);
  }

  Future<void> setCloseFriend(String collectionName, String userID) async {
    await MongoDBUtils.setCloseFriend(collectionName, objectId, userID);
  }

  Future<void> removeCloseFriend(String collectionName, String userID) async {
    await MongoDBUtils.removeCloseFriend(collectionName, objectId, userID);
  }

  Future<List<String>> getVisitors(String collectionName) async {
    return await MongoDBUtils.getVisitors(collectionName, objectId);
  }

  Future<void> setVisitors(String collectionName, String userID) async {
    await MongoDBUtils.setVisitors(collectionName, objectId, userID);
  }

  Future<void> removeVisitors(String collectionName, String userID) async {
    await MongoDBUtils.removeVisitors(collectionName, objectId, userID);
  }

  Future<int> getGiftsAmount(String collectionName) async {
    return await MongoDBUtils.getGiftsAmount(collectionName, objectId);
  }

  Future<void> setGiftsAmount(String collectionName, int amount) async {
    await MongoDBUtils.setGiftsAmount(collectionName, objectId, amount);
  }

  // Post IDs
  Future<void> setIdsToPostList(
      String collectionName, List<dynamic> ids) async {
    await MongoDBUtils.setIdsToPostList(collectionName, objectId, ids);
  }

  Future<void> setIdToPostList(String collectionName, String id) async {
    await MongoDBUtils.setIdToPostList(collectionName, objectId, id);
  }

  Future<void> removePostId(String collectionName, String id) async {
    await MongoDBUtils.removePostId(collectionName, objectId, id);
  }

  Future<List<dynamic>> getPostIdList(String collectionName) async {
    return await MongoDBUtils.getPostIdList(collectionName, objectId);
  }

  // Black List
  Future<void> setIdsToBlackList(
      String collectionName, List<dynamic> ids) async {
    await MongoDBUtils.setIdsToBlackList(collectionName, objectId, ids);
  }

  Future<void> setIdToBlackList(String collectionName, String id) async {
    await MongoDBUtils.setIdToBlackList(collectionName, objectId, id);
  }

  Future<void> removeIdFromBlackList(String collectionName, String id) async {
    await MongoDBUtils.removeIdFromBlackList(collectionName, objectId, id);
  }

  Future<List<dynamic>> getIdFromBlackList(String collectionName) async {
    return await MongoDBUtils.getIdFromBlackList(collectionName, objectId);
  }

  // User State In App
  Future<String> getUserStateInApp(String collectionName) async {
    return await MongoDBUtils.getUserStateInApp(collectionName, objectId);
  }

  Future<void> setUserStateInApp(String collectionName, String state) async {
    await MongoDBUtils.setUserStateInApp(collectionName, objectId, state);
  }

  // Chat With Users
  Future<void> setChatWithUsersIds(String collectionName, String id) async {
    await MongoDBUtils.setChatWithUsersIds(collectionName, objectId, id);
  }

  Future<void> removeChatWithUser(String collectionName, String id) async {
    await MongoDBUtils.removeChatWithUsersIds(collectionName, objectId, id);
  }

  Future<List<dynamic>> getChatWithUsersIds(String collectionName) async {
    return await MongoDBUtils.getChatWithUsersIds(collectionName, objectId);
  }

  // Session Token
  Future<String?> getSessionToken(String collectionName) async {
    return await MongoDBUtils.getSessionToken(collectionName, objectId);
  }

  // UID
  Future<int> getUid(String collectionName) async {
    return await MongoDBUtils.getUid(collectionName, objectId);
  }

  Future<void> setUid(String collectionName, int uid) async {
    await MongoDBUtils.setUid(collectionName, objectId, uid);
  }

  Future<String?> getUserRole(String collectionName) async {
    return await MongoDBUtils.getUserRole(collectionName, objectId);
  }

  Future<void> setUserRole(String collectionName, String role) async {
    await MongoDBUtils.setUserRole(collectionName, objectId, role);
  }

  Future<String?> getUsername(String collectionName) async {
    return await MongoDBUtils.getUsername(collectionName, objectId);
  }

  Future<void> setUsername(String collectionName, String username) async {
    await MongoDBUtils.setUsername(collectionName, objectId, username);
  }

  Future<String?> getEmail(String collectionName) async {
    return await MongoDBUtils.getEmail(collectionName, objectId);
  }

  Future<void> setEmail(String collectionName, String email) async {
    await MongoDBUtils.setEmail(collectionName, objectId, email);
  }

  Future<String?> getEmailPublic(String collectionName) async {
    return await MongoDBUtils.getEmailPublic(collectionName, objectId);
  }

  Future<void> setEmailPublic(String collectionName, String emailPublic) async {
    await MongoDBUtils.setEmailPublic(collectionName, objectId, emailPublic);
  }

  Future<String?> getFullName(String collectionName) async {
    return await MongoDBUtils.getFullName(collectionName, objectId);
  }

  Future<void> setFullName(String collectionName, String fullName) async {
    await MongoDBUtils.setFullName(collectionName, objectId, fullName);
  }

  Future<String?> getFirstName(String collectionName) async {
    return await MongoDBUtils.getFirstName(collectionName, objectId);
  }

  Future<void> setFirstName(String collectionName, String firstName) async {
    await MongoDBUtils.setFirstName(collectionName, objectId, firstName);
  }

  Future<String?> getLastName(String collectionName) async {
    return await MongoDBUtils.getLastName(collectionName, objectId);
  }

  Future<void> setLastName(String collectionName, String lastName) async {
    await MongoDBUtils.setLastName(collectionName, objectId, lastName);
  }

  Future<String> getGender(String collectionName) async {
    return await MongoDBUtils.getGender(collectionName, objectId);
  }

  Future<void> setGender(String collectionName, String gender) async {
    await MongoDBUtils.setGender(collectionName, objectId, gender);
  }

  Future<String> getGenderPref(String collectionName) async {
    return await MongoDBUtils.getGenderPref(collectionName, objectId);
  }

  Future<void> setGenderPref(String collectionName, String genderPref) async {
    await MongoDBUtils.setGenderPref(collectionName, objectId, genderPref);
  }

  Future<int> getPrefDistance(String collectionName) async {
    return await MongoDBUtils.getPrefDistance(collectionName, objectId);
  }

  Future<void> setPrefDistance(String collectionName, int distance) async {
    await MongoDBUtils.setPrefDistance(collectionName, objectId, distance);
  }

  Future<String> getBio(String collectionName) async {
    return await MongoDBUtils.getBio(collectionName, objectId);
  }

  Future<void> setBio(String collectionName, String bio) async {
    await MongoDBUtils.setBio(collectionName, objectId, bio);
  }

  Future<Map<String, dynamic>?> getAvatar(String collectionName) async {
    return await MongoDBUtils.getAvatar(collectionName, objectId);
  }

  Future<void> setAvatar(String collectionName,
      {required String name, required String url}) async {
    await MongoDBUtils.setAvatar(collectionName, objectId,
        name: name, url: url);
  }

  Future<List<Map<String, String>>> getImagesList(String collectionName) async {
    return await MongoDBUtils.getImagesList(collectionName, objectId);
  }

  Future<void> setImagesList(
      String collectionName, String name, String url) async {
    await MongoDBUtils.setImagesList(collectionName, objectId, name, url);
  }

  Future<void> addImageToList(
      String collectionName, String name, String url) async {
    await MongoDBUtils.addImageToList(collectionName, objectId, name, url);
  }

  Future<void> removeImageFromList(
      String collectionName, String imageUrl) async {
    await MongoDBUtils.removeImageFromList(collectionName, objectId, imageUrl);
  }

  Future<Map<String, dynamic>?> getCover(String collectionName) async {
    return await MongoDBUtils.getCover(collectionName, objectId);
  }

  Future<void> setCover(String collectionName,
      {required String name, required String url}) async {
    await MongoDBUtils.setCover(collectionName, objectId, name: name, url: url);
  }

  Future<DateTime> getBirthday(String collectionName) async {
    return await MongoDBUtils.getBirthday(collectionName, objectId);
  }

  Future<void> setBirthday(String collectionName, DateTime birthday) async {
    await MongoDBUtils.setBirthday(collectionName, objectId, birthday);
  }

  Future<DateTime?> getLastOnline(String collectionName) async {
    return await MongoDBUtils.getLastOnline(collectionName, objectId);
  }

  Future<void> setLastOnline(String collectionName, DateTime time) async {
    await MongoDBUtils.setLastOnline(collectionName, objectId, time);
  }

  Future<bool> getEmailVerified(String collectionName) async {
    return await MongoDBUtils.getEmailVerified(collectionName, objectId);
  }

  Future<void> setEmailVerified(String collectionName, bool verified) async {
    await MongoDBUtils.setEmailVerified(collectionName, objectId, verified);
  }

  Future<bool> getActivationStatus(String collectionName) async {
    return await MongoDBUtils.getActivationStatus(collectionName, objectId);
  }

  Future<void> setActivationStatus(
      String collectionName, bool activated) async {
    await MongoDBUtils.setActivationStatus(collectionName, objectId, activated);
  }

  Future<bool> getAccountDeleted(String collectionName) async {
    return await MongoDBUtils.getAccountDeleted(collectionName, objectId);
  }

  Future<void> setAccountDeleted(String collectionName, bool deleted) async {
    await MongoDBUtils.setAccountDeleted(collectionName, objectId, deleted);
  }

  Future<String> getFacebookId(String collectionName) async {
    return await MongoDBUtils.getFacebookId(collectionName, objectId);
  }

  Future<void> setFacebookId(String collectionName, String facebookId) async {
    await MongoDBUtils.setFacebookId(collectionName, objectId, facebookId);
  }

  Future<String> getGoogleId(String collectionName) async {
    return await MongoDBUtils.getGoogleId(collectionName, objectId);
  }

  Future<void> setGoogleId(String collectionName, String googleId) async {
    await MongoDBUtils.setGoogleId(collectionName, objectId, googleId);
  }

  Future<bool> isAdmin(String collectionName) async {
    return await MongoDBUtils.isAdmin(collectionName, objectId);
  }

  Future<bool> isDeleted(String collectionName) async {
    return await MongoDBUtils.isDeleted(collectionName, objectId);
  }

  Future<bool> isSuspended(String collectionName) async {
    return await MongoDBUtils.isSuspended(collectionName, objectId);
  }

  Future<bool> isDeletedOrSuspended(String collectionName) async {
    bool deleted = await isDeleted(collectionName);
    bool suspended = await isSuspended(collectionName);
    return deleted || suspended;
  }

  Future<String?> getAccountDeletedReason(String collectionName) async {
    return await MongoDBUtils.getAccountDeletedReason(collectionName, objectId);
  }

  Future<void> setAccountDeletedReason(
      String collectionName, String reason) async {
    await MongoDBUtils.setAccountDeletedReason(
        collectionName, objectId, reason);
  }

  Future<String?> getAppleId(String collectionName) async {
    return await MongoDBUtils.getAppleId(collectionName, objectId);
  }

  Future<void> setAppleId(String collectionName, String appleId) async {
    await MongoDBUtils.setAppleId(collectionName, objectId, appleId);
  }

  Future<String?> getInstagramId(String collectionName) async {
    return await MongoDBUtils.getInstagramId(collectionName, objectId);
  }

  Future<void> setInstagramId(String collectionName, String instagramId) async {
    await MongoDBUtils.setInstagramId(collectionName, objectId, instagramId);
  }

  Future<bool> getHasPassword(String collectionName) async {
    return await MongoDBUtils.getHasPassword(collectionName, objectId);
  }

  Future<void> setHasPassword(String collectionName, bool hasPassword) async {
    await MongoDBUtils.setHasPassword(collectionName, objectId, hasPassword);
  }

  Future<bool> getHasGeoPoint(String collectionName) async {
    return await MongoDBUtils.getHasGeoPoint(collectionName, objectId);
  }

  Future<void> setHasGeoPoint(String collectionName, bool hasGeoPoint) async {
    await MongoDBUtils.setHasGeoPoint(collectionName, objectId, hasGeoPoint);
  }

  Future<bool> getLocationTypeNearBy(String collectionName) async {
    return await MongoDBUtils.getLocationTypeNearBy(collectionName, objectId);
  }

  Future<void> setLocationTypeNearBy(
      String collectionName, bool prefLocationType) async {
    await MongoDBUtils.setLocationTypeNearBy(
        collectionName, objectId, prefLocationType);
  }

  Future<String> getLocation(String collectionName) async {
    return await MongoDBUtils.getLocation(collectionName, objectId);
  }

  Future<String> getLocationOrEmpty(String collectionName) async {
    return await MongoDBUtils.getLocationOrEmpty(collectionName, objectId);
  }

  Future<String> getLocationOnly(String collectionName) async {
    return await MongoDBUtils.getLocationOnly(collectionName, objectId);
  }

  Future<void> setLocation(String collectionName, String location) async {
    await MongoDBUtils.setLocation(collectionName, objectId, location);
  }

  Future<String> getCity(String collectionName) async {
    return await MongoDBUtils.getCity(collectionName, objectId);
  }

  Future<void> setCity(String collectionName, String city) async {
    await MongoDBUtils.setCity(collectionName, objectId, city);
  }

  Future<int> getPopularity(String collectionName) async {
    return await MongoDBUtils.getPopularity(collectionName, objectId);
  }

  Future<void> setPopularity(String collectionName, int popularity) async {
    await MongoDBUtils.setPopularity(collectionName, objectId, popularity);
  }

  Future<int> getPrefMinAge(String collectionName) async {
    return await MongoDBUtils.getPrefMinAge(collectionName, objectId);
  }

  Future<void> setPrefMinAge(String collectionName, int minAge) async {
    await MongoDBUtils.setPrefMinAge(collectionName, objectId, minAge);
  }

  Future<int> getPrefMaxAge(String collectionName) async {
    return await MongoDBUtils.getPrefMaxAge(collectionName, objectId);
  }

  Future<void> setPrefMaxAge(String collectionName, int maxAge) async {
    await MongoDBUtils.setPrefMaxAge(collectionName, objectId, maxAge);
  }

  Future<int> getCredits(String collectionName) async {
    return await MongoDBUtils.getCredits(collectionName, objectId);
  }

  Future<int> getCreditsSent(String collectionName) async {
    return await MongoDBUtils.getCreditsSent(collectionName, objectId);
  }

  Future<int> getPlatformSpeakerNumber(String collectionName) async {
    return await MongoDBUtils.getPlatformSpeakerNumber(
        collectionName, objectId);
  }

  Future<void> addPlatformSpeakerNumber(
      String collectionName, int number) async {
    await MongoDBUtils.addPlatformSpeakerNumber(
        collectionName, objectId, number);
  }

  Future<void> removePlatformSpeakerNumber(
      String collectionName, int number) async {
    await MongoDBUtils.removePlatformSpeakerNumber(
        collectionName, objectId, number);
  }

  Future<void> addCredit(String collectionName, int credits) async {
    await MongoDBUtils.addCredit(collectionName, objectId, credits);
  }

  // UserModel Extension for Location, Company & Financial Fields
  Future<void> removeCredit(String collectionName, int credits) async {
    await MongoDBUtils.removeCredit(collectionName, objectId, credits);
  }

  Future<String> getCountry(String collectionName) async {
    return await MongoDBUtils.getCountry(collectionName, objectId);
  }

  Future<void> setCountry(String collectionName, String country) async {
    await MongoDBUtils.setCountry(collectionName, objectId, country);
  }

  Future<String> getCountryCode(String collectionName) async {
    return await MongoDBUtils.getCountryCode(collectionName, objectId);
  }

  Future<void> setCountryCode(String collectionName, String countryCode) async {
    await MongoDBUtils.setCountryCode(collectionName, objectId, countryCode);
  }

  Future<void> setCurrencyCode(
      String collectionName, String currencyCode) async {
    await MongoDBUtils.setCurrencyCode(collectionName, objectId, currencyCode);
  }

  Future<String> getCurrencyCode(String collectionName) async {
    return await MongoDBUtils.getCurrencyCode(collectionName, objectId);
  }

  Future<void> setCurrencySymbol(
      String collectionName, String currencySymbol) async {
    await MongoDBUtils.setCurrencySymbol(
        collectionName, objectId, currencySymbol);
  }

  Future<String> getCurrencySymbol(String collectionName) async {
    return await MongoDBUtils.getCurrencySymbol(collectionName, objectId);
  }

  Future<String?> getCountryDialCode(String collectionName) async {
    return await MongoDBUtils.getCountryDialCode(collectionName, objectId);
  }

  Future<void> setCountryDialCode(
      String collectionName, String dialCode) async {
    await MongoDBUtils.setCountryDialCode(collectionName, objectId, dialCode);
  }

  Future<String> getPhoneNumber(String collectionName) async {
    return await MongoDBUtils.getPhoneNumber(collectionName, objectId);
  }

  Future<void> setPhoneNumber(String collectionName, String phoneNumber) async {
    await MongoDBUtils.setPhoneNumber(collectionName, objectId, phoneNumber);
  }

  Future<void> setPhoneNumberFull(
      String collectionName, String phoneNumberFull) async {
    await MongoDBUtils.setPhoneNumberFull(
        collectionName, objectId, phoneNumberFull);
  }

  Future<String> getPhoneNumberFull(String collectionName) async {
    return await MongoDBUtils.getPhoneNumberFull(collectionName, objectId);
  }

  Future<String> getCompanyName(String collectionName) async {
    return await MongoDBUtils.getCompanyName(collectionName, objectId);
  }

  Future<void> setCompanyName(String collectionName, String companyName) async {
    await MongoDBUtils.setCompanyName(collectionName, objectId, companyName);
  }

  Future<String> getJobTitle(String collectionName) async {
    return await MongoDBUtils.getJobTitle(collectionName, objectId);
  }

  Future<void> setJobTitle(String collectionName, String jobTitle) async {
    await MongoDBUtils.setJobTitle(collectionName, objectId, jobTitle);
  }

  Future<String> getSchool(String collectionName) async {
    return await MongoDBUtils.getSchool(collectionName, objectId);
  }

  Future<void> setSchool(String collectionName, String school) async {
    await MongoDBUtils.setSchool(collectionName, objectId, school);
  }

  // UserModel Extension for About, Mood, VIP & Privacy Settings
  Future<String> getAboutYou(String collectionName) async {
    return await MongoDBUtils.getAboutYou(collectionName, objectId);
  }

  Future<void> setAboutYou(String collectionName, String about) async {
    await MongoDBUtils.setAboutYou(collectionName, objectId, about);
  }

  Future<String> getMoodTitle(String collectionName) async {
    return await MongoDBUtils.getMoodTitle(collectionName, objectId);
  }

  Future<void> setMoodTitle(String collectionName, String moodTitle) async {
    await MongoDBUtils.setMoodTitle(collectionName, objectId, moodTitle);
  }

  Future<bool> getPhotoVerified(String collectionName) async {
    return await MongoDBUtils.getPhotoVerified(collectionName, objectId);
  }

  Future<void> setPhotoVerified(
      String collectionName, bool photoVerified) async {
    await MongoDBUtils.setPhotoVerified(
        collectionName, objectId, photoVerified);
  }

  Future<bool> isNormalVip(String collectionName) async {
    return await MongoDBUtils.isNormalVip(collectionName, objectId);
  }

  Future<DateTime?> getNormalVip(String collectionName) async {
    return await MongoDBUtils.getNormalVip(collectionName, objectId);
  }

  Future<void> setNormalVip(String collectionName, DateTime normalVip) async {
    await MongoDBUtils.setNormalVip(collectionName, objectId, normalVip);
  }

  Future<DateTime?> getDailyGift(String collectionName) async {
    return await MongoDBUtils.getDailyGift(collectionName, objectId);
  }

  Future<void> setDailyGift(String collectionName, DateTime dailyGift) async {
    await MongoDBUtils.setDailyGift(collectionName, objectId, dailyGift);
  }

  Future<bool> isDailyGift(String collectionName) async {
    return await MongoDBUtils.isDailyGift(collectionName, objectId);
  }

  Future<DateTime?> getVipAdsDisabled(String collectionName) async {
    return await MongoDBUtils.getVipAdsDisabled(collectionName, objectId);
  }

  Future<void> setVipAdsDisabled(
      String collectionName, DateTime adsDisabled) async {
    await MongoDBUtils.setVipAdsDisabled(collectionName, objectId, adsDisabled);
  }

  Future<DateTime?> getVip3xPopular(String collectionName) async {
    return await MongoDBUtils.getVip3xPopular(collectionName, objectId);
  }

  Future<void> setVip3xPopular(String collectionName, DateTime xPopular) async {
    await MongoDBUtils.setVip3xPopular(collectionName, objectId, xPopular);
  }

  Future<DateTime?> getVipShowOnline(String collectionName) async {
    return await MongoDBUtils.getVipShowOnline(collectionName, objectId);
  }

  Future<void> setVipShowOnline(
      String collectionName, DateTime showOnline) async {
    await MongoDBUtils.setVipShowOnline(collectionName, objectId, showOnline);
  }

  Future<DateTime?> getVipExtraShows(String collectionName) async {
    return await MongoDBUtils.getVipExtraShows(collectionName, objectId);
  }

  Future<void> setVipExtraShows(
      String collectionName, DateTime extraShows) async {
    await MongoDBUtils.setVipExtraShows(collectionName, objectId, extraShows);
  }

  Future<DateTime?> getVipMoreVisits(String collectionName) async {
    return await MongoDBUtils.getVipMoreVisits(collectionName, objectId);
  }

  Future<void> setVipMoreVisits(
      String collectionName, DateTime moreVisits) async {
    await MongoDBUtils.setVipMoreVisits(collectionName, objectId, moreVisits);
  }

  Future<DateTime?> getVipMoveToTop(String collectionName) async {
    return await MongoDBUtils.getVipMoveToTop(collectionName, objectId);
  }

  Future<void> setVipMoveToTop(
      String collectionName, DateTime moveToTop) async {
    await MongoDBUtils.setVipMoveToTop(collectionName, objectId, moveToTop);
  }

  Future<bool> getVipInvisibleMode(String collectionName) async {
    return await MongoDBUtils.getVipInvisibleMode(collectionName, objectId);
  }

  Future<void> setVipInvisibleMode(
      String collectionName, bool invisibleMode) async {
    await MongoDBUtils.setVipInvisibleMode(
        collectionName, objectId, invisibleMode);
  }

  Future<bool> getVipIsInvisible(String collectionName) async {
    return await MongoDBUtils.getVipIsInvisible(collectionName, objectId);
  }

  Future<void> setVipIsInvisible(
      String collectionName, bool isInvisible) async {
    await MongoDBUtils.setVipIsInvisible(collectionName, objectId, isInvisible);
  }

  Future<void> setNameChanged(String collectionName, bool nameChanged) async {
    await MongoDBUtils.setNameChanged(collectionName, objectId, nameChanged);
  }

  Future<bool> getAccountHidden(String collectionName) async {
    return await MongoDBUtils.getAccountHidden(collectionName, objectId);
  }

  Future<void> setAccountHidden(String collectionName, bool hidden) async {
    await MongoDBUtils.setAccountHidden(collectionName, objectId, hidden);
  }

  // Blocked Users
  Future<List<dynamic>> getBlockedUsers(String collectionName) async {
    return await MongoDBUtils.getBlockedUsers(collectionName, objectId);
  }

  Future<void> setBlockedUsers(
      String collectionName, List<dynamic> users) async {
    await MongoDBUtils.setBlockedUsers(collectionName, objectId, users);
  }

  Future<List<dynamic>> getBlockedUserIDs(String collectionName) async {
    return await MongoDBUtils.getBlockedUserIDs(collectionName, objectId);
  }

  Future<void> setBlockedUserIDs(
      String collectionName, List<dynamic> ids) async {
    await MongoDBUtils.setBlockedUserIDs(collectionName, objectId, ids);
  }

  Future<void> addBlockedUserId(String collectionName, String id) async {
    await MongoDBUtils.addBlockedUserId(collectionName, objectId, id);
  }

  Future<void> removeBlockedUserId(String collectionName, String id) async {
    await MongoDBUtils.removeBlockedUserId(collectionName, objectId, id);
  }

  Future<void> addBlockedUser(
      String collectionName, Map<String, dynamic> user) async {
    await MongoDBUtils.addBlockedUser(collectionName, objectId, user);
  }

  Future<void> removeBlockedUser(
      String collectionName, Map<String, dynamic> user) async {
    await MongoDBUtils.removeBlockedUser(collectionName, objectId, user);
  }

  // Privacy & Location
  Future<bool> getPrivacyShowDistance(String collectionName) async {
    return await MongoDBUtils.getPrivacyShowDistance(collectionName, objectId);
  }

  Future<void> setPrivacyShowDistance(String collectionName, bool value) async {
    await MongoDBUtils.setPrivacyShowDistance(collectionName, objectId, value);
  }

  Future<bool> getPrivacyShowStatusOnline(String collectionName) async {
    return await MongoDBUtils.getPrivacyShowStatusOnline(
        collectionName, objectId);
  }

  Future<void> setPrivacyShowStatusOnline(
      String collectionName, bool value) async {
    await MongoDBUtils.setPrivacyShowStatusOnline(
        collectionName, objectId, value);
  }

  Future<String> getWhatIWant(String collectionName) async {
    return await MongoDBUtils.getWhatIWant(collectionName, objectId);
  }

  Future<void> setWhatIWant(String collectionName, String value) async {
    await MongoDBUtils.setWhatIWant(collectionName, objectId, value);
  }

  Future<String> getLanguage(String collectionName) async {
    return await MongoDBUtils.getLanguage(collectionName, objectId);
  }

  Future<void> setLanguage(String collectionName, String language) async {
    await MongoDBUtils.setLanguage(collectionName, objectId, language);
  }

  Future<String> getDrinking(String collectionName) async {
    return await MongoDBUtils.getDrinking(collectionName, objectId);
  }

  Future<void> setDrinking(String collectionName, String drinking) async {
    await MongoDBUtils.setDrinking(collectionName, objectId, drinking);
  }

  Future<String> getSmoking(String collectionName) async {
    return await MongoDBUtils.getSmoking(collectionName, objectId);
  }

  Future<void> setSmoking(String collectionName, String smoking) async {
    await MongoDBUtils.setSmoking(collectionName, objectId, smoking);
  }

  Future<String> getKids(String collectionName) async {
    return await MongoDBUtils.getKids(collectionName, objectId);
  }

  Future<void> setKids(String collectionName, String kids) async {
    await MongoDBUtils.setKids(collectionName, objectId, kids);
  }

  Future<String> getLiving(String collectionName) async {
    return await MongoDBUtils.getLiving(collectionName, objectId);
  }

  Future<void> setLiving(String collectionName, String living) async {
    await MongoDBUtils.setLiving(collectionName, objectId, living);
  }

  // UserModel Extension for Physical and Lifestyle Preferences

  Future<String> getBodyType(String collectionName) async {
    return await MongoDBUtils.getBodyType(collectionName, objectId);
  }

  Future<void> setBodyType(String collectionName, String bodyType) async {
    await MongoDBUtils.setBodyType(collectionName, objectId, bodyType);
  }

  Future<int> getHeight(String collectionName) async {
    return await MongoDBUtils.getHeight(collectionName, objectId);
  }

  Future<void> setHeight(String collectionName, int height) async {
    await MongoDBUtils.setHeight(collectionName, objectId, height);
  }

  Future<String> getSexuality(String collectionName) async {
    return await MongoDBUtils.getSexuality(collectionName, objectId);
  }

  Future<void> setSexuality(String collectionName, String sexuality) async {
    await MongoDBUtils.setSexuality(collectionName, objectId, sexuality);
  }

  Future<String> getRelationship(String collectionName) async {
    return await MongoDBUtils.getRelationship(collectionName, objectId);
  }

  Future<void> setRelationship(
      String collectionName, String relationship) async {
    await MongoDBUtils.setRelationship(collectionName, objectId, relationship);
  }

  Future<String?> getSecondaryPassword(String collectionName) async {
    return await MongoDBUtils.getSecondaryPassword(collectionName, objectId);
  }

  Future<void> setSecondaryPassword(
      String collectionName, String secondaryPassword) async {
    await MongoDBUtils.setSecondaryPassword(
        collectionName, objectId, secondaryPassword);
  }

  Future<List<dynamic>> getSexualOrientations(String collectionName) async {
    return await MongoDBUtils.getSexualOrientations(collectionName, objectId);
  }

  Future<void> setSexualOrientations(
      String collectionName, List<String> orientations) async {
    await MongoDBUtils.setSexualOrientations(
        collectionName, objectId, orientations);
  }

  Future<List<dynamic>> getPassions(String collectionName) async {
    return await MongoDBUtils.getPassions(collectionName, objectId);
  }

  Future<void> setPassions(String collectionName, List<String> passions) async {
    await MongoDBUtils.setPassions(collectionName, objectId, passions);
  }

  Future<bool> getShowSexualOrientation(String collectionName) async {
    return await MongoDBUtils.getShowSexualOrientation(
        collectionName, objectId);
  }

  Future<void> setShowSexualOrientation(
      String collectionName, bool show) async {
    await MongoDBUtils.setShowSexualOrientation(collectionName, objectId, show);
  }

  Future<bool> getShowGenderInProfile(String collectionName) async {
    return await MongoDBUtils.getShowGenderInProfile(collectionName, objectId);
  }

  Future<void> setShowGenderInProfile(String collectionName, bool show) async {
    await MongoDBUtils.setShowGenderInProfile(collectionName, objectId, show);
  }

  Future<bool> getDistanceInMiles(String collectionName) async {
    return await MongoDBUtils.getDistanceInMiles(collectionName, objectId);
  }

  Future<void> setDistanceInMiles(String collectionName, bool value) async {
    await MongoDBUtils.setDistanceInMiles(collectionName, objectId, value);
  }

  Future<bool> getHideMyLocation(String collectionName) async {
    return await MongoDBUtils.getHideMyLocation(collectionName, objectId);
  }

  Future<void> setHideMyLocation(String collectionName, bool hide) async {
    await MongoDBUtils.setHideMyLocation(collectionName, objectId, hide);
  }

  Future<void> setGeoPoint(
      String collectionName, double longitude, double latitude) async {
    await MongoDBUtils.setGeoPoint(
        collectionName, objectId, longitude, latitude);
  }

  Future<void> getGeoPoint(
      String collectionName, double longitude, double latitude) async {
    await MongoDBUtils.getGeoPoint(collectionName, objectId);
  }

  Future<int> getAge(String collectionName) async {
    return await MongoDBUtils.getAge(collectionName, objectId);
  }

  Future<void> setAge(String collectionName, int age) async {
    await MongoDBUtils.setAge(collectionName, objectId, age);
  }

  Future<int> getDiamonds(String collectionName) async {
    return await MongoDBUtils.getDiamonds(collectionName, objectId);
  }

  Future<void> setDiamonds(String collectionName, int diamonds) async {
    await MongoDBUtils.setDiamonds(collectionName, objectId, diamonds);
  }

  Future<void> removeDiamonds(String collectionName, int diamonds) async {
    await MongoDBUtils.removeDiamonds(collectionName, objectId, diamonds);
  }

  Future<int> getDiamondsTotal(String collectionName) async {
    return await MongoDBUtils.getDiamondsTotal(collectionName, objectId);
  }

  Future<void> setDiamondsTotal(
      String collectionName, int diamondsTotal) async {
    await MongoDBUtils.setDiamondsTotal(
        collectionName, objectId, diamondsTotal);
  }

  Future<int> getPayouts(String collectionName) async {
    return await MongoDBUtils.getPayouts(collectionName, objectId);
  }

  Future<void> addPayouts(String collectionName, int incrementPayout) async {
    await MongoDBUtils.addPayouts(collectionName, objectId, incrementPayout);
  }

  Future<List<dynamic>> getFollowing(String collectionName) async {
    return await MongoDBUtils.getFollowing(collectionName, objectId);
  }

  Future<void> setFollowing(String collectionName, String authorId) async {
    await MongoDBUtils.setFollowing(collectionName, objectId, authorId);
  }

  Future<void> removeFollowing(String collectionName, String authorId) async {
    await MongoDBUtils.removeFollowing(collectionName, objectId, authorId);
  }

  Future<List<dynamic>> getFollowers(String collectionName) async {
    return await MongoDBUtils.getFollowers(collectionName, objectId);
  }

  Future<void> setFollowers(String collectionName, String authorId) async {
    await MongoDBUtils.setFollowers(collectionName, objectId, authorId);
  }

  Future<void> removeFollowers(String collectionName, String authorId) async {
    await MongoDBUtils.removeFollowers(collectionName, objectId, authorId);
  }

  Future<bool> getReceiveChatRequest(String collectionName) async {
    return await MongoDBUtils.getReceiveChatRequest(collectionName, objectId);
  }

  Future<void> setReceiveChatRequest(String collectionName, bool value) async {
    await MongoDBUtils.setReceiveChatRequest(collectionName, objectId, value);
  }

  Future<bool> getShowUpInSearch(String collectionName) async {
    return await MongoDBUtils.getShowUpInSearch(collectionName, objectId);
  }

  Future<void> setShowUpInSearch(String collectionName, bool value) async {
    await MongoDBUtils.setShowUpInSearch(collectionName, objectId, value);
  }

  Future<bool> getShowVipLevel(String collectionName) async {
    return await MongoDBUtils.getShowVipLevel(collectionName, objectId);
  }

  Future<void> setShowVipLevel(String collectionName, bool value) async {
    await MongoDBUtils.setShowVipLevel(collectionName, objectId, value);
  }

  Future<bool> getShowLocation(String collectionName) async {
    return await MongoDBUtils.getShowLocation(collectionName, objectId);
  }

  Future<void> setShowLocation(String collectionName, bool value) async {
    await MongoDBUtils.setShowLocation(collectionName, objectId, value);
  }

  Future<bool> getShowLastTimeSeen(String collectionName) async {
    return await MongoDBUtils.getShowLastTimeSeen(collectionName, objectId);
  }

  Future<void> setShowLastTimeSeen(String collectionName, bool value) async {
    await MongoDBUtils.setShowLastTimeSeen(collectionName, objectId, value);
  }

  Future<bool> getInvisibleMode(String collectionName) async {
    return await MongoDBUtils.getInvisibleMode(collectionName, objectId);
  }

  Future<void> setInvisibleMode(String collectionName, bool value) async {
    await MongoDBUtils.setInvisibleMode(collectionName, objectId, value);
  }

  Future<String> getShowMyPostsTo(String collectionName) async {
    return await MongoDBUtils.getShowMyPostsTo(collectionName, objectId);
  }

  Future<void> setShowMyPostsTo(String collectionName, String value) async {
    await MongoDBUtils.setShowMyPostsTo(collectionName, objectId, value);
  }

  Future<bool> getSendReadReceipts(String collectionName) async {
    return await MongoDBUtils.getSendReadReceipts(collectionName, objectId);
  }

  Future<void> setSendReadReceipts(String collectionName, bool value) async {
    await MongoDBUtils.setSendReadReceipts(collectionName, objectId, value);
  }

  Future<bool> getEnableOneClickGifting(String collectionName) async {
    return await MongoDBUtils.getEnableOneClickGifting(
        collectionName, objectId);
  }

  Future<void> setEnableOneClickGifting(
      String collectionName, bool value) async {
    await MongoDBUtils.setEnableOneClickGifting(
        collectionName, objectId, value);
  }

  Future<bool> getDenyBeInvitedToLiveParty(String collectionName) async {
    return await MongoDBUtils.getDenyBeInvitedToLiveParty(
        collectionName, objectId);
  }

  Future<void> setDenyBeInvitedToLiveParty(
      String collectionName, bool value) async {
    await MongoDBUtils.setDenyBeInvitedToLiveParty(
        collectionName, objectId, value);
  }

  Future<bool> getDenyPictureInPictureMode(String collectionName) async {
    return await MongoDBUtils.getDenyPictureInPictureMode(
        collectionName, objectId);
  }

  Future<void> setDenyPictureInPictureMode(
      String collectionName, bool value) async {
    await MongoDBUtils.setDenyPictureInPictureMode(
        collectionName, objectId, value);
  }

  Future<bool> getAllowViewersToPremiumStream(String collectionName) async {
    return await MongoDBUtils.getAllowViewersToPremiumStream(
        collectionName, objectId);
  }

  Future<void> setAllowViewersToPremiumStream(
      String collectionName, bool value) async {
    await MongoDBUtils.setAllowViewersToPremiumStream(
        collectionName, objectId, value);
  }

  Future<bool> getLiveNotification(String collectionName) async {
    return await MongoDBUtils.getLiveNotification(collectionName, objectId);
  }

  Future<void> setLiveNotification(String collectionName, bool value) async {
    await MongoDBUtils.setLiveNotification(collectionName, objectId, value);
  }

  Future<bool> getMuteIncomingCalls(String collectionName) async {
    return await MongoDBUtils.getMuteIncomingCalls(collectionName, objectId);
  }

  Future<void> setMuteIncomingCalls(String collectionName, bool value) async {
    await MongoDBUtils.setMuteIncomingCalls(collectionName, objectId, value);
  }

  Future<bool> getNotificationSounds(String collectionName) async {
    return await MongoDBUtils.getNotificationSounds(collectionName, objectId);
  }

  Future<void> setNotificationSounds(String collectionName, bool value) async {
    await MongoDBUtils.setNotificationSounds(collectionName, objectId, value);
  }

  Future<bool> getInAppSound(String collectionName) async {
    return await MongoDBUtils.getInAppSound(collectionName, objectId);
  }

  Future<void> setInAppSound(String collectionName, bool value) async {
    await MongoDBUtils.setInAppSound(collectionName, objectId, value);
  }

  Future<bool> getInAppVibration(String collectionName) async {
    return await MongoDBUtils.getInAppVibration(collectionName, objectId);
  }

  Future<void> setInAppVibration(String collectionName, bool value) async {
    await MongoDBUtils.setInAppVibration(collectionName, objectId, value);
  }

  Future<void> setGameNotification(
      String collectionName, bool gameNotification) async {
    await MongoDBUtils.setGameNotification(
        collectionName, objectId, gameNotification);
  }

  Future<bool> getGameNotification(String collectionName) async {
    return await MongoDBUtils.getGameNotification(collectionName, objectId);
  }

  Future<List<dynamic>> getReportedPostIDs(String collectionName) async {
    return await MongoDBUtils.getReportedPostIDs(collectionName, objectId);
  }

  Future<void> addReportedPostID(String collectionName, dynamic postID) async {
    await MongoDBUtils.addReportedPostID(collectionName, objectId, postID);
  }

  Future<void> addMultipleReportedPostIDs(
      String collectionName, List<dynamic> postIDs) async {
    await MongoDBUtils.addMultipleReportedPostIDs(
        collectionName, objectId, postIDs);
  }

  Future<String?> getReportedPostReason(String collectionName) async {
    return await MongoDBUtils.getReportedPostReason(collectionName, objectId);
  }

  Future<void> setReportedPostReason(
      String collectionName, String reason) async {
    await MongoDBUtils.setReportedPostReason(collectionName, objectId, reason);
  }

  Future<String?> getPayoneerEmail(String collectionName) async {
    return await MongoDBUtils.getPayoneerEmail(collectionName, objectId);
  }

  Future<void> setPayoneerEmail(String collectionName, String payEmail) async {
    await MongoDBUtils.setPayoneerEmail(collectionName, objectId, payEmail);
  }

  Future<String?> getPayPalEmail(String collectionName) async {
    return await MongoDBUtils.getPayPalEmail(collectionName, objectId);
  }

  Future<void> setPayPalEmail(String collectionName, String payPalEmail) async {
    await MongoDBUtils.setPayPalEmail(collectionName, objectId, payPalEmail);
  }

  Future<String?> getIban(String collectionName) async {
    return await MongoDBUtils.getIban(collectionName, objectId);
  }

  Future<void> setIban(String collectionName, String iban) async {
    await MongoDBUtils.setIban(collectionName, objectId, iban);
  }

  Future<String?> getAccountName(String collectionName) async {
    return await MongoDBUtils.getAccountName(collectionName, objectId);
  }

  Future<void> setAccountName(String collectionName, String name) async {
    await MongoDBUtils.setAccountName(collectionName, objectId, name);
  }

  Future<String?> getBankName(String collectionName) async {
    return await MongoDBUtils.getBankName(collectionName, objectId);
  }

  Future<void> setBankName(String collectionName, String bank) async {
    await MongoDBUtils.setBankName(collectionName, objectId, bank);
  }

  Future<dynamic> getInstallation(String collectionName) async {
    return await MongoDBUtils.getInstallation(collectionName, objectId);
  }

  Future<void> setInstallation(
      String collectionName, dynamic installation) async {
    await MongoDBUtils.setInstallation(collectionName, objectId, installation);
  }

  Future<List<dynamic>> getInvitedUsers(String collectionName) async {
    return await MongoDBUtils.getInvitedUsers(collectionName, objectId);
  }

  Future<bool?> getInvitedByAnswer(String collectionName) async {
    return await MongoDBUtils.getInvitedByAnswer(collectionName, objectId);
  }

  Future<void> setInvitedByAnswer(
      String collectionName, bool invitedAnswer) async {
    await MongoDBUtils.setInvitedByAnswer(
        collectionName, objectId, invitedAnswer);
  }

  Future<String?> getInvitedByUser(String collectionName) async {
    return await MongoDBUtils.getInvitedByUser(collectionName, objectId);
  }

  Future<void> setInvitedByUser(String collectionName, String invitedBy) async {
    await MongoDBUtils.setInvitedByUser(collectionName, objectId, invitedBy);
  }

  Future<String?> getPremiumType(String collectionName) async {
    return await MongoDBUtils.getPremiumType(collectionName, objectId);
  }

  Future<void> setPremiumType(String collectionName, String premiumType) async {
    await MongoDBUtils.setPremiumType(collectionName, objectId, premiumType);
  }

  Future<int> getDiamondsAgency(String collectionName) async {
    return await MongoDBUtils.getDiamondsAgency(collectionName, objectId);
  }

  Future<void> addDiamondsAgency(String collectionName, int diamonds) async {
    await MongoDBUtils.addDiamondsAgency(collectionName, objectId, diamonds);
  }

  Future<void> removeDiamondsAgency(String collectionName, int diamonds) async {
    await MongoDBUtils.removeDiamondsAgency(collectionName, objectId, diamonds);
  }

  Future<int> getDiamondsAgencyTotal(String collectionName) async {
    return await MongoDBUtils.getDiamondsAgencyTotal(collectionName, objectId);
  }

  Future<void> addDiamondsAgencyTotal(
      String collectionName, int diamonds) async {
    await MongoDBUtils.addDiamondsAgencyTotal(
        collectionName, objectId, diamonds);
  }

  Future<void> removeDiamondsAgencyTotal(
      String collectionName, int diamonds) async {
    await MongoDBUtils.removeDiamondsAgencyTotal(
        collectionName, objectId, diamonds);
  }
}
