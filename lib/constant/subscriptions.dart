/*
 * @Author: Km Muzahid
 * @Date: 2026-02-18 11:53:31
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/constant/enums.dart';

class Plan {
  final String name;
  final double price;
  final String subtitle;
  final List<String> featureTitles;
  final List<String> extraFeatures;
  final List<Feature> allowedFeatures;
  final Map<Feature, int>? limits; // for features with max values

  Plan({
    required this.name,
    required this.price,
    required this.featureTitles,
    required this.extraFeatures,
    required this.allowedFeatures,
    required this.subtitle,
    this.limits,
  });
}

final freePlan = Plan(
  name: "Free",
  price: 0,
  subtitle: 'Lifetime',
  featureTitles: [
    'Rank unlimited courses',
    'Wishlist limited courses',
    'Limited photo uploads per post (5)',
    '10 seconds long video posting',
    'Invite up to 5 friends for the tournament',
    'Limited raffle entries (spending cap up to \$10)'
  ],
  extraFeatures: ["Limited course comparison categories", "No Ad-free experience"],
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
  subtitle: 'Monthly',
  name: "PinLinks Club Member",
  price: 12.99,
  featureTitles: [
    'Unlimited course tracking',
    'Ad-free experience',
    'Unlimited friends',
    'Unlimited leaderboard invites',
    'Unlimited access to prize raffles',
    '6+ photos per post',
    'Longer Video posting',
    '1000 points at sign-up',
    '100 points for playing Pinlinks 5 courses'
  ],
  extraFeatures: [],
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
  subtitle: 'Yearly',
  name: "Creator / Business",
  price: 24.99,
  featureTitles: [
    'For creators & brands',
    'All Club features',
    'Social links (YouTube, IG, TikTok, X)',
    'Personal store integration',
    'Self-promo ad space',
    'Analytics: views, clicks, revenue',
  ],
  extraFeatures: [],
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
