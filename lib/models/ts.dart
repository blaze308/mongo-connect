Future<void> setReportedReplyID(String collectionName, String replyID) async {
  await MongoDBUtils.setReportedReplyID(collectionName, objectId, replyID);
}

Future<void> removeReportedReplyID(
    String collectionName, String replyID) async {
  await MongoDBUtils.removeReportedReplyID(collectionName, objectId, replyID);
}

Future<void> setReportedCommentID(
    String collectionName, String commentID) async {
  await MongoDBUtils.setReportedCommentID(collectionName, objectId, commentID);
}

Future<void> removeReportedCommentID(
    String collectionName, String commentID) async {
  await MongoDBUtils.removeReportedCommentID(
      collectionName, objectId, commentID);
}

// MVP Member
Future<void> setMVPMember(String collectionName, DateTime mvpMember) async {
  await MongoDBUtils.setMVPMember(collectionName, objectId, mvpMember);
}

// canUseAvatarFrame
Future<void> setCanUseAvatarFrame(String collectionName, bool value) async {
  await MongoDBUtils.setCanUseAvatarFrame(collectionName, objectId, value);
}

// canUsePartyTheme
Future<void> setCanUsePartyTheme(String collectionName, bool value) async {
  await MongoDBUtils.setCanUsePartyTheme(collectionName, objectId, value);
}

// canUseEntranceEffect
Future<void> setCanUseEntranceEffect(String collectionName, bool value) async {
  await MongoDBUtils.setCanUseEntranceEffect(collectionName, objectId, value);
}

Future<void> setLiveCover(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setLiveCover(collectionName, objectId,
      name: name, url: url);
}

Future<void> setEntranceEffect(
    String collectionName, Map<String, String> entranceEffect) async {
  await MongoDBUtils.setEntranceEffect(
      collectionName, objectId, entranceEffect);
}

Future<void> setEntranceEffectId(
    String collectionName, String entranceEffectId) async {
  await MongoDBUtils.setEntranceEffectId(
      collectionName, objectId, entranceEffectId);
}

// Party Theme Methods
Future<void> setPartyTheme(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setPartyTheme(collectionName, objectId,
      name: name, url: url);
}

Future<void> setPartyThemeId(String collectionName, String partyThemeId) async {
  await MongoDBUtils.setPartyThemeId(collectionName, objectId, partyThemeId);
}

// Avatar Frame Methods
Future<void> setAvatarFrame(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setAvatarFrame(collectionName, objectId,
      name: name, url: url);
}

Future<void> setAvatarFrameId(
    String collectionName, String avatarFrameId) async {
  await MongoDBUtils.setAvatarFrameId(collectionName, objectId, avatarFrameId);
}

// Obtained Items Methods
Future<void> setMyObtainedItems(String collectionName, String itemId) async {
  await MongoDBUtils.setMyObtainedItems(collectionName, objectId, itemId);
}

Future<void> removeMyObtainedItems(String collectionName, String itemId) async {
  await MongoDBUtils.removeMyObtainedItems(collectionName, objectId, itemId);
}

// Fan Club Methods
Future<void> setMyFanClubId(String collectionName, String fanClubId) async {
  await MongoDBUtils.setMyFanClubId(collectionName, objectId, fanClubId);
}

Future<void> setMyFanClubName(String collectionName, String fanClubName) async {
  await MongoDBUtils.setMyFanClubName(collectionName, objectId, fanClubName);
}

Future<void> setMyFanClubMembers(String collectionName, String memberId) async {
  await MongoDBUtils.setMyFanClubMembers(collectionName, objectId, memberId);
}

Future<void> removeMyFanClubMembers(
    String collectionName, String memberId) async {
  await MongoDBUtils.removeMyFanClubMembers(collectionName, objectId, memberId);
}

Future<void> setJoinedFanClubIds(
    String collectionName, String fanClubId) async {
  await MongoDBUtils.setJoinedFanClubIds(collectionName, objectId, fanClubId);
}

Future<void> removeJoinedFanClubId(
    String collectionName, String fanClubId) async {
  await MongoDBUtils.removeJoinedFanClubId(collectionName, objectId, fanClubId);
}

// Face Authentication
Future<void> setIsFaceAuthenticated(
    String collectionName, bool isAuthenticated) async {
  await MongoDBUtils.setIsFaceAuthenticated(
      collectionName, objectId, isAuthenticated);
}

// Payment Methods
Future<void> setSelectedPaymentMethod(
    String collectionName, String paymentMethod) async {
  await MongoDBUtils.setSelectedPaymentMethod(
      collectionName, objectId, paymentMethod);
}

