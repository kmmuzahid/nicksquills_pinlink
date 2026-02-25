/*
 * @Author: Km Muzahid
 * @Date: 2026-02-04 10:46:48
 * @Email: km.muzahid@gmail.com
 */
// ignore_for_file: constant_identifier_names
enum SubscriptionType {
  Free("Free"),
  PIN_LINKS_CLUB_MEMBER("PinLinks Club Member"),
  CREATOR_BUSINESS("Creator / Business");

  final String displayName;

  const SubscriptionType(this.displayName);
}

enum Feature {
  rankWishlistCourses,
  feedPosts,
  photoUploads,
  friends,
  videoPosting,
  ads,
  signUpBonusPoints,
  pointsForPinLinks5Courses,
  leaderboardInvites,
  teeTimeAccess,
  advancedAnalytics,
  adFreeExperience,
  socialLinks,
  personalStoreLink,
  selfPromoAdSpace,
  analyticsViewsClicksRevenue,  
}
