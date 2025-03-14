// Getter for reported reply IDs from MongoDB
Future<List<String>> getReportedReplyID(String collectionName) async {
  return await MongoDBUtils.getReportedReplyID(collectionName, objectId);
}

Future<List<String>> getReportedCommentID(String collectionName) async {
  return await MongoDBUtils.getReportedCommentID(collectionName, objectId);
}

// MVP Member
Future<DateTime?> getMVPMember(String collectionName) async {
  return await MongoDBUtils.getMVPMember(collectionName, objectId);
}

// canUseAvatarFrame
Future<bool> getCanUseAvatarFrame(String collectionName) async {
  return await MongoDBUtils.getCanUseAvatarFrame(collectionName, objectId);
}

// canUsePartyTheme
Future<bool> getCanUsePartyTheme(String collectionName) async {
  return await MongoDBUtils.getCanUsePartyTheme(collectionName, objectId);
}

// canUseEntranceEffect
Future<bool> getCanUseEntranceEffect(String collectionName) async {
  return await MongoDBUtils.getCanUseEntranceEffect(collectionName, objectId);
}

Future<Map<String, String>?> getLiveCover(String collectionName) async {
  return await MongoDBUtils.getLiveCover(collectionName, objectId);
}

Future<Map<String, String>?> getEntranceEffect(String collectionName) async {
  return await MongoDBUtils.getEntranceEffect(collectionName, objectId);
}

Future<String?> getEntranceEffectId(String collectionName) async {
  return await MongoDBUtils.getEntranceEffectId(collectionName, objectId);
}

// Party Theme Methods
Future<Map<String, String>?> getPartyTheme(String collectionName) async {
  return await MongoDBUtils.getPartyTheme(collectionName, objectId);
}

Future<String?> getPartyThemeId(String collectionName) async {
  return await MongoDBUtils.getPartyThemeId(collectionName, objectId);
}

// Avatar Frame Methods
Future<Map<String, String>?> getAvatarFrame(String collectionName) async {
  return await MongoDBUtils.getAvatarFrame(collectionName, objectId);
}

Future<String?> getAvatarFrameId(String collectionName) async {
  return await MongoDBUtils.getAvatarFrameId(collectionName, objectId);
}

// Obtained Items Methods
Future<List<String>> getMyObtainedItems(String collectionName) async {
  return await MongoDBUtils.getMyObtainedItems(collectionName, objectId);
}

// Fan Club Methods
Future<String?> getMyFanClubId(String collectionName) async {
  return await MongoDBUtils.getMyFanClubId(collectionName, objectId);
}

Future<String?> getMyFanClubName(String collectionName) async {
  return await MongoDBUtils.getMyFanClubName(collectionName, objectId);
}

Future<List<String>> getMyFanClubMembers(String collectionName) async {
  return await MongoDBUtils.getMyFanClubMembers(collectionName, objectId);
}

Future<List<String>> getJoinedFanClubIds(String collectionName) async {
  return await MongoDBUtils.getJoinedFanClubIds(collectionName, objectId);
}

// Face Authentication
Future<bool> getIsFaceAuthenticated(String collectionName) async {
  return await MongoDBUtils.getIsFaceAuthenticated(collectionName, objectId);
}

// Payment Methods
Future<String?> getSelectedPaymentMethod(String collectionName) async {
  return await MongoDBUtils.getSelectedPaymentMethod(collectionName, objectId);
}

Future<String?> getUsdtContactAddress(String collectionName) async {
  return await MongoDBUtils.getUsdtContactAddress(collectionName, objectId);
}

Future<String?> getWalletAddress(String collectionName) async {
  return await MongoDBUtils.getWalletAddress(collectionName, objectId);
}

Future<String?> getPayoneerName(String collectionName) async {
  return await MongoDBUtils.getPayoneerName(collectionName, objectId);
}

Future<String?> getPayPalName(String collectionName) async {
  return await MongoDBUtils.getPayPalName(collectionName, objectId);
}