Future<void> setUsdtContactAddress(
    String collectionName, String usdtContactAddress) async {
  await MongoDBUtils.setUsdtContactAddress(
      collectionName, objectId, usdtContactAddress);
}

Future<void> setWalletAddress(
    String collectionName, String walletAddress) async {
  await MongoDBUtils.setWalletAddress(collectionName, objectId, walletAddress);
}

Future<void> setPayoneerName(String collectionName, String payoneerName) async {
  await MongoDBUtils.setPayoneerName(collectionName, objectId, payoneerName);
}

Future<void> setPayPalName(String collectionName, String payPalName) async {
  await MongoDBUtils.setPayPalName(collectionName, objectId, payPalName);
}

// Virtual Currency (PCoins)
Future<void> setPCoins(String collectionName, int amount) async {
  await MongoDBUtils.setPCoins(collectionName, objectId, amount);
}

Future<void> removePCoins(String collectionName, int amount) async {
  await MongoDBUtils.removePCoins(collectionName, objectId, amount);
}

// Guardian of King
Future<void> setGuardianOfKing(String collectionName, DateTime date) async {
  await MongoDBUtils.setGuardianOfKing(collectionName, objectId, date);
}

// Guardian of Gold
Future<void> setGuardianOfGold(String collectionName, DateTime date) async {
  await MongoDBUtils.setGuardianOfGold(collectionName, objectId, date);
}

// Guardian of Silver
Future<void> setGuardianOfSilver(String collectionName, DateTime date) async {
  await MongoDBUtils.setGuardianOfSilver(collectionName, objectId, date);
}

// People Guarding Me
Future<void> setPeopleGuardingMe(String collectionName, String userID) async {
  await MongoDBUtils.setPeopleGuardingMe(collectionName, objectId, userID);
}

Future<void> removePeopleGuardingMe(
    String collectionName, String userID) async {
  await MongoDBUtils.removePeopleGuardingMe(collectionName, objectId, userID);
}

// My Guardians
Future<void> setMyGuardians(String collectionName, String userID) async {
  await MongoDBUtils.setMyGuardians(collectionName, objectId, userID);
}

Future<void> removeMyGuardians(String collectionName, String userID) async {
  await MongoDBUtils.removeMyGuardians(collectionName, objectId, userID);
}

// Vibrate
Future<void> setVibrate(String collectionName, bool isVibrate) async {
  await MongoDBUtils.setVibrate(collectionName, objectId, isVibrate);
}

// Sound
Future<void> setSound(String collectionName, bool isSound) async {
  await MongoDBUtils.setSound(collectionName, objectId, isSound);
}

Future<void> setAcceptCalls(String collectionName, bool value) async {
  await MongoDBUtils.setAcceptCalls(collectionName, objectId, value);
}

Future<void> setMessageNotificationSwitch(
    String collectionName, bool value) async {
  await MongoDBUtils.setMessageNotificationSwitch(
      collectionName, objectId, value);
}

Future<void> setLiveOpeningAlert(String collectionName, bool value) async {
  await MongoDBUtils.setLiveOpeningAlert(collectionName, objectId, value);
}

// VIP Methods
Future<void> setDiamondVip(String collectionName, DateTime date) async {
  await MongoDBUtils.setDiamondVip(collectionName, objectId, date);
}

Future<void> setSuperVip(String collectionName, DateTime date) async {
  await MongoDBUtils.setSuperVip(collectionName, objectId, date);
}

Future<void> setInvisibleVisitor(String collectionName, bool value) async {
  await MongoDBUtils.setInvisibleVisitor(collectionName, objectId, value);
}

Future<void> setMysteriousMan(String collectionName, bool value) async {
  await MongoDBUtils.setMysteriousMan(collectionName, objectId, value);
}

Future<void> setMysteryMan(String collectionName, bool value) async {
  await MongoDBUtils.setMysteryMan(collectionName, objectId, value);
}

Future<void> setAppLanguage(String collectionName, String language) async {
  await MongoDBUtils.setAppLanguage(collectionName, objectId, language);
}

Future<void> removeAppLanguage(String collectionName, String language) async {
  await MongoDBUtils.removeAppLanguage(collectionName, objectId, language);
}

// Close Friends & Visitors
Future<void> setCloseFriend(String collectionName, String userID) async {
  await MongoDBUtils.setCloseFriend(collectionName, objectId, userID);
}

Future<void> removeCloseFriend(String collectionName, String userID) async {
  await MongoDBUtils.removeCloseFriend(collectionName, objectId, userID);
}

Future<void> setVisitors(String collectionName, String userID) async {
  await MongoDBUtils.setVisitors(collectionName, objectId, userID);
}

Future<void> removeVisitors(String collectionName, String userID) async {
  await MongoDBUtils.removeVisitors(collectionName, objectId, userID);
}

