import 'package:equatable/equatable.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:video_player/video_player.dart';

class PostDetailsState extends Equatable {
  final int currentIndex;
  final Map<int, VideoPlayerController> videoControllers;
  final PostModel postModel;
  const PostDetailsState({
    this.currentIndex = 0,
    this.videoControllers = const {},
    required this.postModel,
  });

  PostDetailsState copyWith({
    int? currentIndex,
    Map<int, VideoPlayerController>? videoControllers,
    PostModel? postModel,
  }) {
    return PostDetailsState(
      postModel: postModel ?? this.postModel,
      currentIndex: currentIndex ?? this.currentIndex,
      videoControllers: videoControllers ?? this.videoControllers,
    );
  }

  @override
  List<Object?> get props => [currentIndex, videoControllers, postModel];
}
