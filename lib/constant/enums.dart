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

enum LeaderboardType {
  pinLinksWorldRankings("PinLinks World Rankings"),
  friends("Friends");

  final String displayName;

  const LeaderboardType(this.displayName);
}

enum LeaderboardSearchType {
  Points("Points"),
  MostCoursesPlayed("Most Courses Played"),
  MostRoundPlayed("Most Round Played"),
  TravelDistance("Travel Distance"),
  PlayedMostPinLinks5Courses("Played Most PinLinks 5 Courses");

  final String displayName;

  const LeaderboardSearchType(this.displayName);
}

enum MapFilters {
  Played("Played"),
  Wishlist("Wishlist"),
  Friends("Friends"),
  PinLinks5("PinLinks 5");

  final String displayName;

  const MapFilters(this.displayName);
}

enum FilterProfile {
  MyCourses("My Courses"),
  MyPosts("My Posts"),
  MyWishlist("My Wishlist");

  final String displayName;

  const FilterProfile(this.displayName);
}

enum ThemeType {
  light("Light Mode"),
  dark("Dark Mode");

  final String displayName;

  const ThemeType(this.displayName);
}

enum RankingType {
  courseRanking("Course Ranking"),
  wishlistRanking("Wishlist Ranking");

  final String displayName;

  const RankingType(this.displayName);
}

enum RatingCategories {
  overallFavorite("Overall Favorite"),
  courseScenery("Course Scenery"),
  courseDifficulty("Course Difficulty"),
  teeBoxAndFairwayConditions("Tee Box & Fairway"),
  greensSpeed("Greens Speed"),
  greensCondition("Greens Condition"),
  clubhouse("Clubhouse"),
  foodAndDrink("Food & Drink");

  final String displayName;

  const RatingCategories(this.displayName);
}