// Gifts
Future<void> setGiftsAmount(String collectionName, int amount) async {
  await MongoDBUtils.setGiftsAmount(collectionName, objectId, amount);
}

// Post IDs
Future<void> setIdsToPostList(String collectionName, List<dynamic> ids) async {
  await MongoDBUtils.setIdsToPostList(collectionName, objectId, ids);
}

Future<void> setIdToPostList(String collectionName, String id) async {
  await MongoDBUtils.setIdToPostList(collectionName, objectId, id);
}

Future<void> removePostId(String collectionName, String id) async {
  await MongoDBUtils.removePostId(collectionName, objectId, id);
}

// Black List
Future<void> setIdsToBlackList(String collectionName, List<dynamic> ids) async {
  await MongoDBUtils.setIdsToBlackList(collectionName, objectId, ids);
}

Future<void> setIdToBlackList(String collectionName, String id) async {
  await MongoDBUtils.setIdToBlackList(collectionName, objectId, id);
}

Future<void> removeIdFromBlackList(String collectionName, String id) async {
  await MongoDBUtils.removeIdFromBlackList(collectionName, objectId, id);
}

// User State In App
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

// UID
Future<void> setUid(String collectionName, int uid) async {
  await MongoDBUtils.setUid(collectionName, objectId, uid);
}

// User Role
Future<void> setUserRole(String collectionName, String role) async {
  await MongoDBUtils.setUserRole(collectionName, objectId, role);
}

// Username
Future<void> setUsername(String collectionName, String username) async {
  await MongoDBUtils.setUsername(collectionName, objectId, username);
}

// Email
Future<void> setEmail(String collectionName, String email) async {
  await MongoDBUtils.setEmail(collectionName, objectId, email);
}

// Email Public
Future<void> setEmailPublic(String collectionName, String emailPublic) async {
  await MongoDBUtils.setEmailPublic(collectionName, objectId, emailPublic);
}

// Full Name
Future<void> setFullName(String collectionName, String fullName) async {
  await MongoDBUtils.setFullName(collectionName, objectId, fullName);
}

// First Name
Future<void> setFirstName(String collectionName, String firstName) async {
  await MongoDBUtils.setFirstName(collectionName, objectId, firstName);
}

// Last Name
Future<void> setLastName(String collectionName, String lastName) async {
  await MongoDBUtils.setLastName(collectionName, objectId, lastName);
}

// Gender
Future<void> setGender(String collectionName, String gender) async {
  await MongoDBUtils.setGender(collectionName, objectId, gender);
}

// Gender Preference
Future<void> setGenderPref(String collectionName, String genderPref) async {
  await MongoDBUtils.setGenderPref(collectionName, objectId, genderPref);
}

// Preference Distance
Future<void> setPrefDistance(String collectionName, int distance) async {
  await MongoDBUtils.setPrefDistance(collectionName, objectId, distance);
}

// Bio
Future<void> setBio(String collectionName, String bio) async {
  await MongoDBUtils.setBio(collectionName, objectId, bio);
}

// Avatar
Future<void> setAvatar(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setAvatar(collectionName, objectId, name: name, url: url);
}

// Images List
Future<void> setImagesList(
    String collectionName, String name, String url) async {
  await MongoDBUtils.setImagesList(collectionName, objectId, name, url);
}

Future<void> addImageToList(
    String collectionName, String name, String url) async {
  await MongoDBUtils.addImageToList(collectionName, objectId, name, url);
}

Future<void> removeImageFromList(String collectionName, String imageUrl) async {
  await MongoDBUtils.removeImageFromList(collectionName, objectId, imageUrl);
}

// Cover
Future<void> setCover(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setCover(collectionName, objectId, name: name, url: url);
}

// Birthday
Future<void> setBirthday(String collectionName, DateTime birthday) async {
  await MongoDBUtils.setBirthday(collectionName, objectId, birthday);
}

// Last Online
Future<void> setLastOnline(String collectionName, DateTime time) async {
  await MongoDBUtils.setLastOnline(collectionName, objectId, time);
}

// Email Verified
Future<void> setEmailVerified(String collectionName, bool verified) async {
  await MongoDBUtils.setEmailVerified(collectionName, objectId, verified);
}

// Activation Status
Future<void> setActivationStatus(String collectionName, bool activated) async {
  await MongoDBUtils.setActivationStatus(collectionName, objectId, activated);
}

// Account Deleted
Future<void> setAccountDeleted(String collectionName, bool deleted) async {
  await MongoDBUtils.setAccountDeleted(collectionName, objectId, deleted);
}

// Account Deleted Reason
Future<void> setAccountDeletedReason(
    String collectionName, String reason) async {
  await MongoDBUtils.setAccountDeletedReason(collectionName, objectId, reason);
}

