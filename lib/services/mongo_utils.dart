import 'package:mongo_connect/services/mongo_error_handler.dart';
import 'package:mongo_connect/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBUtils {
  /// Returns a DbCollection using the provided collection name.
  static DbCollection getCollection(String collectionName) {
    return MongoDBService().getCollection(collectionName.toLowerCase());
  }

  /// A helper method to save the user document (if needed).
  static Future<void> _saveUser({
    required String collectionName,
    required String userId,
  }) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null) {
          await collection.replaceOne(
            where.eq('objectId', userId),
            user,
            upsert: false,
          );
        }
      },
      errorMessage: 'Error saving user',
    );
  }

  // reported reply IDs for the specified user.
  static Future<List<String>> getReportedReplyID(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['reported_replies'] != null
            ? List<String>.from(user!['reported_replies'])
            : [];
      },
      errorMessage: 'Error fetching reported reply IDs',
      fallbackValue: [],
    );
  }

  static Future<void> setReportedReplyID(
      String collectionName, String userId, String replyID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.addToSet('reported_replies', replyID));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding reported reply ID',
    );
  }

  static Future<void> removeReportedReplyID(
      String collectionName, String userId, String replyID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.pull('reported_replies', replyID));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing reported reply ID',
    );
  }

  // reported commentfor the specified user.
  static Future<List<String>> getReportedCommentID(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['reported_comments'] != null
            ? List<String>.from(user!['reported_comments'])
            : [];
      },
      errorMessage: 'Error fetching reported comment IDs',
      fallbackValue: [],
    );
  }

  static Future<void> setReportedCommentID(
      String collectionName, String userId, String commentID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.addToSet('reported_comments', commentID));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding reported comment ID',
    );
  }

  static Future<void> removeReportedCommentID(
      String collectionName, String userId, String commentID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.pull('reported_comments', commentID));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing reported comment ID',
    );
  }

  // Gets the MVP Member DateTime for the specified user.
  static Future<DateTime?> getMVPMember(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['mvp_member'] != null) {
          return DateTime.tryParse(user['mvp_member'].toString());
        }
        return null;
      },
      errorMessage: 'Error fetching MVP Member',
      fallbackValue: null,
    );
  }

  // Sets the MVP Member DateTime for the specified user.
  static Future<void> setMVPMember(
      String collectionName, String userId, DateTime mvpMember) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.set('mvp_member', mvpMember.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting MVP Member',
    );
  }

  // Gets the canUseAvatarFrame flag for the specified user.
  static Future<bool> getCanUseAvatarFrame(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['can_use_using_avatar_frame'] != null
            ? user['can_use_using_avatar_frame'] as bool
            : false;
      },
      errorMessage: 'Error fetching canUseAvatarFrame',
      fallbackValue: false,
    );
  }

  /// Sets the canUseAvatarFrame flag for the specified user.
  static Future<void> setCanUseAvatarFrame(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set('can_use_using_avatar_frame', value),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting canUseAvatarFrame',
    );
  }

  /// Gets the canUsePartyTheme flag for the specified user.
  static Future<bool> getCanUsePartyTheme(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['can_use_using_party_theme'] != null
            ? user['can_use_using_party_theme'] as bool
            : false;
      },
      errorMessage: 'Error fetching canUsePartyTheme',
      fallbackValue: false,
    );
  }

  /// Sets the canUsePartyTheme flag for the specified user.
  static Future<void> setCanUsePartyTheme(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set('can_use_using_party_theme', value),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting canUsePartyTheme',
    );
  }

  /// Gets the canUseEntranceEffect flag for the specified user.
  static Future<bool> getCanUseEntranceEffect(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['can_use_entrance_effect'] != null
            ? user['can_use_entrance_effect'] as bool
            : false;
      },
      errorMessage: 'Error fetching canUseEntranceEffect',
      fallbackValue: false,
    );
  }

  /// Sets the canUseEntranceEffect flag for the specified user.
  static Future<void> setCanUseEntranceEffect(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set('can_use_entrance_effect', value),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting canUseEntranceEffect',
    );
  }

  /// Gets the My Agent ID for the specified user.
  static Future<String?> getMyAgentId(
    String collectionName,
    String userId,
  ) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['my_agent_id'] as String?;
      },
      errorMessage: 'Error fetching my agent id',
      fallbackValue: null,
    );
  }

  /// Sets the My Agent ID for the specified user.
  static Future<void> setMyAgentId(
      String collectionName, String userId, String agentId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
            where.eq('objectId', userId), modify.set('my_agent_id', agentId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting my agent id',
    );
  }

  /// Gets the Agency Role for the specified user.
  static Future<String?> getAgencyRole(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['agency_role'] as String?;
      },
      errorMessage: 'Error fetching agency role',
      fallbackValue: null,
    );
  }

  /// Sets the Agency Role for the specified user.
  static Future<void> setAgencyRole(
      String collectionName, String userId, String agencyRole) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(where.eq('objectId', userId),
            modify.set('agency_role', agencyRole));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting agency role',
    );
  }

  static Future<Map<String, String>?> getLiveCover(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, String>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['live_cover'] as Map<String, String>?;
      },
      errorMessage: 'Error fetching live cover',
      fallbackValue: null,
    );
  }

  static Future<void> setLiveCover(String collectionName, String userId,
      {required String name, required String url}) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.set('live_cover', {'name': name, 'url': url}),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting live cover',
    );
  }

  static Future<Map<String, String>?> getEntranceEffect(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, String>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_entrance_effect'] as Map<String, String>?;
      },
      errorMessage: 'Error fetching entrance effect',
      fallbackValue: null,
    );
  }

  static Future<void> setEntranceEffect(
    String collectionName,
    String userId,
    Map<String, String> entranceEffect,
  ) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_entrance_effect', entranceEffect));

        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting entrance effect',
    );
  }

  static Future<String?> getEntranceEffectId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_entrance_effect_id'] as String?;
      },
      errorMessage: 'Error fetching entrance effect ID',
      fallbackValue: null,
    );
  }

  static Future<void> setEntranceEffectId(
      String collectionName, String userId, String entranceEffectId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_entrance_effect_id', entranceEffectId));
      },
      errorMessage: 'Error setting entrance effect ID',
    );
  }

  // Party Theme Methods
  static Future<Map<String, String>?> getPartyTheme(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, String>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_party_theme'] as Map<String, String>?;
      },
      errorMessage: 'Error fetching party theme',
      fallbackValue: null,
    );
  }

  static Future<void> setPartyTheme(String collectionName, String userId,
      {required String name, required String url}) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_party_theme', {'name': name, 'url': url}));
      },
      errorMessage: 'Error setting party theme',
    );
  }

  static Future<String?> getPartyThemeId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_party_theme_id'] as String?;
      },
      errorMessage: 'Error fetching party theme ID',
      fallbackValue: null,
    );
  }

  static Future<void> setPartyThemeId(
      String collectionName, String userId, String partyThemeId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_party_theme_id', partyThemeId));
      },
      errorMessage: 'Error setting party theme ID',
    );
  }

// Avatar Frame Methods
  static Future<Map<String, String>?> getAvatarFrame(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, String>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_avatar_frame'] as Map<String, String>?;
      },
      errorMessage: 'Error fetching avatar frame',
      fallbackValue: null,
    );
  }

  static Future<void> setAvatarFrame(String collectionName, String userId,
      {required String name, required String url}) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_avatar_frame', {'name': name, 'url': url}));
      },
      errorMessage: 'Error setting avatar frame',
    );
  }

  static Future<String?> getAvatarFrameId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['using_avatar_frame_id'] as String?;
      },
      errorMessage: 'Error fetching avatar frame ID',
      fallbackValue: null,
    );
  }

  static Future<void> setAvatarFrameId(
      String collectionName, String userId, String avatarFrameId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('using_avatar_frame_id', avatarFrameId));
      },
      errorMessage: 'Error setting avatar frame ID',
    );
  }

  // Obtained Items Methods
  static Future<List<String>> getMyObtainedItems(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final items = user?['my_obtained_items'] as List?;
        return items?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching obtained items',
      fallbackValue: [],
    );
  }

  static Future<void> setMyObtainedItems(
      String collectionName, String userId, String itemId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('my_obtained_items', itemId));
      },
      errorMessage: 'Error adding obtained item',
    );
  }

  static Future<void> removeMyObtainedItems(
      String collectionName, String userId, String itemId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('my_obtained_items', itemId));
      },
      errorMessage: 'Error removing obtained item',
    );
  }

