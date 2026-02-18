/*
 * @Author: Km Muzahid
 * @Date: 2026-02-18 11:53:31
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/constant/enums.dart';

class Plan {
  final String name;
  final double price;
  final List<Feature> allowedFeatures;
  final Map<Feature, int>? limits; // for features with max values

  Plan({required this.name, required this.price, required this.allowedFeatures, this.limits});
}

final freePlan = Plan(
  name: "Free",
  price: 0,
  allowedFeatures: [
    Feature.rankWishlistCourses,
    Feature.feedPosts,
    Feature.photoUploads,
    Feature.friends,
    Feature.ads,
    Feature.pointsForPinLinks5Courses,
    Feature.leaderboardInvites,
  ],
  limits: {
    Feature.rankWishlistCourses: 5,
    Feature.feedPosts: 10, // example limit
    Feature.photoUploads: 3, // example limit
    Feature.friends: 5,
    Feature.leaderboardInvites: 5,
  },
);

final clubPlan = Plan(
  name: "PinLinks Club Member",
  price: 12.99,
  allowedFeatures: [
    Feature.rankWishlistCourses,
    Feature.feedPosts,
    Feature.photoUploads,
    Feature.friends,
    Feature.videoPosting,
    Feature.leaderboardInvites,
    Feature.teeTimeAccess,
    Feature.adFreeExperience,
    Feature.signUpBonusPoints,
    Feature.pointsForPinLinks5Courses,
  ],
  limits: {
    Feature.photoUploads: 6, // 6+ per post
    Feature.leaderboardInvites: 1000, // practically unlimited
  },
);

final creatorPlan = Plan(
  name: "Creator / Business",
  price: 24.99,
  allowedFeatures: [
    Feature.rankWishlistCourses,
    Feature.feedPosts,
    Feature.photoUploads,
    Feature.friends,
    Feature.videoPosting,
    Feature.leaderboardInvites,
    Feature.teeTimeAccess,
    Feature.adFreeExperience,
    Feature.signUpBonusPoints,
    Feature.pointsForPinLinks5Courses,
    Feature.socialLinks,
    Feature.personalStoreLink,
    Feature.selfPromoAdSpace,
    Feature.analyticsViewsClicksRevenue,
  ],
  limits: {
    Feature.photoUploads: 9999, // unlimited
    Feature.leaderboardInvites: 9999, // unlimited
  },
);