// Apple ID
Future<void> setAppleId(String collectionName, String appleId) async {
  await MongoDBUtils.setAppleId(collectionName, objectId, appleId);
}

// Instagram ID
Future<void> setInstagramId(String collectionName, String instagramId) async {
  await MongoDBUtils.setInstagramId(collectionName, objectId, instagramId);
}

// Password & GeoPoint
Future<void> setHasPassword(String collectionName, bool hasPassword) async {
  await MongoDBUtils.setHasPassword(collectionName, objectId, hasPassword);
}

Future<void> setHasGeoPoint(String collectionName, bool hasGeoPoint) async {
  await MongoDBUtils.setHasGeoPoint(collectionName, objectId, hasGeoPoint);
}

// Location
Future<void> setLocationTypeNearBy(
    String collectionName, bool prefLocationType) async {
  await MongoDBUtils.setLocationTypeNearBy(
      collectionName, objectId, prefLocationType);
}

Future<void> setLocation(String collectionName, String location) async {
  await MongoDBUtils.setLocation(collectionName, objectId, location);
}

Future<void> setCity(String collectionName, String city) async {
  await MongoDBUtils.setCity(collectionName, objectId, city);
}

// Popularity & Age Preferences
Future<void> setPopularity(String collectionName, int popularity) async {
  await MongoDBUtils.setPopularity(collectionName, objectId, popularity);
}

Future<void> setPrefMinAge(String collectionName, int minAge) async {
  await MongoDBUtils.setPrefMinAge(collectionName, objectId, minAge);
}

Future<void> setPrefMaxAge(String collectionName, int maxAge) async {
  await MongoDBUtils.setPrefMaxAge(collectionName, objectId, maxAge);
}

// Credits & Platform Speaker
Future<void> addPlatformSpeakerNumber(String collectionName, int number) async {
  await MongoDBUtils.addPlatformSpeakerNumber(collectionName, objectId, number);
}

Future<void> removePlatformSpeakerNumber(
    String collectionName, int number) async {
  await MongoDBUtils.removePlatformSpeakerNumber(
      collectionName, objectId, number);
}

Future<void> addCredit(String collectionName, int credits) async {
  await MongoDBUtils.addCredit(collectionName, objectId, credits);
}

Future<void> removeCredit(String collectionName, int credits) async {
  await MongoDBUtils.removeCredit(collectionName, objectId, credits);
}

// Country, Currency & Contact
Future<void> setCountry(String collectionName, String country) async {
  await MongoDBUtils.setCountry(collectionName, objectId, country);
}

Future<void> setCountryCode(String collectionName, String countryCode) async {
  await MongoDBUtils.setCountryCode(collectionName, objectId, countryCode);
}

Future<void> setCurrencyCode(String collectionName, String currencyCode) async {
  await MongoDBUtils.setCurrencyCode(collectionName, objectId, currencyCode);
}

Future<void> setCurrencySymbol(
    String collectionName, String currencySymbol) async {
  await MongoDBUtils.setCurrencySymbol(
      collectionName, objectId, currencySymbol);
}

Future<void> setCountryDialCode(String collectionName, String dialCode) async {
  await MongoDBUtils.setCountryDialCode(collectionName, objectId, dialCode);
}

Future<void> setPhoneNumber(String collectionName, String phoneNumber) async {
  await MongoDBUtils.setPhoneNumber(collectionName, objectId, phoneNumber);
}

Future<void> setPhoneNumberFull(
    String collectionName, String phoneNumberFull) async {
  await MongoDBUtils.setPhoneNumberFull(
      collectionName, objectId, phoneNumberFull);
}

// Company & Job
Future<void> setCompanyName(String collectionName, String companyName) async {
  await MongoDBUtils.setCompanyName(collectionName, objectId, companyName);
}

Future<void> setJobTitle(String collectionName, String jobTitle) async {
  await MongoDBUtils.setJobTitle(collectionName, objectId, jobTitle);
}

Future<void> setSchool(String collectionName, String school) async {
  await MongoDBUtils.setSchool(collectionName, objectId, school);
}

// About & Mood
Future<void> setAboutYou(String collectionName, String about) async {
  await MongoDBUtils.setAboutYou(collectionName, objectId, about);
}

Future<void> setMoodTitle(String collectionName, String moodTitle) async {
  await MongoDBUtils.setMoodTitle(collectionName, objectId, moodTitle);
}

Future<void> setPhotoVerified(String collectionName, bool photoVerified) async {
  await MongoDBUtils.setPhotoVerified(collectionName, objectId, photoVerified);
}

// VIP & Daily Gifts
Future<void> setNormalVip(String collectionName, DateTime normalVip) async {
  await MongoDBUtils.setNormalVip(collectionName, objectId, normalVip);
}