// Fan Club Methods
  static Future<String?> getMyFanClubId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['fan_club_id'] as String?;
      },
      errorMessage: 'Error fetching fan club ID',
      fallbackValue: '',
    );
  }

  static Future<void> setMyFanClubId(
      String collectionName, String userId, String fanClubId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('fan_club_id', fanClubId));
      },
      errorMessage: 'Error setting fan club ID',
    );
  }

  static Future<String?> getMyFanClubName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final name = user?['fan_club_name'] as String?;
        return (name != null && name.isNotEmpty) ? name : null;
      },
      errorMessage: 'Error fetching fan club name',
      fallbackValue: null,
    );
  }

  static Future<void> setMyFanClubName(
      String collectionName, String userId, String fanClubName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('fan_club_name', fanClubName));
      },
      errorMessage: 'Error setting fan club name',
    );
  }

  static Future<List<String>> getMyFanClubMembers(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final members = user?['fan_club_members'] as List?;
        return members?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching fan club members',
      fallbackValue: [],
    );
  }

  static Future<void> setMyFanClubMembers(
      String collectionName, String userId, String memberId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('fan_club_members', memberId));
      },
      errorMessage: 'Error adding fan club member',
    );
  }

  static Future<void> removeMyFanClubMembers(
      String collectionName, String userId, String memberId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('fan_club_members', memberId));
      },
      errorMessage: 'Error removing fan club member',
    );
  }

  static Future<List<String>> getJoinedFanClubIds(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final clubs = user?['joined_fun_club'] as List?;
        return clubs?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching joined fan club IDs',
      fallbackValue: [],
    );
  }

  static Future<void> setJoinedFanClubIds(
      String collectionName, String userId, String fanClubId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('joined_fun_club', fanClubId));
      },
      errorMessage: 'Error adding joined fan club ID',
    );
  }

  static Future<void> removeJoinedFanClubId(
      String collectionName, String userId, String fanClubId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('joined_fun_club', fanClubId));
      },
      errorMessage: 'Error removing joined fan club ID',
    );
  }

  // Face Authentication
  static Future<bool> getIsFaceAuthenticated(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['is_face_authenticated'] as bool? ?? false;
      },
      errorMessage: 'Error fetching face authentication status',
      fallbackValue: false,
    );
  }

  static Future<void> setIsFaceAuthenticated(
      String collectionName, String userId, bool isAuthenticated) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('is_face_authenticated', isAuthenticated));
      },
      errorMessage: 'Error setting face authentication status',
    );
  }

// Payment Methods
  static Future<String?> getSelectedPaymentMethod(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['select_payment_method'] as String?;
      },
      errorMessage: 'Error fetching selected payment method',
      fallbackValue: null,
    );
  }

  static Future<void> setSelectedPaymentMethod(
      String collectionName, String userId, String paymentMethod) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('select_payment_method', paymentMethod));
      },
      errorMessage: 'Error setting selected payment method',
    );
  }

  static Future<String?> getUsdtContactAddress(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['usdt_contact_address'] as String?;
      },
      errorMessage: 'Error fetching USDT contact address',
      fallbackValue: null,
    );
  }

  static Future<void> setUsdtContactAddress(
      String collectionName, String userId, String usdtContactAddress) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('usdt_contact_address', usdtContactAddress));
      },
      errorMessage: 'Error setting USDT contact address',
    );
  }

  static Future<String?> getWalletAddress(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['wallet_address'] as String?;
      },
      errorMessage: 'Error fetching wallet address',
      fallbackValue: null,
    );
  }

  static Future<void> setWalletAddress(
      String collectionName, String userId, String walletAddress) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('wallet_address', walletAddress));
      },
      errorMessage: 'Error setting wallet address',
    );
  }

  static Future<String?> getPayoneerName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['payoneer_name'] as String?;
      },
      errorMessage: 'Error fetching Payoneer name',
      fallbackValue: null,
    );
  }

  static Future<void> setPayoneerName(
      String collectionName, String userId, String payoneerName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('payoneer_name', payoneerName));
      },
      errorMessage: 'Error setting Payoneer name',
    );
  }

  static Future<String?> getPayPalName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['paypal_name'] as String?;
      },
      errorMessage: 'Error fetching PayPal name',
      fallbackValue: null,
    );
  }

  static Future<void> setPayPalName(
      String collectionName, String userId, String payPalName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('paypal_name', payPalName));
      },
      errorMessage: 'Error setting PayPal name',
    );
  }

// Virtual Currency (PCoins)
  static Future<int> getPCoins(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['p_coins'] as int? ?? 0;
      },
      errorMessage: 'Error fetching PCoins',
      fallbackValue: 0,
    );
  }

  static Future<void> setPCoins(
      String collectionName, String userId, int amount) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.inc('p_coins', amount));
      },
      errorMessage: 'Error adding PCoins',
    );
  }

  static Future<void> removePCoins(
      String collectionName, String userId, int amount) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.inc('p_coins', -amount));
      },
      errorMessage: 'Error removing PCoins',
    );
  }

  // Guardian of King
  static Future<bool> isGuardianOfKing(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['king_guardian'] != null) {
          DateTime date = DateTime.tryParse(user['king_guardian'].toString()) ??
              DateTime.now();
          return DateTime.now().isBefore(date);
        }
        return false;
      },
      errorMessage: 'Error fetching guardian of king status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getGuardianOfKing(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['king_guardian'] != null) {
          return DateTime.tryParse(user['king_guardian'].toString());
        }
        return null;
      },
      errorMessage: 'Error fetching guardian of king date',
      fallbackValue: null,
    );
  }

  static Future<void> setGuardianOfKing(
      String collectionName, String userId, DateTime date) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('king_guardian', date.toIso8601String()));
      },
      errorMessage: 'Error setting guardian of king',
    );
  }

// Guardian of Gold
  static Future<bool> isGuardianOfGold(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['gold_guardian'] != null) {
          DateTime date = DateTime.tryParse(user['gold_guardian'].toString()) ??
              DateTime.now();
          return DateTime.now().isBefore(date);
        }
        return false;
      },
      errorMessage: 'Error fetching guardian of gold status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getGuardianOfGold(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['gold_guardian'] != null) {
          return DateTime.tryParse(user['gold_guardian'].toString());
        }
        return null;
      },
      errorMessage: 'Error fetching guardian of gold date',
      fallbackValue: null,
    );
  }

  static Future<void> setGuardianOfGold(
      String collectionName, String userId, DateTime date) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('gold_guardian', date.toIso8601String()));
      },
      errorMessage: 'Error setting guardian of gold',
    );
  }

// Guardian of Silver
  static Future<bool> isGuardianOfSilver(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['silver_guardian'] != null) {
          DateTime date =
              DateTime.tryParse(user['silver_guardian'].toString()) ??
                  DateTime.now();
          return DateTime.now().isBefore(date);
        }
        return false;
      },
      errorMessage: 'Error fetching guardian of silver status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getGuardianOfSilver(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['silver_guardian'] != null) {
          return DateTime.tryParse(user['silver_guardian'].toString());
        }
        return null;
      },
      errorMessage: 'Error fetching guardian of silver date',
      fallbackValue: null,
    );
  }

  static Future<void> setGuardianOfSilver(
      String collectionName, String userId, DateTime date) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('silver_guardian', date.toIso8601String()));
      },
      errorMessage: 'Error setting guardian of silver',
    );
  }

// People Guarding Me
  static Future<List<String>> getPeopleGuardingMe(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final list = user?['people_guarding_me'] as List?;
        return list?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching people guarding me',
      fallbackValue: [],
    );
  }

  static Future<void> setPeopleGuardingMe(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('people_guarding_me', userID));
      },
      errorMessage: 'Error adding people guarding me',
    );
  }

  static Future<void> removePeopleGuardingMe(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('people_guarding_me', userID));
      },
      errorMessage: 'Error removing people guarding me',
    );
  }

// My Guardians
  static Future<List<String>> getMyGuardians(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final list = user?['my_guardian'] as List?;
        return list?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching my guardians',
      fallbackValue: [],
    );
  }

  static Future<void> setMyGuardians(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('my_guardian', userID));
      },
      errorMessage: 'Error adding my guardian',
    );
  }

  static Future<void> removeMyGuardians(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.pull('my_guardian', userID));
      },
      errorMessage: 'Error removing my guardian',
    );
  }

// Vibrate
  static Future<bool> getVibrate(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['vibrate'] as bool? ?? true;
      },
      errorMessage: 'Error fetching vibrate setting',
      fallbackValue: true,
    );
  }

  static Future<void> setVibrate(
      String collectionName, String userId, bool isVibrate) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('vibrate', isVibrate));
      },
      errorMessage: 'Error setting vibrate',
    );
  }

// Sound
  static Future<bool> getSound(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['sound'] as bool? ?? true;
      },
      errorMessage: 'Error fetching sound setting',
      fallbackValue: true,
    );
  }

  static Future<void> setSound(
      String collectionName, String userId, bool isSound) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('sound', isSound));
      },
      errorMessage: 'Error setting sound',
    );
  }

  // Accept Calls
  static Future<bool> getAcceptCalls(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['accept_calls'] as bool? ?? true;
      },
      errorMessage: 'Error fetching accept calls',
      fallbackValue: true,
    );
  }

  static Future<void> setAcceptCalls(
      String collectionName, String userId, bool isAcceptCalls) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('accept_calls', isAcceptCalls));
      },
      errorMessage: 'Error setting accept calls',
    );
  }

// Message Notification Switch
  static Future<bool> getMessageNotificationSwitch(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['message_notification_switch'] as bool? ?? true;
      },
      errorMessage: 'Error fetching message notification switch',
      fallbackValue: true,
    );
  }

  static Future<void> setMessageNotificationSwitch(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('message_notification_switch', value));
      },
      errorMessage: 'Error setting message notification switch',
    );
  }

// Live Opening Alert
  static Future<bool> getLiveOpeningAlert(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['live_opening_alert'] as bool? ?? true;
      },
      errorMessage: 'Error fetching live opening alert',
      fallbackValue: true,
    );
  }

  static Future<void> setLiveOpeningAlert(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('live_opening_alert', value));
      },
      errorMessage: 'Error setting live opening alert',
    );
  }