// Virtual Currency (PCoins)
Future<int> getPCoins(String collectionName) async {
  return await MongoDBUtils.getPCoins(collectionName, objectId);
}

// Guardian of King
Future<bool> isGuardianOfKing(String collectionName) async {
  return await MongoDBUtils.isGuardianOfKing(collectionName, objectId);
}

Future<DateTime?> getGuardianOfKing(String collectionName) async {
  return await MongoDBUtils.getGuardianOfKing(collectionName, objectId);
}

// Guardian of Gold
Future<bool> isGuardianOfGold(String collectionName) async {
  return await MongoDBUtils.isGuardianOfGold(collectionName, objectId);
}

Future<DateTime?> getGuardianOfGold(String collectionName) async {
  return await MongoDBUtils.getGuardianOfGold(collectionName, objectId);
}

// Guardian of Silver
Future<bool> isGuardianOfSilver(String collectionName) async {
  return await MongoDBUtils.isGuardianOfSilver(collectionName, objectId);
}

Future<DateTime?> getGuardianOfSilver(String collectionName) async {
  return await MongoDBUtils.getGuardianOfSilver(collectionName, objectId);
}

// People Guarding Me
Future<List<String>> getPeopleGuardingMe(String collectionName) async {
  return await MongoDBUtils.getPeopleGuardingMe(collectionName, objectId);
}

// My Guardians
Future<List<String>> getMyGuardians(String collectionName) async {
  return await MongoDBUtils.getMyGuardians(collectionName, objectId);
}

// Vibrate
Future<bool> getVibrate(String collectionName) async {
  return await MongoDBUtils.getVibrate(collectionName, objectId);
}

// Sound
Future<bool> getSound(String collectionName) async {
  return await MongoDBUtils.getSound(collectionName, objectId);
}

Future<bool> getAcceptCalls(String collectionName) async {
  return await MongoDBUtils.getAcceptCalls(collectionName, objectId);
}

Future<bool> getMessageNotificationSwitch(String collectionName) async {
  return await MongoDBUtils.getMessageNotificationSwitch(
      collectionName, objectId);
}

Future<bool> getLiveOpeningAlert(String collectionName) async {
  return await MongoDBUtils.getLiveOpeningAlert(collectionName, objectId);
}

Future<bool> isDiamondVip(String collectionName) async {
  return await MongoDBUtils.isDiamondVip(collectionName, objectId);
}

Future<DateTime?> getDiamondVip(String collectionName) async {
  return await MongoDBUtils.getDiamondVip(collectionName, objectId);
}

Future<bool> isSuperVip(String collectionName) async {
  return await MongoDBUtils.isSuperVip(collectionName, objectId);
}

Future<DateTime?> getSuperVip(String collectionName) async {
  return await MongoDBUtils.getSuperVip(collectionName, objectId);
}

Future<bool> getInvisibleVisitor(String collectionName) async {
  return await MongoDBUtils.getInvisibleVisitor(collectionName, objectId);
}

Future<bool> getMysteriousMan(String collectionName) async {
  return await MongoDBUtils.getMysteriousMan(collectionName, objectId);
}

Future<bool> getMysteryMan(String collectionName) async {
  return await MongoDBUtils.getMysteryMan(collectionName, objectId);
}

Future<String> getAppLanguage(String collectionName) async {
  return await MongoDBUtils.getAppLanguage(collectionName, objectId);
}

Future<List<String>> getCloseFriends(String collectionName) async {
  return await MongoDBUtils.getCloseFriends(collectionName, objectId);
}

Future<List<String>> getVisitors(String collectionName) async {
  return await MongoDBUtils.getVisitors(collectionName, objectId);
}

Future<int> getGiftsAmount(String collectionName) async {
  return await MongoDBUtils.getGiftsAmount(collectionName, objectId);
}

