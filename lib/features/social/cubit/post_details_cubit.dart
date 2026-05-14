import 'package:core_kit/core_kit.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/social/cubit/post_details_state.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/repository/social_repository.dart';
import 'package:video_player/video_player.dart';

class PostDetailsCubit extends SafeCubit<PostDetailsState> {
  PostDetailsCubit(this.authCubit, PostModel postModel)
    : super(PostDetailsState(postModel: postModel));
  final AuthCubit authCubit;

  final socialRepository = getIt<SocialRepository>();

  void changePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  bool isVideo(String? url) {
    if (url == null) return false;
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.flv', '.wmv'];
    return videoExtensions.any((ext) => url.toLowerCase().endsWith(ext));
  }

  Future<void> initVideo(int index, String url) async {
    if (state.videoControllers.containsKey(index)) return;

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await controller.initialize();
      controller.setLooping(true);
      controller.play();

      final updatedControllers = Map<int, VideoPlayerController>.from(
        state.videoControllers,
      );
      updatedControllers[index] = controller;
      emit(state.copyWith(videoControllers: updatedControllers));
    } catch (e) {
      print("Error initializing video: $e");
    }
  }

  Future<void> likePost(
    String postId,
    void Function(PostModel postModel) onChanged,
  ) async {
    final response = await socialRepository.likePost(postId);

    if (response.isSuccess) {
      final post = state.postModel;
      final isNeedToRemove =
          post.likes?.contains(authCubit.state.profile?.id) ?? false;
      if (isNeedToRemove) {
        showSnackBar("Post unliked successfully", type: .success);
      } else {
        showSnackBar("Post liked successfully", type: .success);
      }
      final updatedPost = post.copyWith(
        likes: [
          if (!isNeedToRemove) authCubit.state.profile?.id ?? "",
          if (!isNeedToRemove) ...post.likes ?? [],
          if (isNeedToRemove)
            ...post.likes?.where(
                  (element) => element != authCubit.state.profile?.id,
                ) ??
                [],
        ],
        likesCount: isNeedToRemove
            ? post.likesCount! - 1
            : post.likesCount! + 1,
      );
      emit(state.copyWith(postModel: updatedPost));
      onChanged(updatedPost);
    }
  }

  bool isLiked(String postId) {
    return state.postModel.likes?.contains(authCubit.state.profile?.id) ??
        false;
  }

  Future<void> follow(String userId) async {
    socialRepository.follow(userId);
  }

  Future<void> sharePost(String postId) async {
    socialRepository.sharePost(postId);
  }

  @override
  Future<void> close() {
    for (var controller in state.videoControllers.values) {
      controller.dispose();
    }
    return super.close();
  }
}