Future<void> setDailyGift(String collectionName, DateTime dailyGift) async {
  await MongoDBUtils.setDailyGift(collectionName, objectId, dailyGift);
}

Future<void> setVipAdsDisabled(
    String collectionName, DateTime adsDisabled) async {
  await MongoDBUtils.setVipAdsDisabled(collectionName, objectId, adsDisabled);
}

Future<void> setVip3xPopular(String collectionName, DateTime xPopular) async {
  await MongoDBUtils.setVip3xPopular(collectionName, objectId, xPopular);
}

Future<void> setVipShowOnline(
    String collectionName, DateTime showOnline) async {
  await MongoDBUtils.setVipShowOnline(collectionName, objectId, showOnline);
}

Future<void> setVipExtraShows(
    String collectionName, DateTime extraShows) async {
  await MongoDBUtils.setVipExtraShows(collectionName, objectId, extraShows);
}

Future<void> setVipMoreVisits(
    String collectionName, DateTime moreVisits) async {
  await MongoDBUtils.setVipMoreVisits(collectionName, objectId, moreVisits);
}

Future<void> setVipMoveToTop(String collectionName, DateTime moveToTop) async {
  await MongoDBUtils.setVipMoveToTop(collectionName, objectId, moveToTop);
}

Future<void> setVipInvisibleMode(
    String collectionName, bool invisibleMode) async {
  await MongoDBUtils.setVipInvisibleMode(
      collectionName, objectId, invisibleMode);
}

Future<void> setVipIsInvisible(String collectionName, bool isInvisible) async {
  await MongoDBUtils.setVipIsInvisible(collectionName, objectId, isInvisible);
}

// Name Change & Account Hidden
Future<void> setNameChanged(String collectionName, bool nameChanged) async {
  await MongoDBUtils.setNameChanged(collectionName, objectId, nameChanged);
}

Future<void> setAccountHidden(String collectionName, bool hidden) async {
  await MongoDBUtils.setAccountHidden(collectionName, objectId, hidden);
}

// Blocked Users
Future<void> setBlockedUsers(String collectionName, List<dynamic> users) async {
  await MongoDBUtils.setBlockedUsers(collectionName, objectId, users);
}