// Diamond VIP
  static Future<bool> isDiamondVip(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['diamond_vip'] != null) {
          DateTime date = DateTime.tryParse(user['diamond_vip'].toString()) ??
              DateTime.now();
          return DateTime.now().isBefore(date);
        }
        return false;
      },
      errorMessage: 'Error fetching diamond VIP status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getDiamondVip(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['diamond_vip'] != null
            ? DateTime.tryParse(user['diamond_vip'].toString())
            : null;
      },
      errorMessage: 'Error fetching diamond VIP date',
      fallbackValue: null,
    );
  }

  static Future<void> setDiamondVip(
      String collectionName, String userId, DateTime date) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('diamond_vip', date.toIso8601String()));
      },
      errorMessage: 'Error setting diamond VIP date',
    );
  }

// Super VIP
  static Future<bool> isSuperVip(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['super_vip'] != null) {
          DateTime date =
              DateTime.tryParse(user['super_vip'].toString()) ?? DateTime.now();
          return DateTime.now().isBefore(date);
        }
        return false;
      },
      errorMessage: 'Error fetching super VIP status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getSuperVip(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['super_vip'] != null
            ? DateTime.tryParse(user['super_vip'].toString())
            : null;
      },
      errorMessage: 'Error fetching super VIP date',
      fallbackValue: null,
    );
  }

  static Future<void> setSuperVip(
      String collectionName, String userId, DateTime date) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('super_vip', date.toIso8601String()));
      },
      errorMessage: 'Error setting super VIP date',
    );
  }

// Invisible Visitor
  static Future<bool> getInvisibleVisitor(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['invisible_visitor'] as bool? ?? false;
      },
      errorMessage: 'Error fetching invisible visitor',
      fallbackValue: false,
    );
  }

  static Future<void> setInvisibleVisitor(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('invisible_visitor', value));
      },
      errorMessage: 'Error setting invisible visitor',
    );
  }

// Mysterious Man
  static Future<bool> getMysteriousMan(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['mysterious_man'] as bool? ?? false;
      },
      errorMessage: 'Error fetching mysterious man',
      fallbackValue: false,
    );
  }

  static Future<void> setMysteriousMan(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('mysterious_man', value));
      },
      errorMessage: 'Error setting mysterious man',
    );
  }

// Mystery Man
  static Future<bool> getMysteryMan(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['mystery_man'] as bool? ?? false;
      },
      errorMessage: 'Error fetching mystery man',
      fallbackValue: false,
    );
  }

  static Future<void> setMysteryMan(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('mystery_man', value));
      },
      errorMessage: 'Error setting mystery man',
    );
  }

// App Language
  static Future<String> getAppLanguage(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final languages = user?['app_language'] as List?;
        return (languages != null && languages.isNotEmpty)
            ? languages[0].toString()
            : "";
      },
      errorMessage: 'Error fetching app language',
      fallbackValue: "",
    );
  }

  static Future<void> setAppLanguage(
      String collectionName, String userId, String language) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('app_language', [language]));
      },
      errorMessage: 'Error setting app language',
    );
  }

  static Future<void> removeAppLanguage(
      String collectionName, String userId, String language) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('app_language', language));
      },
      errorMessage: 'Error removing app language',
    );
  }

// Close Friends
  static Future<List<String>> getCloseFriends(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final list = user?['friends'] as List?;
        return list?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching close friends',
      fallbackValue: [],
    );
  }

  static Future<void> setCloseFriend(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.addToSet('friends', userID));
      },
      errorMessage: 'Error adding close friend',
    );
  }

  static Future<void> removeCloseFriend(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.pull('friends', userID));
      },
      errorMessage: 'Error removing close friend',
    );
  }

// Visitors
  static Future<List<String>> getVisitors(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<String>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        final list = user?['visitors'] as List?;
        return list?.cast<String>() ?? [];
      },
      errorMessage: 'Error fetching visitors',
      fallbackValue: [],
    );
  }

  static Future<void> setVisitors(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.addToSet('visitors', userID));
      },
      errorMessage: 'Error adding visitor',
    );
  }

  static Future<void> removeVisitors(
      String collectionName, String userId, String userID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.pull('visitors', userID));
      },
      errorMessage: 'Error removing visitor',
    );
  }

// Gifts Amount
  static Future<int> getGiftsAmount(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['received_gifts_amount'] as int? ?? 0;
      },
      errorMessage: 'Error fetching gifts amount',
      fallbackValue: 0,
    );
  }

  static Future<void> setGiftsAmount(
      String collectionName, String userId, int giftsAmount) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('received_gifts_amount', giftsAmount));
      },
      errorMessage: 'Error setting gifts amount',
    );
  }

  // MongoDBUtils for Post IDs, Blacklist, User State, Chat, SessionToken, and UID
// Post IDs
  static Future<void> setIdsToPostList(
      String collectionName, String userId, List<dynamic> ids) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.set('post_ids_list', ids),
        );
      },
      errorMessage: 'Error setting post ID list',
    );
  }

  static Future<void> setIdToPostList(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.addToSet('post_ids_list', id),
        );
      },
      errorMessage: 'Error adding post ID',
    );
  }

  static Future<void> removePostId(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.pull('post_ids_list', id),
        );
      },
      errorMessage: 'Error removing post ID',
    );
  }

  static Future<List<dynamic>> getPostIdList(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['post_ids_list'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching post ID list',
      fallbackValue: [],
    );
  }

// Blacklist
  static Future<void> setIdsToBlackList(
      String collectionName, String userId, List<dynamic> ids) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.set('black_list', ids),
        );
      },
      errorMessage: 'Error setting black list',
    );
  }

  static Future<void> setIdToBlackList(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.addToSet('black_list', id),
        );
      },
      errorMessage: 'Error adding to black list',
    );
  }

  static Future<void> removeIdFromBlackList(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.pull('black_list', id),
        );
      },
      errorMessage: 'Error removing from black list',
    );
  }

  static Future<List<dynamic>> getIdFromBlackList(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['black_list'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching black list',
      fallbackValue: [],
    );
  }

// User State In App
  static Future<String> getUserStateInApp(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['user_state_in_app'] as String? ?? 'Offline';
      },
      errorMessage: 'Error fetching user state',
      fallbackValue: 'Offline',
    );
  }

  static Future<void> setUserStateInApp(
      String collectionName, String userId, String state) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.set('user_state_in_app', state),
        );
      },
      errorMessage: 'Error setting user state',
    );
  }

// Chat With Users
  static Future<void> setChatWithUsersIds(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.addToSet('chat_with_users', id),
        );
      },
      errorMessage: 'Error adding chat with user',
    );
  }

  static Future<void> removeChatWithUsersIds(
      String collectionName, String userId, String id) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.pull('chat_with_users', id),
        );
      },
      errorMessage: 'Error removing chat with user',
    );
  }

  static Future<List<dynamic>> getChatWithUsersIds(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['chat_with_users'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching chat with users',
      fallbackValue: [],
    );
  }

// Session Token
  static Future<String?> getSessionToken(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['sessionToken'] as String?;
      },
      errorMessage: 'Error fetching session token',
      fallbackValue: null,
    );
  }