// Post IDs
Future<List<dynamic>> getPostIdList(String collectionName) async {
  return await MongoDBUtils.getPostIdList(collectionName, objectId);
}

// Black List
Future<List<dynamic>> getIdFromBlackList(String collectionName) async {
  return await MongoDBUtils.getIdFromBlackList(collectionName, objectId);
}

// User State In App
Future<String> getUserStateInApp(String collectionName) async {
  return await MongoDBUtils.getUserStateInApp(collectionName, objectId);
}

// Chat With Users
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

// User Role
Future<String?> getUserRole(String collectionName) async {
  return await MongoDBUtils.getUserRole(collectionName, objectId);
}

// Username
Future<String?> getUsername(String collectionName) async {
  return await MongoDBUtils.getUsername(collectionName, objectId);
}

// Email
Future<String?> getEmail(String collectionName) async {
  return await MongoDBUtils.getEmail(collectionName, objectId);
}

// Email Public
Future<String?> getEmailPublic(String collectionName) async {
  return await MongoDBUtils.getEmailPublic(collectionName, objectId);
}

// Full Name
Future<String?> getFullName(String collectionName) async {
  return await MongoDBUtils.getFullName(collectionName, objectId);
}

// First Name
Future<String?> getFirstName(String collectionName) async {
  return await MongoDBUtils.getFirstName(collectionName, objectId);
}

// Last Name
Future<String?> getLastName(String collectionName) async {
  return await MongoDBUtils.getLastName(collectionName, objectId);
}

// Gender
Future<String> getGender(String collectionName) async {
  return await MongoDBUtils.getGender(collectionName, objectId);
}

// Gender Preference
Future<String> getGenderPref(String collectionName) async {
  return await MongoDBUtils.getGenderPref(collectionName, objectId);
}

// Preference Distance
Future<int> getPrefDistance(String collectionName) async {
  return await MongoDBUtils.getPrefDistance(collectionName, objectId);
}

// Bio
Future<String> getBio(String collectionName) async {
  return await MongoDBUtils.getBio(collectionName, objectId);
}

// Avatar
Future<Map<String, dynamic>?> getAvatar(String collectionName) async {
  return await MongoDBUtils.getAvatar(collectionName, objectId);
}

// Images List
Future<List<Map<String, String>>> getImagesList(String collectionName) async {
  return await MongoDBUtils.getImagesList(collectionName, objectId);
}

// Cover
Future<Map<String, dynamic>?> getCover(String collectionName) async {
  return await MongoDBUtils.getCover(collectionName, objectId);
}

// Birthday
Future<DateTime> getBirthday(String collectionName) async {
  return await MongoDBUtils.getBirthday(collectionName, objectId);
}

// Last Online
Future<DateTime?> getLastOnline(String collectionName) async {
  return await MongoDBUtils.getLastOnline(collectionName, objectId);
}

// Email Verified
Future<bool> getEmailVerified(String collectionName) async {
  return await MongoDBUtils.getEmailVerified(collectionName, objectId);
}

// Activation Status
Future<bool> getActivationStatus(String collectionName) async {
  return await MongoDBUtils.getActivationStatus(collectionName, objectId);
}

// Account Deleted
Future<bool> getAccountDeleted(String collectionName) async {
  return await MongoDBUtils.getAccountDeleted(collectionName, objectId);
}

// Facebook ID
Future<String> getFacebookId(String collectionName) async {
  return await MongoDBUtils.getFacebookId(collectionName, objectId);
}

// Google ID
Future<String> getGoogleId(String collectionName) async {
  return await MongoDBUtils.getGoogleId(collectionName, objectId);
}

// Admin, Deletion & Suspension
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

// Account Deleted Reason
Future<String?> getAccountDeletedReason(String collectionName) async {
  return await MongoDBUtils.getAccountDeletedReason(collectionName, objectId);
}

// Apple ID
Future<String?> getAppleId(String collectionName) async {
  return await MongoDBUtils.getAppleId(collectionName, objectId);
}