Future<void> setBlockedUserIDs(String collectionName, List<dynamic> ids) async {
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
Future<void> setPrivacyShowDistance(String collectionName, bool value) async {
  await MongoDBUtils.setPrivacyShowDistance(collectionName, objectId, value);
}

Future<void> setPrivacyShowStatusOnline(
    String collectionName, bool value) async {
  await MongoDBUtils.setPrivacyShowStatusOnline(
      collectionName, objectId, value);
}

Future<void> setWhatIWant(String collectionName, String value) async {
  await MongoDBUtils.setWhatIWant(collectionName, objectId, value);
}

Future<void> setLanguage(String collectionName, String language) async {
  await MongoDBUtils.setLanguage(collectionName, objectId, language);
}

Future<void> setDrinking(String collectionName, String drinking) async {
  await MongoDBUtils.setDrinking(collectionName, objectId, drinking);
}

Future<void> setSmoking(String collectionName, String smoking) async {
  await MongoDBUtils.setSmoking(collectionName, objectId, smoking);
}

Future<void> setKids(String collectionName, String kids) async {
  await MongoDBUtils.setKids(collectionName, objectId, kids);
}

Future<void> setLiving(String collectionName, String living) async {
  await MongoDBUtils.setLiving(collectionName, objectId, living);
}

// Physical and Lifestyle Preferences
Future<void> setBodyType(String collectionName, String bodyType) async {
  await MongoDBUtils.setBodyType(collectionName, objectId, bodyType);
}

Future<void> setHeight(String collectionName, int height) async {
  await MongoDBUtils.setHeight(collectionName, objectId, height);
}

Future<void> setSexuality(String collectionName, String sexuality) async {
  await MongoDBUtils.setSexuality(collectionName, objectId, sexuality);
}

Future<void> setRelationship(String collectionName, String relationship) async {
  await MongoDBUtils.setRelationship(collectionName, objectId, relationship);
}

Future<void> setSecondaryPassword(
    String collectionName, String secondaryPassword) async {
  await MongoDBUtils.setSecondaryPassword(
      collectionName, objectId, secondaryPassword);
}

Future<void> setSexualOrientations(
    String collectionName, List<String> orientations) async {
  await MongoDBUtils.setSexualOrientations(
      collectionName, objectId, orientations);
}

Future<void> setPassions(String collectionName, List<String> passions) async {
  await MongoDBUtils.setPassions(collectionName, objectId, passions);
}

Future<void> setShowSexualOrientation(String collectionName, bool show) async {
  await MongoDBUtils.setShowSexualOrientation(collectionName, objectId, show);
}

Future<void> setShowGenderInProfile(String collectionName, bool show) async {
  await MongoDBUtils.setShowGenderInProfile(collectionName, objectId, show);
}

Future<void> setDistanceInMiles(String collectionName, bool value) async {
  await MongoDBUtils.setDistanceInMiles(collectionName, objectId, value);
}

Future<void> setHideMyLocation(String collectionName, bool hide) async {
  await MongoDBUtils.setHideMyLocation(collectionName, objectId, hide);
}

Future<void> setGeoPoint(
    String collectionName, double longitude, double latitude) async {
  await MongoDBUtils.setGeoPoint(collectionName, objectId, longitude, latitude);
}

Future<void> getGeoPoint(
    String collectionName, double longitude, double latitude) async {
  await MongoDBUtils.getGeoPoint(collectionName, objectId);
}

Future<void> setAge(String collectionName, int age) async {
  await MongoDBUtils.setAge(collectionName, objectId, age);
}

Future<void> setDiamonds(String collectionName, int diamonds) async {
  await MongoDBUtils.setDiamonds(collectionName, objectId, diamonds);
}

Future<void> removeDiamonds(String collectionName, int diamonds) async {
  await MongoDBUtils.removeDiamonds(collectionName, objectId, diamonds);
}

Future<void> setDiamondsTotal(String collectionName, int diamondsTotal) async {
  await MongoDBUtils.setDiamondsTotal(collectionName, objectId, diamondsTotal);
}

Future<void> addPayouts(String collectionName, int incrementPayout) async {
  await MongoDBUtils.addPayouts(collectionName, objectId, incrementPayout);
}

// Company, Financial & Location Extensions
Future<void> setCountry(String collectionName, String country) async {
  await MongoDBUtils.setCountry(collectionName, objectId, country);
}

Future<void> setCountryCode(String collectionName, String countryCode) async {
  await MongoDBUtils.setCountryCode(collectionName, objectId, countryCode);
}

Future<void> setCurrencyCode(String collectionName, String currencyCode) async {
  await MongoDBUtils.setCurrencyCode(collectionName, objectId, currencyCode);
}

Future<void> setCurrencySymbol(
    String collectionName, String currencySymbol) async {
  await MongoDBUtils.setCurrencySymbol(
      collectionName, objectId, currencySymbol);
}

Future<void> setCountryDialCode(String collectionName, String dialCode) async {
  await MongoDBUtils.setCountryDialCode(collectionName, objectId, dialCode);
}

Future<void> setPhoneNumber(String collectionName, String phoneNumber) async {
  await MongoDBUtils.setPhoneNumber(collectionName, objectId, phoneNumber);
}

Future<void> setPhoneNumberFull(
    String collectionName, String phoneNumberFull) async {
  await MongoDBUtils.setPhoneNumberFull(
      collectionName, objectId, phoneNumberFull);
}

Future<void> setCompanyName(String collectionName, String companyName) async {
  await MongoDBUtils.setCompanyName(collectionName, objectId, companyName);
}

Future<void> setJobTitle(String collectionName, String jobTitle) async {
  await MongoDBUtils.setJobTitle(collectionName, objectId, jobTitle);
}

Future<void> setSchool(String collectionName, String school) async {
  await MongoDBUtils.setSchool(collectionName, objectId, school);
}

// About, Mood, VIP & Privacy Settings
Future<void> setAboutYou(String collectionName, String about) async {
  await MongoDBUtils.setAboutYou(collectionName, objectId, about);
}

Future<void> setMoodTitle(String collectionName, String moodTitle) async {
  await MongoDBUtils.setMoodTitle(collectionName, objectId, moodTitle);
}

Future<void> setPhotoVerified(String collectionName, bool photoVerified) async {
  await MongoDBUtils.setPhotoVerified(collectionName, objectId, photoVerified);
}

Future<void> setNormalVip(String collectionName, DateTime normalVip) async {
  await MongoDBUtils.setNormalVip(collectionName, objectId, normalVip);
}

Future<void> setDailyGift(String collectionName, DateTime dailyGift) async {
  await MongoDBUtils.setDailyGift(collectionName, objectId, dailyGift);
}

Future<void> setVipAdsDisabled(
    String collectionName, DateTime adsDisabled) async {
  await MongoDBUtils.setVipAdsDisabled(collectionName, objectId, adsDisabled);
}

Future<void> setVip3xPopular(String collectionName, DateTime xPopular) async {
  await MongoDBUtils.setVip3xPopular(collectionName, objectId, xPopular);
}

Future<void> setVipShowOnline(
    String collectionName, DateTime showOnline) async {
  await MongoDBUtils.setVipShowOnline(collectionName, objectId, showOnline);
}

Future<void> setVipExtraShows(
    String collectionName, DateTime extraShows) async {
  await MongoDBUtils.setVipExtraShows(collectionName, objectId, extraShows);
}

Future<void> setVipMoreVisits(
    String collectionName, DateTime moreVisits) async {
  await MongoDBUtils.setVipMoreVisits(collectionName, objectId, moreVisits);
}

Future<void> setVipMoveToTop(String collectionName, DateTime moveToTop) async {
  await MongoDBUtils.setVipMoveToTop(collectionName, objectId, moveToTop);
}

Future<void> setVipInvisibleMode(
    String collectionName, bool invisibleMode) async {
  await MongoDBUtils.setVipInvisibleMode(
      collectionName, objectId, invisibleMode);
}

Future<void> setVipIsInvisible(String collectionName, bool isInvisible) async {
  await MongoDBUtils.setVipIsInvisible(collectionName, objectId, isInvisible);
}

// Name Change & Account Hidden
Future<void> setAppLanguage(String collectionName, String language) async {
  await MongoDBUtils.setAppLanguage(collectionName, objectId, language);
}

Future<void> removeAppLanguage(String collectionName, String language) async {
  await MongoDBUtils.removeAppLanguage(collectionName, objectId, language);
}

Future<void> setCloseFriend(String collectionName, String userID) async {
  await MongoDBUtils.setCloseFriend(collectionName, objectId, userID);
}

Future<void> removeCloseFriend(String collectionName, String userID) async {
  await MongoDBUtils.removeCloseFriend(collectionName, objectId, userID);
}

Future<void> setVisitors(String collectionName, String userID) async {
  await MongoDBUtils.setVisitors(collectionName, objectId, userID);
}

Future<void> removeVisitors(String collectionName, String userID) async {
  await MongoDBUtils.removeVisitors(collectionName, objectId, userID);
}

// Gifts
Future<void> setGiftsAmount(String collectionName, int amount) async {
  await MongoDBUtils.setGiftsAmount(collectionName, objectId, amount);
}

// Post IDs
Future<void> setIdsToPostList(String collectionName, List<dynamic> ids) async {
  await MongoDBUtils.setIdsToPostList(collectionName, objectId, ids);
}

Future<void> setIdToPostList(String collectionName, String id) async {
  await MongoDBUtils.setIdToPostList(collectionName, objectId, id);
}

Future<void> removePostId(String collectionName, String id) async {
  await MongoDBUtils.removePostId(collectionName, objectId, id);
}

// Black List
Future<void> setIdsToBlackList(String collectionName, List<dynamic> ids) async {
  await MongoDBUtils.setIdsToBlackList(collectionName, objectId, ids);
}

Future<void> setIdToBlackList(String collectionName, String id) async {
  await MongoDBUtils.setIdToBlackList(collectionName, objectId, id);
}

Future<void> removeIdFromBlackList(String collectionName, String id) async {
  await MongoDBUtils.removeIdFromBlackList(collectionName, objectId, id);
}

// User State In App
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

// UID
Future<void> setUid(String collectionName, int uid) async {
  await MongoDBUtils.setUid(collectionName, objectId, uid);
}

// User Role
Future<void> setUserRole(String collectionName, String role) async {
  await MongoDBUtils.setUserRole(collectionName, objectId, role);
}

// Username
Future<void> setUsername(String collectionName, String username) async {
  await MongoDBUtils.setUsername(collectionName, objectId, username);
}

// Email
Future<void> setEmail(String collectionName, String email) async {
  await MongoDBUtils.setEmail(collectionName, objectId, email);
}

// Email Public
Future<void> setEmailPublic(String collectionName, String emailPublic) async {
  await MongoDBUtils.setEmailPublic(collectionName, objectId, emailPublic);
}

// Full Name
Future<void> setFullName(String collectionName, String fullName) async {
  await MongoDBUtils.setFullName(collectionName, objectId, fullName);
}

// First Name
Future<void> setFirstName(String collectionName, String firstName) async {
  await MongoDBUtils.setFirstName(collectionName, objectId, firstName);
}

// Last Name
Future<void> setLastName(String collectionName, String lastName) async {
  await MongoDBUtils.setLastName(collectionName, objectId, lastName);
}

// Gender
Future<void> setGender(String collectionName, String gender) async {
  await MongoDBUtils.setGender(collectionName, objectId, gender);
}

// Gender Preference
Future<void> setGenderPref(String collectionName, String genderPref) async {
  await MongoDBUtils.setGenderPref(collectionName, objectId, genderPref);
}

// Preference Distance
Future<void> setPrefDistance(String collectionName, int distance) async {
  await MongoDBUtils.setPrefDistance(collectionName, objectId, distance);
}

// Bio
Future<void> setBio(String collectionName, String bio) async {
  await MongoDBUtils.setBio(collectionName, objectId, bio);
}

// Avatar
Future<void> setAvatar(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setAvatar(collectionName, objectId, name: name, url: url);
}

// Images List
Future<void> setImagesList(
    String collectionName, String name, String url) async {
  await MongoDBUtils.setImagesList(collectionName, objectId, name, url);
}

Future<void> addImageToList(
    String collectionName, String name, String url) async {
  await MongoDBUtils.addImageToList(collectionName, objectId, name, url);
}

Future<void> removeImageFromList(String collectionName, String imageUrl) async {
  await MongoDBUtils.removeImageFromList(collectionName, objectId, imageUrl);
}

// Cover
Future<void> setCover(String collectionName,
    {required String name, required String url}) async {
  await MongoDBUtils.setCover(collectionName, objectId, name: name, url: url);
}

// Birthday
Future<void> setBirthday(String collectionName, DateTime birthday) async {
  await MongoDBUtils.setBirthday(collectionName, objectId, birthday);
}

// Last Online
Future<void> setLastOnline(String collectionName, DateTime time) async {
  await MongoDBUtils.setLastOnline(collectionName, objectId, time);
}

// Email Verified
Future<void> setEmailVerified(String collectionName, bool verified) async {
  await MongoDBUtils.setEmailVerified(collectionName, objectId, verified);
}

// Activation Status
Future<void> setActivationStatus(String collectionName, bool activated) async {
  await MongoDBUtils.setActivationStatus(collectionName, objectId, activated);
}

// Account Deleted
Future<void> setAccountDeleted(String collectionName, bool deleted) async {
  await MongoDBUtils.setAccountDeleted(collectionName, objectId, deleted);
}

// Account Deleted Reason
Future<void> setAccountDeletedReason(
    String collectionName, String reason) async {
  await MongoDBUtils.setAccountDeletedReason(collectionName, objectId, reason);
}

// Apple ID
Future<void> setAppleId(String collectionName, String appleId) async {
  await MongoDBUtils.setAppleId(collectionName, objectId, appleId);
}

// Instagram ID
Future<void> setInstagramId(String collectionName, String instagramId) async {
  await MongoDBUtils.setInstagramId(collectionName, objectId, instagramId);
}

// Payment & Bank Info
Future<void> setPayoneerEmail(String collectionName, String payEmail) async {
  await MongoDBUtils.setPayoneerEmail(collectionName, objectId, payEmail);
}

Future<void> setPayPalEmail(String collectionName, String payPalEmail) async {
  await MongoDBUtils.setPayPalEmail(collectionName, objectId, payPalEmail);
}

Future<void> setIban(String collectionName, String iban) async {
  await MongoDBUtils.setIban(collectionName, objectId, iban);
}

Future<void> setAccountName(String collectionName, String name) async {
  await MongoDBUtils.setAccountName(collectionName, objectId, name);
}

Future<void> setBankName(String collectionName, String bank) async {
  await MongoDBUtils.setBankName(collectionName, objectId, bank);
}

Future<void> setInstallation(
    String collectionName, dynamic installation) async {
  await MongoDBUtils.setInstallation(collectionName, objectId, installation);
}

// Invited & Premium
Future<void> setInvitedByAnswer(
    String collectionName, bool invitedAnswer) async {
  await MongoDBUtils.setInvitedByAnswer(
      collectionName, objectId, invitedAnswer);
}

Future<void> setInvitedByUser(String collectionName, String invitedBy) async {
  await MongoDBUtils.setInvitedByUser(collectionName, objectId, invitedBy);
}

Future<void> setPremiumType(String collectionName, String premiumType) async {
  await MongoDBUtils.setPremiumType(collectionName, objectId, premiumType);
}

// Diamonds Agency
Future<void> addDiamondsAgency(String collectionName, int diamonds) async {
  await MongoDBUtils.addDiamondsAgency(collectionName, objectId, diamonds);
}

Future<void> removeDiamondsAgency(String collectionName, int diamonds) async {
  await MongoDBUtils.removeDiamondsAgency(collectionName, objectId, diamonds);
}

Future<void> addDiamondsAgencyTotal(String collectionName, int diamonds) async {
  await MongoDBUtils.addDiamondsAgencyTotal(collectionName, objectId, diamonds);
}

Future<void> removeDiamondsAgencyTotal(
    String collectionName, int diamonds) async {
  await MongoDBUtils.removeDiamondsAgencyTotal(
      collectionName, objectId, diamonds);
}