// UID
  static Future<int> getUid(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['uid'] as int? ?? 00000000;
      },
      errorMessage: 'Error fetching UID',
      fallbackValue: 00000000,
    );
  }

  static Future<void> setUid(
      String collectionName, String userId, int uid) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.set('uid', uid),
        );
      },
      errorMessage: 'Error setting UID',
    );
  }

  // User Role
  static Future<String?> getUserRole(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['role'] as String?;
      },
      errorMessage: 'Error fetching user role',
      fallbackValue: null,
    );
  }

  static Future<void> setUserRole(
      String collectionName, String userId, String role) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('role', role));
      },
      errorMessage: 'Error setting user role',
    );
  }

  // Username
  static Future<String?> getUsername(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['username'] as String?;
      },
      errorMessage: 'Error fetching username',
      fallbackValue: null,
    );
  }

  static Future<void> setUsername(
      String collectionName, String userId, String username) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('username', username));
      },
      errorMessage: 'Error setting username',
    );
  }

  // Email
  static Future<String?> getEmail(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['email'] as String?;
      },
      errorMessage: 'Error fetching email',
      fallbackValue: null,
    );
  }

  static Future<void> setEmail(
      String collectionName, String userId, String email) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('email', email));
      },
      errorMessage: 'Error setting email',
    );
  }

  // Email Public
  static Future<String?> getEmailPublic(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['email_public'] as String?;
      },
      errorMessage: 'Error fetching public email',
      fallbackValue: null,
    );
  }

  static Future<void> setEmailPublic(
      String collectionName, String userId, String emailPublic) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('email_public', emailPublic));
      },
      errorMessage: 'Error setting public email',
    );
  }

  // Full Name
  static Future<String?> getFullName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['name'] as String?;
      },
      errorMessage: 'Error fetching full name',
      fallbackValue: null,
    );
  }

  static Future<void> setFullName(
      String collectionName, String userId, String fullName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('name', fullName));
      },
      errorMessage: 'Error setting full name',
    );
  }

  // First Name
  static Future<String?> getFirstName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['first_name'] as String?;
      },
      errorMessage: 'Error fetching first name',
      fallbackValue: null,
    );
  }

  static Future<void> setFirstName(
      String collectionName, String userId, String firstName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('first_name', firstName));
      },
      errorMessage: 'Error setting first name',
    );
  }

  // Last Name
  static Future<String?> getLastName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['last_name'] as String?;
      },
      errorMessage: 'Error fetching last name',
      fallbackValue: null,
    );
  }

  static Future<void> setLastName(
      String collectionName, String userId, String lastName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('last_name', lastName));
      },
      errorMessage: 'Error setting last name',
    );
  }

  // Gender
  static Future<String> getGender(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['gender'] as String? ?? "N/A";
      },
      errorMessage: 'Error fetching gender',
      fallbackValue: "N/A",
    );
  }

  static Future<void> setGender(
      String collectionName, String userId, String gender) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('gender', gender));
      },
      errorMessage: 'Error setting gender',
    );
  }

  // Gender
  static Future<String> getGenderPref(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['prefGender'] as String? ?? "both";
      },
      errorMessage: 'Error fetching gender preference',
      fallbackValue: "both",
    );
  }

  static Future<void> setGenderPref(
      String collectionName, String userId, String genderPref) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('prefGender', genderPref));
      },
      errorMessage: 'Error setting gender preference',
    );
  }

  // Preferred Distance (fallback Setup.maxDistanceBetweenUsers)
  static Future<int> getPrefDistance(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['distanceFilter'] as int? ?? 0;
      },
      errorMessage: 'Error fetching preferred distance',
      fallbackValue: 0,
    );
  }

  static Future<void> setPrefDistance(
      String collectionName, String userId, int distance) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('distanceFilter', distance));
      },
      errorMessage: 'Error setting preferred distance',
    );
  }

  // Bio (fallback "")
  static Future<String> getBio(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['bio'] as String? ?? "";
      },
      errorMessage: 'Error fetching bio',
      fallbackValue: "",
    );
  }

  static Future<void> setBio(
      String collectionName, String userId, String bio) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('bio', bio));
      },
      errorMessage: 'Error setting bio',
    );
  }

  // Avatar (stored as a map)
  static Future<Map<String, dynamic>?> getAvatar(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, dynamic>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['avatar'] as Map<String, dynamic>?;
      },
      errorMessage: 'Error fetching avatar',
      fallbackValue: null,
    );
  }

  static Future<void> setAvatar(String collectionName, String userId,
      {required String name, required String url}) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('avatar', {'name': name, 'url': url}));
      },
      errorMessage: 'Error setting avatar',
    );
  }

  // Images List (stored as a list)
  static Future<List<Map<String, String>>> getImagesList(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<
        List<Map<String, String>>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));

        if (user == null || user['list_of_images'] == null) {
          return [];
        }

        // Properly convert the dynamic list to the required type
        final List<dynamic> rawImages = user['list_of_images'] as List<dynamic>;
        return rawImages
            .map((image) => {
                  'name': image['name'] as String,
                  'url': image['url'] as String
                })
            .toList();
      },
      errorMessage: 'Error fetching images list',
      fallbackValue: [],
    );
  }

// Set the entire list of images
  static Future<void> setImagesList(
      String collectionName, String userId, String name, String url) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        List<Map<String, String>> imagesList = [
          {'name': name, 'url': url}
        ];
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set('list_of_images', imagesList),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting images list',
    );
  }