// Instagram ID
Future<String?> getInstagramId(String collectionName) async {
  return await MongoDBUtils.getInstagramId(collectionName, objectId);
}

// Password & GeoPoint
Future<bool> getHasPassword(String collectionName) async {
  return await MongoDBUtils.getHasPassword(collectionName, objectId);
}

Future<bool> getHasGeoPoint(String collectionName) async {
  return await MongoDBUtils.getHasGeoPoint(collectionName, objectId);
}

// Location
Future<bool> getLocationTypeNearBy(String collectionName) async {
  return await MongoDBUtils.getLocationTypeNearBy(collectionName, objectId);
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

Future<String> getCity(String collectionName) async {
  return await MongoDBUtils.getCity(collectionName, objectId);
}

// Popularity & Age Preferences
Future<int> getPopularity(String collectionName) async {
  return await MongoDBUtils.getPopularity(collectionName, objectId);
}

Future<int> getPrefMinAge(String collectionName) async {
  return await MongoDBUtils.getPrefMinAge(collectionName, objectId);
}

Future<int> getPrefMaxAge(String collectionName) async {
  return await MongoDBUtils.getPrefMaxAge(collectionName, objectId);
}

// Credits & Platform Speaker
Future<int> getCredits(String collectionName) async {
  return await MongoDBUtils.getCredits(collectionName, objectId);
}

Future<int> getCreditsSent(String collectionName) async {
  return await MongoDBUtils.getCreditsSent(collectionName, objectId);
}

Future<int> getPlatformSpeakerNumber(String collectionName) async {
  return await MongoDBUtils.getPlatformSpeakerNumber(collectionName, objectId);
}

// Country, Currency & Contact
Future<String> getCountry(String collectionName) async {
  return await MongoDBUtils.getCountry(collectionName, objectId);
}

Future<String> getCountryCode(String collectionName) async {
  return await MongoDBUtils.getCountryCode(collectionName, objectId);
}

Future<String> getCurrencyCode(String collectionName) async {
  return await MongoDBUtils.getCurrencyCode(collectionName, objectId);
}

Future<String> getCurrencySymbol(String collectionName) async {
  return await MongoDBUtils.getCurrencySymbol(collectionName, objectId);
}

Future<String?> getCountryDialCode(String collectionName) async {
  return await MongoDBUtils.getCountryDialCode(collectionName, objectId);
}

Future<String> getPhoneNumber(String collectionName) async {
  return await MongoDBUtils.getPhoneNumber(collectionName, objectId);
}

Future<String> getPhoneNumberFull(String collectionName) async {
  return await MongoDBUtils.getPhoneNumberFull(collectionName, objectId);
}

// Company & Job
Future<String> getCompanyName(String collectionName) async {
  return await MongoDBUtils.getCompanyName(collectionName, objectId);
}

Future<String> getJobTitle(String collectionName) async {
  return await MongoDBUtils.getJobTitle(collectionName, objectId);
}

Future<String> getSchool(String collectionName) async {
  return await MongoDBUtils.getSchool(collectionName, objectId);
}

// About & Mood
Future<String> getAboutYou(String collectionName) async {
  return await MongoDBUtils.getAboutYou(collectionName, objectId);
}

Future<String> getMoodTitle(String collectionName) async {
  return await MongoDBUtils.getMoodTitle(collectionName, objectId);
}

Future<bool> getPhotoVerified(String collectionName) async {
  return await MongoDBUtils.getPhotoVerified(collectionName, objectId);
}

// VIP & Daily Gifts
Future<bool> isNormalVip(String collectionName) async {
  return await MongoDBUtils.isNormalVip(collectionName, objectId);
}

Future<DateTime?> getNormalVip(String collectionName) async {
  return await MongoDBUtils.getNormalVip(collectionName, objectId);
}

Future<DateTime?> getDailyGift(String collectionName) async {
  return await MongoDBUtils.getDailyGift(collectionName, objectId);
}

Future<bool> isDailyGift(String collectionName) async {
  return await MongoDBUtils.isDailyGift(collectionName, objectId);
}

Future<DateTime?> getVipAdsDisabled(String collectionName) async {
  return await MongoDBUtils.getVipAdsDisabled(collectionName, objectId);
}

Future<DateTime?> getVip3xPopular(String collectionName) async {
  return await MongoDBUtils.getVip3xPopular(collectionName, objectId);
}

Future<DateTime?> getVipShowOnline(String collectionName) async {
  return await MongoDBUtils.getVipShowOnline(collectionName, objectId);
}

Future<DateTime?> getVipExtraShows(String collectionName) async {
  return await MongoDBUtils.getVipExtraShows(collectionName, objectId);
}

Future<DateTime?> getVipMoreVisits(String collectionName) async {
  return await MongoDBUtils.getVipMoreVisits(collectionName, objectId);
}

Future<DateTime?> getVipMoveToTop(String collectionName) async {
  return await MongoDBUtils.getVipMoveToTop(collectionName, objectId);
}

Future<bool> getVipInvisibleMode(String collectionName) async {
  return await MongoDBUtils.getVipInvisibleMode(collectionName, objectId);
}

Future<bool> getVipIsInvisible(String collectionName) async {
  return await MongoDBUtils.getVipIsInvisible(collectionName, objectId);
}

// Name Change & Account Hidden
Future<String> getAppLanguage(String collectionName) async {
  return await MongoDBUtils.getAppLanguage(collectionName, objectId);
}

Future<List<String>> getCloseFriends(String collectionName) async {
  return await MongoDBUtils.getCloseFriends(collectionName, objectId);
}

Future<List<String>> getVisitors(String collectionName) async {
  return await MongoDBUtils.getVisitors(collectionName, objectId);
}

Future<int> getGiftsAmount(String collectionName) async {
  return await MongoDBUtils.getGiftsAmount(collectionName, objectId);
}

// Post IDs
Future<List<dynamic>> getPostIdList(String collectionName) async {
  return await MongoDBUtils.getPostIdList(collectionName, objectId);
}

// Black List
Future<List<dynamic>> getIdFromBlackList(String collectionName) async {
  return await MongoDBUtils.getIdFromBlackList(collectionName, objectId);
}

// User State In App
Future<String> getUserStateInApp(String collectionName) async {
  return await MongoDBUtils.getUserStateInApp(collectionName, objectId);
}

// Chat With Users
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

// User Role
Future<String?> getUserRole(String collectionName) async {
  return await MongoDBUtils.getUserRole(collectionName, objectId);
}

// Username
Future<String?> getUsername(String collectionName) async {
  return await MongoDBUtils.getUsername(collectionName, objectId);
}

// Email
Future<String?> getEmail(String collectionName) async {
  return await MongoDBUtils.getEmail(collectionName, objectId);
}

// Email Public
Future<String?> getEmailPublic(String collectionName) async {
  return await MongoDBUtils.getEmailPublic(collectionName, objectId);
}

// Full Name
Future<String?> getFullName(String collectionName) async {
  return await MongoDBUtils.getFullName(collectionName, objectId);
}

// First Name
Future<String?> getFirstName(String collectionName) async {
  return await MongoDBUtils.getFirstName(collectionName, objectId);
}

// Last Name
Future<String?> getLastName(String collectionName) async {
  return await MongoDBUtils.getLastName(collectionName, objectId);
}

// Gender & Preferences
Future<String> getGender(String collectionName) async {
  return await MongoDBUtils.getGender(collectionName, objectId);
}

Future<String> getGenderPref(String collectionName) async {
  return await MongoDBUtils.getGenderPref(collectionName, objectId);
}

Future<int> getPrefDistance(String collectionName) async {
  return await MongoDBUtils.getPrefDistance(collectionName, objectId);
}

// Bio
Future<String> getBio(String collectionName) async {
  return await MongoDBUtils.getBio(collectionName, objectId);
}

// Avatar
Future<Map<String, dynamic>?> getAvatar(String collectionName) async {
  return await MongoDBUtils.getAvatar(collectionName, objectId);
}

// Images List
Future<List<Map<String, String>>> getImagesList(String collectionName) async {
  return await MongoDBUtils.getImagesList(collectionName, objectId);
}

// Cover
Future<Map<String, dynamic>?> getCover(String collectionName) async {
  return await MongoDBUtils.getCover(collectionName, objectId);
}

// Birthday
Future<DateTime> getBirthday(String collectionName) async {
  return await MongoDBUtils.getBirthday(collectionName, objectId);
}

// Last Online
Future<DateTime?> getLastOnline(String collectionName) async {
  return await MongoDBUtils.getLastOnline(collectionName, objectId);
}

// Email Verified
Future<bool> getEmailVerified(String collectionName) async {
  return await MongoDBUtils.getEmailVerified(collectionName, objectId);
}

// Activation Status
Future<bool> getActivationStatus(String collectionName) async {
  return await MongoDBUtils.getActivationStatus(collectionName, objectId);
}

// Account Deleted
Future<bool> getAccountDeleted(String collectionName) async {
  return await MongoDBUtils.getAccountDeleted(collectionName, objectId);
}

// Facebook ID
Future<String> getFacebookId(String collectionName) async {
  return await MongoDBUtils.getFacebookId(collectionName, objectId);
}

// Google ID
Future<String> getGoogleId(String collectionName) async {
  return await MongoDBUtils.getGoogleId(collectionName, objectId);
}

// Admin, Deletion & Suspension
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

// Account Deleted Reason
Future<String?> getAccountDeletedReason(String collectionName) async {
  return await MongoDBUtils.getAccountDeletedReason(collectionName, objectId);
}

// Apple ID
Future<String?> getAppleId(String collectionName) async {
  return await MongoDBUtils.getAppleId(collectionName, objectId);
}

// Instagram ID
Future<String?> getInstagramId(String collectionName) async {
  return await MongoDBUtils.getInstagramId(collectionName, objectId);
}

// Additional Payment & Bank Info
Future<String?> getPayoneerEmail(String collectionName) async {
  return await MongoDBUtils.getPayoneerEmail(collectionName, objectId);
}

Future<String?> getPayPalEmail(String collectionName) async {
  return await MongoDBUtils.getPayPalEmail(collectionName, objectId);
}

Future<String?> getIban(String collectionName) async {
  return await MongoDBUtils.getIban(collectionName, objectId);
}

Future<String?> getAccountName(String collectionName) async {
  return await MongoDBUtils.getAccountName(collectionName, objectId);
}

Future<String?> getBankName(String collectionName) async {
  return await MongoDBUtils.getBankName(collectionName, objectId);
}

Future<dynamic> getInstallation(String collectionName) async {
  return await MongoDBUtils.getInstallation(collectionName, objectId);
}

// Invited & Premium
Future<List<dynamic>> getInvitedUsers(String collectionName) async {
  return await MongoDBUtils.getInvitedUsers(collectionName, objectId);
}

Future<bool?> getInvitedByAnswer(String collectionName) async {
  return await MongoDBUtils.getInvitedByAnswer(collectionName, objectId);
}

Future<String?> getInvitedByUser(String collectionName) async {
  return await MongoDBUtils.getInvitedByUser(collectionName, objectId);
}

Future<String?> getPremiumType(String collectionName) async {
  return await MongoDBUtils.getPremiumType(collectionName, objectId);
}

// Diamonds Agency
Future<int> getDiamondsAgency(String collectionName) async {
  return await MongoDBUtils.getDiamondsAgency(collectionName, objectId);
}

Future<int> getDiamondsAgencyTotal(String collectionName) async {
  return await MongoDBUtils.getDiamondsAgencyTotal(collectionName, objectId);
}