// Add a single image to the list
  static Future<void> addImageToList(
      String collectionName, String userId, String name, String url) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        final imageData = {'name': name, 'url': url};

        await collection.updateOne(
          where.eq('objectId', userId),
          modify.addToSet('list_of_images', imageData),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding image to list',
    );
  }

  static Future<void> removeImageFromList(
      String collectionName, String userId, String imageUrl) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        // Get current images list
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['list_of_images'] != null) {
          final List<dynamic> currentImages =
              user['list_of_images'] as List<dynamic>;
          // Filter out the image with the matching URL
          final updatedImages =
              currentImages.where((image) => image['url'] != imageUrl).toList();

          // Update with the filtered list
          await collection.updateOne(
            where.eq('objectId', userId),
            modify.set('list_of_images', updatedImages),
          );
          await _saveUser(collectionName: collectionName, userId: userId);
        }
      },
      errorMessage: 'Error removing image from list',
    );
  }

  // Cover (stored as a map)
  static Future<Map<String, dynamic>?> getCover(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, dynamic>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['cover'] as Map<String, dynamic>?;
      },
      errorMessage: 'Error fetching cover',
      fallbackValue: null,
    );
  }

  static Future<void> setCover(String collectionName, String userId,
      {required String name, required String url}) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('cover', {'name': name, 'url': url}));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting cover',
    );
  }

  static Future<DateTime> getBirthday(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['birthday'] != null) {
          return DateTime.tryParse(user['birthday'].toString()) ??
              DateTime(1999);
        }
        return DateTime(1999);
      },
      errorMessage: 'Error fetching birthday',
      fallbackValue: DateTime(1999),
    );
  }

  static Future<void> setBirthday(
      String collectionName, String userId, DateTime birthday) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('birthday', birthday.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting birthday',
    );
  }

  static Future<DateTime?> getLastOnline(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['lastOnline'] != null
            ? DateTime.tryParse(user!['lastOnline'].toString())
            : null;
      },
      errorMessage: 'Error fetching last online',
      fallbackValue: null,
    );
  }

  static Future<void> setLastOnline(
      String collectionName, String userId, DateTime time) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('lastOnline', time.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting last online',
    );
  }

  static Future<bool> getEmailVerified(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['emailVerified'] as bool? ?? true;
      },
      errorMessage: 'Error fetching email verified',
      fallbackValue: true,
    );
  }

  static Future<void> setEmailVerified(
      String collectionName, String userId, bool verified) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('emailVerified', verified));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting email verified',
    );
  }

  static Future<bool> getActivationStatus(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['activationStatus'] as bool? ?? false;
      },
      errorMessage: 'Error fetching activation status',
      fallbackValue: false,
    );
  }

  static Future<void> setActivationStatus(
      String collectionName, String userId, bool activated) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('activationStatus', activated));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting activation status',
    );
  }

  static Future<bool> getAccountDeleted(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['accountDeleted'] as bool? ?? false;
      },
      errorMessage: 'Error fetching account deleted status',
      fallbackValue: false,
    );
  }

  static Future<void> setAccountDeleted(
      String collectionName, String userId, bool deleted) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('accountDeleted', deleted));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting account deleted status',
    );
  }

  static Future<String> getFacebookId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['fbId'] as String? ?? "";
      },
      errorMessage: 'Error fetching Facebook ID',
      fallbackValue: "",
    );
  }

  static Future<void> setFacebookId(
      String collectionName, String userId, String facebookId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('fbId', facebookId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting Facebook ID',
    );
  }

  static Future<String> getGoogleId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['ggId'] as String? ?? "";
      },
      errorMessage: 'Error fetching Google ID',
      fallbackValue: "",
    );
  }

  static Future<void> setGoogleId(
      String collectionName, String userId, String googleId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('ggId', googleId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting Google ID',
    );
  }

  static Future<bool> isAdmin(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String role = user?['role'] as String? ?? "";
        return role == "admin";
      },
      errorMessage: 'Error fetching admin status',
      fallbackValue: false,
    );
  }

  static Future<bool> isDeleted(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['activationStatus'] as bool? ?? false;
      },
      errorMessage: 'Error fetching deleted status',
      fallbackValue: false,
    );
  }

  static Future<bool> isSuspended(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['accountDeleted'] as bool? ?? false;
      },
      errorMessage: 'Error fetching suspended status',
      fallbackValue: false,
    );
  }

  static Future<bool> getIsDeletedOrSuspended(
      String collectionName, String userId) async {
    bool deleted = await isDeleted(collectionName, userId);
    bool suspended = await isSuspended(collectionName, userId);
    return deleted || suspended;
  }

  static Future<String?> getAccountDeletedReason(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['accountDeletedReason'] as String?;
      },
      errorMessage: 'Error fetching account deleted reason',
      fallbackValue: null,
    );
  }

  static Future<void> setAccountDeletedReason(
      String collectionName, String userId, String reason) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('accountDeletedReason', reason));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting account deleted reason',
    );
  }

  static Future<String?> getAppleId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['appleId'] as String?;
      },
      errorMessage: 'Error fetching Apple ID',
      fallbackValue: null,
    );
  }

  static Future<void> setAppleId(
      String collectionName, String userId, String appleId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('appleId', appleId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting Apple ID',
    );
  }

  static Future<String?> getInstagramId(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['instaId'] as String?;
      },
      errorMessage: 'Error fetching Instagram ID',
      fallbackValue: null,
    );
  }

  static Future<void> setInstagramId(
      String collectionName, String userId, String instagramId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('instaId', instagramId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting Instagram ID',
    );
  }

  static Future<bool> getHasPassword(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['has_password'] as bool? ?? false;
      },
      errorMessage: 'Error fetching has password',
      fallbackValue: false,
    );
  }

  static Future<void> setHasPassword(
      String collectionName, String userId, bool hasPassword) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('has_password', hasPassword));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting has password',
    );
  }

  static Future<bool> getHasGeoPoint(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['hasGeopoint'] as bool? ?? false;
      },
      errorMessage: 'Error fetching geopoint status',
      fallbackValue: false,
    );
  }

  static Future<void> setHasGeoPoint(
      String collectionName, String userId, bool hasGeoPoint) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('hasGeopoint', hasGeoPoint));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting geopoint status',
    );
  }

  static Future<bool> getLocationTypeNearBy(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['prefLocationType'] as bool? ?? true;
      },
      errorMessage: 'Error fetching location type nearby',
      fallbackValue: true,
    );
  }

  static Future<void> setLocationTypeNearBy(
      String collectionName, String userId, bool prefLocationType) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('prefLocationType', prefLocationType));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting location type nearby',
    );
  }

  static Future<String> getLocation(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? loc = user?['location'] as String?;
        return (loc != null && loc.isNotEmpty) ? loc : "no location update";
      },
      errorMessage: 'Error fetching location',
    );
  }

  static Future<String> getLocationOrEmpty(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['location'] as String? ?? "";
      },
      errorMessage: 'Error fetching location',
      fallbackValue: "",
    );
  }

  static Future<String> getLocationOnly(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? loc = user?['location'] as String?;
        return (loc != null && loc.isNotEmpty) ? loc : "add city name";
      },
      errorMessage: 'Error fetching location',
    );
  }

  static Future<void> setLocation(
      String collectionName, String userId, String location) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('location', location));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting location',
    );
  }

  static Future<String> getCity(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['city'] as String? ?? "";
      },
      errorMessage: 'Error fetching city',
    );
  }

  static Future<void> setCity(
      String collectionName, String userId, String city) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('city', city));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting city',
    );
  }

  static Future<int> getPopularity(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['popularity'] as int? ?? 0;
      },
      errorMessage: 'Error fetching popularity',
      fallbackValue: 0,
    );
  }

  static Future<void> setPopularity(
      String collectionName, String userId, int popularity) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('popularity', popularity));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting popularity',
    );
  }

  static Future<int> getPrefMinAge(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['prefMinAge'] as int? ?? 16;
      },
      errorMessage: 'Error fetching preferred minimum age',
      fallbackValue: 16,
    );
  }

  static Future<void> setPrefMinAge(
      String collectionName, String userId, int minAge) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('prefMinAge', minAge));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting preferred minimum age',
    );
  }

  static Future<int> getPrefMaxAge(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['prefMaxAge'] as int? ?? 16;
      },
      errorMessage: 'Error fetching preferred maximum age',
      fallbackValue: 16,
    );
  }

  static Future<void> setPrefMaxAge(
      String collectionName, String userId, int maxAge) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('prefMaxAge', maxAge));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting preferred maximum age',
    );
  }

  static Future<int> getCredits(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['credit'] as int? ?? 0;
      },
      errorMessage: 'Error fetching credits',
      fallbackValue: 0,
    );
  }

  static Future<int> getCreditsSent(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['creditSent'] as int? ?? 0;
      },
      errorMessage: 'Error fetching credits sent',
      fallbackValue: 0,
    );
  }

  static Future<int> getPlatformSpeakerNumber(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['platformSpeakerNumber'] as int? ?? 0;
      },
      errorMessage: 'Error fetching platform speaker number',
      fallbackValue: 0,
    );
  }

  static Future<void> addPlatformSpeakerNumber(
      String collectionName, String userId, int number) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.inc('platformSpeakerNumber', number));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding platform speaker number',
    );
  }

  static Future<void> removePlatformSpeakerNumber(
      String collectionName, String userId, int number) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.inc('platformSpeakerNumber', -number));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing platform speaker number',
    );
  }

  static Future<void> addCredit(
      String collectionName, String userId, int credits) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.inc('credit', credits));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding credits',
    );
  }

  // MongoDBUtils for Location, Company & Financial Fields
  static Future<void> removeCredit(
      String collectionName, String userId, int credits) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
          where.eq('objectId', userId),
          modify.inc('credit', -credits),
        );
        await collection.update(
          where.eq('objectId', userId),
          modify.inc('creditSent', credits),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing credits',
    );
  }

  static Future<String> getCountry(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? country = user?['country'] as String?;
        return (country != null && country.isNotEmpty) ? country : "";
      },
      errorMessage: 'Error fetching country',
      fallbackValue: "",
    );
  }

  static Future<void> setCountry(
      String collectionName, String userId, String country) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('country', country));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting country',
    );
  }

  static Future<String> getCountryCode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? code = user?['country_code'] as String?;
        return (code != null && code.isNotEmpty) ? code : "GH";
      },
      errorMessage: 'Error fetching country code',
      fallbackValue: "GH",
    );
  }

  static Future<void> setCountryCode(
      String collectionName, String userId, String countryCode) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('country_code', countryCode));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting country code',
    );
  }

  static Future<void> setCurrencyCode(
      String collectionName, String userId, String currencyCode) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('currency_code', currencyCode));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting currency code',
    );
  }

  static Future<String> getCurrencyCode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? code = user?['currency_code'] as String?;
        return (code != null && code.isNotEmpty) ? code : "USD";
      },
      errorMessage: 'Error fetching currency code',
      fallbackValue: "USD",
    );
  }

  static Future<void> setCurrencySymbol(
      String collectionName, String userId, String currencySymbol) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('currency_symbiol', currencySymbol));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting currency symbol',
    );
  }

  static Future<String> getCurrencySymbol(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? symbol = user?['currency_symbiol'] as String?;
        return (symbol != null && symbol.isNotEmpty) ? symbol : "USD";
      },
      errorMessage: 'Error fetching currency symbol',
      fallbackValue: "USD",
    );
  }

  static Future<String?> getCountryDialCode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['country_dial_code'] as String?;
      },
      errorMessage: 'Error fetching country dial code',
      fallbackValue: null,
    );
  }

  static Future<void> setCountryDialCode(
      String collectionName, String userId, String dialCode) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('country_dial_code', dialCode));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting country dial code',
    );
  }

  static Future<String> getPhoneNumber(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? phone = user?['phone_number'] as String?;
        return (phone != null && phone.isNotEmpty) ? phone : "";
      },
      errorMessage: 'Error fetching phone number',
      fallbackValue: "",
    );
  }

  static Future<void> setPhoneNumber(
      String collectionName, String userId, String phoneNumber) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('phone_number', phoneNumber));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting phone number',
    );
  }

  static Future<void> setPhoneNumberFull(
      String collectionName, String userId, String phoneNumberFull) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('phone_number_full', phoneNumberFull));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting full phone number',
    );
  }

  static Future<String> getPhoneNumberFull(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? phone = user?['phone_number_full'] as String?;
        return (phone != null && phone.isNotEmpty) ? phone : "";
      },
      errorMessage: 'Error fetching full phone number',
      fallbackValue: "",
    );
  }

  static Future<String> getCompanyName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? company = user?['company_name'] as String?;
        return (company != null && company.isNotEmpty) ? company : "";
      },
      errorMessage: 'Error fetching company name',
      fallbackValue: "",
    );
  }

  static Future<void> setCompanyName(
      String collectionName, String userId, String companyName) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('company_name', companyName));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting company name',
    );
  }

  static Future<String> getJobTitle(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? job = user?['job_title'] as String?;
        return (job != null && job.isNotEmpty) ? job : "";
      },
      errorMessage: 'Error fetching job title',
      fallbackValue: "",
    );
  }

  static Future<void> setJobTitle(
      String collectionName, String userId, String jobTitle) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('job_title', jobTitle));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting job title',
    );
  }

  static Future<String> getSchool(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? school = user?['school'] as String?;
        return (school != null && school.isNotEmpty) ? school : "";
      },
      errorMessage: 'Error fetching school',
      fallbackValue: "",
    );
  }

  static Future<void> setSchool(
      String collectionName, String userId, String school) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('school', school));
      },
      errorMessage: 'Error setting school',
    );
  }

  // MongoDBUtils for About, Mood, VIP & Privacy Settings
  static Future<String> getAboutYou(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? about = user?['aboutMe'] as String?;
        return (about != null && about.isNotEmpty) ? about : "";
      },
      errorMessage: 'Error fetching about you',
      fallbackValue: "",
    );
  }

  static Future<void> setAboutYou(
      String collectionName, String userId, String about) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('aboutMe', about));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting about you',
    );
  }

  static Future<String> getMoodTitle(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? mood = user?['mood'] as String?;
        return (mood != null && mood.isNotEmpty) ? mood : "";
      },
      errorMessage: 'Error fetching mood title',
      fallbackValue: "",
    );
  }

  static Future<void> setMoodTitle(
      String collectionName, String userId, String moodTitle) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('mood', moodTitle));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting mood title',
    );
  }

  static Future<bool> getPhotoVerified(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['photo_verified'] as bool? ?? false;
      },
      errorMessage: 'Error fetching photo verified status',
      fallbackValue: false,
    );
  }

  static Future<void> setPhotoVerified(
      String collectionName, String userId, bool photoVerified) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('photo_verified', photoVerified));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting photo verified status',
    );
  }

  static Future<bool> isNormalVip(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['normal_vip'] != null) {
          DateTime normalVip =
              DateTime.tryParse(user['normal_vip'].toString()) ??
                  DateTime.now();
          return DateTime.now().isBefore(normalVip);
        }
        return false;
      },
      errorMessage: 'Error fetching normal VIP status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getNormalVip(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['normal_vip'] != null
            ? DateTime.tryParse(user['normal_vip'].toString())
            : null;
      },
      errorMessage: 'Error fetching normal VIP date',
      fallbackValue: null,
    );
  }

  static Future<void> setNormalVip(
      String collectionName, String userId, DateTime normalVip) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('normal_vip', normalVip.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting normal VIP',
    );
  }

  static Future<DateTime?> getDailyGift(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['dailyGift'] != null
            ? DateTime.tryParse(user['dailyGift'].toString())
            : null;
      },
      errorMessage: 'Error fetching daily gift',
      fallbackValue: null,
    );
  }

  static Future<void> setDailyGift(
      String collectionName, String userId, DateTime dailyGift) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('dailyGift', dailyGift.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting daily gift',
    );
  }

  static Future<bool> isDailyGift(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['dailyGift'] != null) {
          DateTime dailyGift =
              DateTime.tryParse(user['dailyGift'].toString()) ?? DateTime.now();
          return DateTime.now().isBefore(dailyGift);
        }
        return false;
      },
      errorMessage: 'Error fetching daily gift status',
      fallbackValue: false,
    );
  }

  static Future<DateTime?> getVipAdsDisabled(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['AdsDisabled'] != null
            ? DateTime.tryParse(user['AdsDisabled'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP ads disabled date',
      fallbackValue: null,
    );
  }

  static Future<void> setVipAdsDisabled(
      String collectionName, String userId, DateTime adsDisabled) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('AdsDisabled', adsDisabled.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP ads disabled date',
    );
  }

  static Future<DateTime?> getVip3xPopular(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['popular'] != null
            ? DateTime.tryParse(user['popular'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP 3x popular date',
      fallbackValue: null,
    );
  }

  static Future<void> setVip3xPopular(
      String collectionName, String userId, DateTime xPopular) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('popular', xPopular.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP 3x popular date',
    );
  }

  static Future<DateTime?> getVipShowOnline(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['showOnline'] != null
            ? DateTime.tryParse(user['showOnline'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP show online date',
      fallbackValue: null,
    );
  }

  static Future<void> setVipShowOnline(
      String collectionName, String userId, DateTime showOnline) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('showOnline', showOnline.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP show online date',
    );
  }

  static Future<DateTime?> getVipExtraShows(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['extraShows'] != null
            ? DateTime.tryParse(user['extraShows'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP extra shows date',
      fallbackValue: null,
    );
  }

  static Future<void> setVipExtraShows(
      String collectionName, String userId, DateTime extraShows) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('extraShows', extraShows.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP extra shows date',
    );
  }

  static Future<DateTime?> getVipMoreVisits(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['getMoreVisits'] != null
            ? DateTime.tryParse(user['getMoreVisits'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP more visits date',
      fallbackValue: null,
    );
  }

  static Future<void> setVipMoreVisits(
      String collectionName, String userId, DateTime moreVisits) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('getMoreVisits', moreVisits.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP more visits date',
    );
  }

  static Future<DateTime?> getVipMoveToTop(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<DateTime?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null && user['moveToTop'] != null
            ? DateTime.tryParse(user['moveToTop'].toString())
            : null;
      },
      errorMessage: 'Error fetching VIP move to top date',
      fallbackValue: null,
    );
  }

  static Future<void> setVipMoveToTop(
      String collectionName, String userId, DateTime moveToTop) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('moveToTop', moveToTop.toIso8601String()));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP move to top date',
    );
  }

  static Future<bool> getVipInvisibleMode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['invisibleMode'] as bool? ?? false;
      },
      errorMessage: 'Error fetching VIP invisible mode status',
      fallbackValue: false,
    );
  }

  static Future<void> setVipInvisibleMode(
      String collectionName, String userId, bool invisibleMode) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('invisibleMode', invisibleMode));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP invisible mode status',
    );
  }

  static Future<bool> getVipIsInvisible(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['isInvisible'] as bool? ?? false;
      },
      errorMessage: 'Error fetching VIP is invisible status',
      fallbackValue: false,
    );
  }

  static Future<void> setVipIsInvisible(
      String collectionName, String userId, bool isInvisible) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('isInvisible', isInvisible));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting VIP is invisible status',
    );
  }

  static Future<void> setNameChanged(
      String collectionName, String userId, bool nameChanged) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('has_name_changed', nameChanged));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting name changed flag',
    );
  }

  static Future<bool> getAccountHidden(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['account_hidden'] as bool? ?? false;
      },
      errorMessage: 'Error fetching account hidden status',
      fallbackValue: false,
    );
  }

  static Future<void> setAccountHidden(
      String collectionName, String userId, bool hidden) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('account_hidden', hidden));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting account hidden status',
    );
  }

  // MongoDBUtils for Blocked Users, Privacy, What I Want, and Personal Preferences
  static Future<List<dynamic>> getBlockedUsers(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['blockedUsers'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching blocked users',
      fallbackValue: [],
    );
  }

  static Future<void> setBlockedUsers(
      String collectionName, String userId, List<dynamic> users) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('blockedUsers', users));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting blocked users',
    );
  }

  static Future<List<dynamic>> getBlockedUserIDs(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['blockedUserIDs'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching blocked user IDs',
      fallbackValue: [],
    );
  }

  static Future<void> setBlockedUserIDs(
      String collectionName, String userId, List<dynamic> ids) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('blockedUserIDs', ids));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting blocked user IDs',
    );
  }

  static Future<void> addBlockedUserId(
      String collectionName, String userId, String blockedUserId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('blockedUserIDs', blockedUserId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding blocked user ID',
    );
  }

  static Future<void> removeBlockedUserId(
      String collectionName, String userId, String blockedUserId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('blockedUserIDs', blockedUserId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing blocked user ID',
    );
  }

  static Future<void> addBlockedUser(String collectionName, String userId,
      Map<String, dynamic> blockedUser) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('blockedUsers', blockedUser));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding blocked user',
    );
  }

  static Future<void> removeBlockedUser(String collectionName, String userId,
      Map<String, dynamic> blockedUser) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.pull('blockedUsers', blockedUser));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing blocked user',
    );
  }

  static Future<bool> getPrivacyShowDistance(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        bool? privacy = user?['privacyShowDistance'] as bool?;
        return privacy != null ? !privacy : true;
      },
      errorMessage: 'Error fetching privacy show distance',
      fallbackValue: true,
    );
  }

  static Future<void> setPrivacyShowDistance(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('privacyShowDistance', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting privacy show distance',
    );
  }

  static Future<bool> getPrivacyShowStatusOnline(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        bool? privacy = user?['privacyShowOnlineStatus'] as bool?;
        return privacy != null ? !privacy : true;
      },
      errorMessage: 'Error fetching privacy show online status',
      fallbackValue: true,
    );
  }

  static Future<void> setPrivacyShowStatusOnline(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('privacyShowOnlineStatus', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting privacy show online status',
    );
  }

  static Future<String> getWhatIWant(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? what = user?['profile_honestly_want'] as String?;
        return what ?? "";
      },
      errorMessage: 'Error fetching what I want',
      fallbackValue: "",
    );
  }

  static Future<void> setWhatIWant(
      String collectionName, String userId, String whatIWant) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_honestly_want', whatIWant));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting what I want',
    );
  }

  static Future<String> getLanguage(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_language'] as String? ?? "";
      },
      errorMessage: 'Error fetching language',
      fallbackValue: "",
    );
  }

  static Future<void> setLanguage(
      String collectionName, String userId, String language) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_language', language));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting language',
    );
  }

  static Future<String> getDrinking(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_drinking'] as String? ?? "";
      },
      errorMessage: 'Error fetching drinking',
      fallbackValue: "",
    );
  }

  static Future<void> setDrinking(
      String collectionName, String userId, String drinking) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_drinking', drinking));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting drinking',
    );
  }

  static Future<String> getSmoking(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_smoking'] as String? ?? "";
      },
      errorMessage: 'Error fetching smoking',
      fallbackValue: "",
    );
  }

  static Future<void> setSmoking(
      String collectionName, String userId, String smoking) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_smoking', smoking));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting smoking',
    );
  }

  static Future<String> getKids(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_kids'] as String? ?? "";
      },
      errorMessage: 'Error fetching kids',
      fallbackValue: "",
    );
  }

  static Future<void> setKids(
      String collectionName, String userId, String kids) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('profile_kids', kids));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting kids',
    );
  }

  static Future<String> getLiving(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_living'] as String? ?? "";
      },
      errorMessage: 'Error fetching living',
      fallbackValue: "",
    );
  }

  static Future<void> setLiving(
      String collectionName, String userId, String living) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('profile_living', living));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting living',
    );
  }

  // MongoDBUtils for Physical and Lifestyle Preferences
  static Future<String> getBodyType(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? bodyType = user?['profile_body_type'] as String?;
        return (bodyType != null && bodyType.isNotEmpty) ? bodyType : "";
      },
      errorMessage: 'Error fetching body type',
      fallbackValue: "",
    );
  }

  static Future<void> setBodyType(
      String collectionName, String userId, String bodyType) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_body_type', bodyType));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting body type',
    );
  }

  static Future<int> getHeight(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        int? height = user?['profile_body_height'] as int?;
        return height ?? 91;
      },
      errorMessage: 'Error fetching height',
      fallbackValue: 91,
    );
  }

  static Future<void> setHeight(
      String collectionName, String userId, int height) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_body_height', height));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting height',
    );
  }

  static Future<String> getSexuality(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? sexuality = user?['profile_sexuality'] as String?;
        return sexuality ?? "";
      },
      errorMessage: 'Error fetching sexuality',
      fallbackValue: "",
    );
  }

  static Future<void> setSexuality(
      String collectionName, String userId, String sexuality) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_sexuality', sexuality));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting sexuality',
    );
  }

  static Future<String> getRelationship(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? relationship = user?['profile_relationship'] as String?;
        return relationship ?? "";
      },
      errorMessage: 'Error fetching relationship',
      fallbackValue: "",
    );
  }

  static Future<void> setRelationship(
      String collectionName, String userId, String relationship) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_relationship', relationship));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting relationship',
    );
  }

  static Future<String?> getSecondaryPassword(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['secondary_password'] as String?;
      },
      errorMessage: 'Error fetching secondary password',
      fallbackValue: null,
    );
  }

  static Future<void> setSecondaryPassword(
      String collectionName, String userId, String secondaryPassword) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('secondary_password', secondaryPassword));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting secondary password',
    );
  }

  static Future<List<dynamic>> getSexualOrientations(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        List<dynamic>? orientations =
            user?['profile_sexual_orientations'] as List<dynamic>?;
        return (orientations != null && orientations.isNotEmpty)
            ? orientations
            : ["ME"];
      },
      errorMessage: 'Error fetching sexual orientations',
      fallbackValue: ["ME"],
    );
  }

  static Future<void> setSexualOrientations(
      String collectionName, String userId, List<String> orientations) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_sexual_orientations', orientations));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting sexual orientations',
    );
  }

  static Future<List<dynamic>> getPassions(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        List<dynamic>? passions = user?['profile_passions'] as List<dynamic>?;
        return (passions != null && passions.isNotEmpty) ? passions : ["none"];
      },
      errorMessage: 'Error fetching passions',
      fallbackValue: ["none"],
    );
  }

  static Future<void> setPassions(
      String collectionName, String userId, List<String> passions) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_passions', passions));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting passions',
    );
  }

  static Future<bool> getShowSexualOrientation(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['show_sex_orientation'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show sexual orientation',
      fallbackValue: false,
    );
  }

  static Future<void> setShowSexualOrientation(
      String collectionName, String userId, bool show) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('show_sex_orientation', show));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show sexual orientation',
    );
  }

  static Future<bool> getShowGenderInProfile(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_show_gender'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show gender in profile',
      fallbackValue: false,
    );
  }

  static Future<void> setShowGenderInProfile(
      String collectionName, String userId, bool show) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_show_gender', show));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show gender in profile',
    );
  }

  static Future<bool> getDistanceInMiles(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['profile_distance_miles'] as bool? ?? false;
      },
      errorMessage: 'Error fetching distance in miles',
      fallbackValue: false,
    );
  }

  static Future<void> setDistanceInMiles(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('profile_distance_miles', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting distance in miles',
    );
  }

  static Future<bool> getHideMyLocation(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['hideLocation'] as bool? ?? false;
      },
      errorMessage: 'Error fetching hide my location',
      fallbackValue: false,
    );
  }

  static Future<void> setHideMyLocation(
      String collectionName, String userId, bool hide) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('hideLocation', hide));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting hide my location',
    );
  }

  /// Sets the GeoPoint for the specified user.
  static Future<void> setGeoPoint(
    String collectionName,
    String userId,
    double latitude,
    double longitude,
  ) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify
              .set('geopoint', {'latitude': latitude, 'longitude': longitude}),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting geopoint',
    );
  }

  static Future<Map<String, dynamic>?> getGeoPoint(
    String collectionName,
    String userId,
  ) async {
    return MongoDBErrorHandler.handleMongoDBOperation<Map<String, dynamic>?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user['geopoint'] != null) {
          // Return the geopoint as a map with latitude and longitude
          return {
            'latitude': user['geopoint']['latitude'],
            'longitude': user['geopoint']['longitude']
          };
        }
        return null;
      },
      errorMessage: 'Error fetching geopoint',
      fallbackValue: null,
    );
  }

  // MongoDBUtils for Physical & Lifestyle Preferences
  static Future<int> getAge(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['age'] as int? ?? 0;
      },
      errorMessage: 'Error fetching age',
      fallbackValue: 0,
    );
  }

  static Future<void> setAge(
      String collectionName, String userId, int age) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('age', age));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting age',
    );
  }

  static Future<int> getDiamonds(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['diamonds'] as int? ?? 0;
      },
      errorMessage: 'Error fetching diamonds',
      fallbackValue: 0,
    );
  }

  static Future<void> setDiamonds(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.inc('diamonds', diamonds));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding diamonds',
    );
  }

  static Future<void> removeDiamonds(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.inc('diamonds', -diamonds));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing diamonds',
    );
  }

  static Future<int> getDiamondsTotal(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['diamondsTotal'] as int? ?? 0;
      },
      errorMessage: 'Error fetching total diamonds',
      fallbackValue: 0,
    );
  }

  static Future<void> setDiamondsTotal(
      String collectionName, String userId, int diamondsTotal) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.inc('diamondsTotal', diamondsTotal));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding total diamonds',
    );
  }

  static Future<int> getPayouts(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['payouts'] as int? ?? 0;
      },
      errorMessage: 'Error fetching payouts',
      fallbackValue: 0,
    );
  }

  static Future<void> addPayouts(
      String collectionName, String userId, int incrementPayout) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.inc('payouts', incrementPayout));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding payouts',
    );
  }

  static Future<List<dynamic>> getFollowing(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['following'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching following',
      fallbackValue: [],
    );
  }

  static Future<void> setFollowing(
      String collectionName, String userId, String authorId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('following', authorId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding following',
    );
  }

  static Future<void> removeFollowing(
      String collectionName, String userId, String authorId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.pull('following', authorId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing following',
    );
  }

  static Future<List<dynamic>> getFollowers(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['followers'] as List<dynamic>? ?? [];
      },
      errorMessage: 'Error fetching followers',
      fallbackValue: [],
    );
  }

  static Future<void> setFollowers(
      String collectionName, String userId, String authorId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.addToSet('followers', authorId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding follower',
    );
  }

  static Future<void> removeFollowers(
      String collectionName, String userId, String authorId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.pull('followers', authorId));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing follower',
    );
  }

  static Future<bool> getReceiveChatRequest(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['receiveChatRequest'] as bool? ?? false;
      },
      errorMessage: 'Error fetching receive chat request',
      fallbackValue: false,
    );
  }

  static Future<void> setReceiveChatRequest(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('receiveChatRequest', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting receive chat request',
    );
  }

  static Future<bool> getShowUpInSearch(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['showUpInSearch'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show up in search',
      fallbackValue: false,
    );
  }

  static Future<void> setShowUpInSearch(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('showUpInSearch', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show up in search',
    );
  }

  // MongoDBUtils for VIP & Privacy Settings (Repository Code)
  static Future<bool> getShowVipLevel(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['showVipLevel'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show VIP level',
      fallbackValue: false,
    );
  }

  static Future<void> setShowVipLevel(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('showVipLevel', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show VIP level',
    );
  }

  static Future<bool> getShowLocation(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['showLocation'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show location',
      fallbackValue: false,
    );
  }

  static Future<void> setShowLocation(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('showLocation', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show location',
    );
  }

  static Future<bool> getShowLastTimeSeen(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['showLastTimeSeen'] as bool? ?? false;
      },
      errorMessage: 'Error fetching show last time seen',
      fallbackValue: false,
    );
  }

  static Future<void> setShowLastTimeSeen(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('showLastTimeSeen', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show last time seen',
    );
  }

  static Future<bool> getInvisibleMode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['invisibleMode'] as bool? ?? false;
      },
      errorMessage: 'Error fetching invisible mode',
      fallbackValue: false,
    );
  }

  static Future<void> setInvisibleMode(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('invisibleMode', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting invisible mode',
    );
  }

  static Future<String> getShowMyPostsTo(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        String? value = user?['showMyPostsTo'] as String?;
        return (value != null && value.isNotEmpty) ? value : "ANY_USER";
      },
      errorMessage: 'Error fetching show my posts to',
      fallbackValue: "ANY_USER",
    );
  }

  static Future<void> setShowMyPostsTo(
      String collectionName, String userId, String value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('showMyPostsTo', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting show my posts to',
    );
  }

  static Future<bool> getSendReadReceipts(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['sendReadReceipts'] as bool? ?? false;
      },
      errorMessage: 'Error fetching send read receipts',
      fallbackValue: false,
    );
  }

  static Future<void> setSendReadReceipts(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('sendReadReceipts', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting send read receipts',
    );
  }

  static Future<bool> getEnableOneClickGifting(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['enableOneClickGifting'] as bool? ?? false;
      },
      errorMessage: 'Error fetching one click gifting status',
      fallbackValue: false,
    );
  }

  static Future<void> setEnableOneClickGifting(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('enableOneClickGifting', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting one click gifting status',
    );
  }

  static Future<bool> getDenyBeInvitedToLiveParty(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['denyBeInvitedToLiveParty'] as bool? ?? false;
      },
      errorMessage: 'Error fetching deny invite to live party status',
      fallbackValue: false,
    );
  }

  static Future<void> setDenyBeInvitedToLiveParty(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('denyBeInvitedToLiveParty', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting deny invite to live party status',
    );
  }

  static Future<bool> getDenyPictureInPictureMode(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['denyPictureInPictureMode'] as bool? ?? false;
      },
      errorMessage: 'Error fetching deny picture in picture mode status',
      fallbackValue: false,
    );
  }

  static Future<void> setDenyPictureInPictureMode(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('denyPictureInPictureMode', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting deny picture in picture mode status',
    );
  }

  static Future<bool> getAllowViewersToPremiumStream(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['allowViewersToPremiumStream'] as bool? ?? false;
      },
      errorMessage: 'Error fetching allow viewers to premium stream status',
      fallbackValue: false,
    );
  }

  static Future<void> setAllowViewersToPremiumStream(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('allowViewersToPremiumStream', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting allow viewers to premium stream status',
    );
  }

  static Future<bool> getLiveNotification(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['liveNotification'] as bool? ?? true;
      },
      errorMessage: 'Error fetching live notification',
      fallbackValue: true,
    );
  }

  static Future<void> setLiveNotification(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('liveNotification', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting live notification',
    );
  }

  static Future<bool> getMuteIncomingCalls(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['muteIncomingCalls'] as bool? ?? true;
      },
      errorMessage: 'Error fetching mute incoming calls',
      fallbackValue: true,
    );
  }

  static Future<void> setMuteIncomingCalls(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('muteIncomingCalls', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting mute incoming calls',
    );
  }

  static Future<bool> getNotificationSounds(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['notificationSounds'] as bool? ?? true;
      },
      errorMessage: 'Error fetching notification sounds',
      fallbackValue: true,
    );
  }

  static Future<void> setNotificationSounds(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(where.eq('objectId', userId),
            modify.set('notificationSounds', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting notification sounds',
    );
  }

  static Future<bool> getInAppSound(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['inAppSound'] as bool? ?? true;
      },
      errorMessage: 'Error fetching in-app sound',
      fallbackValue: true,
    );
  }

  static Future<void> setInAppSound(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('inAppSound', value));
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting in-app sound',
    );
  }

  static Future<bool> getInAppVibration(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user?['inAppVibration'] as bool? ?? true;
      },
      errorMessage: 'Error fetching in-app vibration',
      fallbackValue: true,
    );
  }

  static Future<void> setInAppVibration(
      String collectionName, String userId, bool value) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.update(
            where.eq('objectId', userId), modify.set('inAppVibration', value));
      },
      errorMessage: 'Error setting in-app vibration',
    );
  }

  // Game notification methods
  static Future<void> setGameNotification(
      String collectionName, String userId, bool gameNotification) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("gameNotification", gameNotification),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting game notification preference',
    );
  }

  static Future<bool> getGameNotification(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user.containsKey("gameNotification")) {
          return user["gameNotification"] as bool;
        } else {
          return true;
        }
      },
      errorMessage: 'Error getting game notification preference',
    );
  }

  // Reported Posts methods
  static Future<List<dynamic>> getReportedPostIDs(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user.containsKey("reportedPostsID")) {
          return user["reportedPostsID"] as List<dynamic>;
        } else {
          return []; // Default empty list
        }
      },
      errorMessage: 'Error getting reported post IDs',
    );
  }

  static Future<void> addReportedPostID(
      String collectionName, String userId, dynamic postID) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$addToSet': {"reportedPostsID": postID}
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding reported post ID',
    );
  }

  static Future<void> addMultipleReportedPostIDs(
      String collectionName, String userId, List<dynamic> postIDs) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$addToSet': {
              "reportedPostsID": {r'$each': postIDs}
            }
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding multiple reported post IDs',
    );
  }

  // Reported Post Reason methods
  static Future<String?> getReportedPostReason(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["reportedPostReason"] as String? : null;
      },
      errorMessage: 'Error getting reported post reason',
    );
  }

  static Future<void> setReportedPostReason(
      String collectionName, String userId, String reason) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("reportedPostReason", reason),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting reported post reason',
    );
  }

  // Payment methods
  static Future<String?> getPayoneerEmail(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["payoneerEmail"] as String? : null;
      },
      errorMessage: 'Error getting Payoneer email',
    );
  }

  static Future<void> setPayoneerEmail(
      String collectionName, String userId, String payEmail) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("payoneerEmail", payEmail),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting Payoneer email',
    );
  }

  static Future<String?> getPayPalEmail(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["paypalEmail"] as String? : null;
      },
      errorMessage: 'Error getting PayPal email',
    );
  }

  static Future<void> setPayPalEmail(
      String collectionName, String userId, String payPalEmail) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("paypalEmail", payPalEmail),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting PayPal email',
    );
  }

  // Bank methods
  static Future<String?> getIban(String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["Iban"] as String? : null;
      },
      errorMessage: 'Error getting IBAN',
    );
  }

  static Future<void> setIban(
      String collectionName, String userId, String iban) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("Iban", iban),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting IBAN',
    );
  }

  static Future<String?> getAccountName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["account_name"] as String? : null;
      },
      errorMessage: 'Error getting account name',
    );
  }

  static Future<void> setAccountName(
      String collectionName, String userId, String name) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("account_name", name),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting account name',
    );
  }

  static Future<String?> getBankName(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["bank_name"] as String? : null;
      },
      errorMessage: 'Error getting bank name',
    );
  }

  static Future<void> setBankName(
      String collectionName, String userId, String bank) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("bank_name", bank),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting bank name',
    );
  }

  // Installation methods
  static Future<dynamic> getInstallation(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<dynamic>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["installation"] : null;
      },
      errorMessage: 'Error getting installation',
    );
  }

  static Future<void> setInstallation(
      String collectionName, String userId, dynamic installation) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("installation", installation),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting installation',
    );
  }

  // Invited users methods
  static Future<List<dynamic>> getInvitedUsers(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<List<dynamic>>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null &&
            user.containsKey("invitedUsers") &&
            (user["invitedUsers"] as List).isNotEmpty) {
          return user["invitedUsers"] as List<dynamic>;
        } else {
          return []; // Default empty list
        }
      },
      errorMessage: 'Error getting invited users',
    );
  }

  static Future<bool?> getInvitedByAnswer(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<bool?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["inviteQuestion"] as bool? : null;
      },
      errorMessage: 'Error getting invited answer status',
    );
  }

  static Future<void> setInvitedByAnswer(
      String collectionName, String userId, bool invitedAnswer) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("inviteQuestion", invitedAnswer),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting invited answer status',
    );
  }

  static Future<String?> getInvitedByUser(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["invitedByUser"] as String? : null;
      },
      errorMessage: 'Error getting invited by user',
    );
  }

  static Future<void> setInvitedByUser(
      String collectionName, String userId, String invitedBy) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("invitedByUser", invitedBy),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting invited by user',
    );
  }

  // Premium methods
  static Future<String?> getPremiumType(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<String?>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        return user != null ? user["premiumType"] as String? : null;
      },
      errorMessage: 'Error getting premium type',
    );
  }

  static Future<void> setPremiumType(
      String collectionName, String userId, String premiumType) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          modify.set("premiumType", premiumType),
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error setting premium type',
    );
  }

  // Diamonds agency methods
  static Future<int> getDiamondsAgency(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user.containsKey("diamondsAgencyTotal")) {
          return user["diamondsAgencyTotal"] as int;
        } else {
          return 0; // Default value
        }
      },
      errorMessage: 'Error getting diamonds agency',
    );
  }

  static Future<void> addDiamondsAgency(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$inc': {"diamondsAgencyTotal": diamonds}
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding diamonds agency',
    );
  }

  static Future<void> removeDiamondsAgency(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$inc': {"diamondsAgencyTotal": -diamonds}
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing diamonds agency',
    );
  }

  static Future<int> getDiamondsAgencyTotal(
      String collectionName, String userId) async {
    return MongoDBErrorHandler.handleMongoDBOperation<int>(
      operation: () async {
        final collection = getCollection(collectionName);
        final user = await collection.findOne(where.eq('objectId', userId));
        if (user != null && user.containsKey("diamondsAgencyTotal")) {
          return user["diamondsAgencyTotal"] as int;
        } else {
          return 0; // Default value
        }
      },
      errorMessage: 'Error getting diamonds agency total',
    );
  }

  static Future<void> addDiamondsAgencyTotal(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$inc': {"diamondsAgencyTotal": diamonds}
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error adding diamonds agency total',
    );
  }

  static Future<void> removeDiamondsAgencyTotal(
      String collectionName, String userId, int diamonds) async {
    return MongoDBErrorHandler.handleMongoDBOperation<void>(
      operation: () async {
        final collection = getCollection(collectionName);
        await collection.updateOne(
          where.eq('objectId', userId),
          {
            r'$inc': {"diamondsAgencyTotal": -diamonds}
          },
        );
        await _saveUser(collectionName: collectionName, userId: userId);
      },
      errorMessage: 'Error removing diamonds agency total',
    );
  }
}
