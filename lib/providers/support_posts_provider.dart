import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/support_post.dart';

final supportPostsProvider =
    StateNotifierProvider<SupportPostsNotifier, List<SupportPost>>((ref) {
      return SupportPostsNotifier();
    });

class SupportPostsNotifier extends StateNotifier<List<SupportPost>> {
  SupportPostsNotifier() : super([]);

  void addPost(SupportPost post) {
    state = [...state, post];
  }

  void updatePost(SupportPost updatedPost) {
    state =
        state.map((post) {
          return post.id == updatedPost.id ? updatedPost : post;
        }).toList();
  }

  void deletePost(String id) {
    state = state.where((post) => post.id != id).toList();
  }

  void incrementLightCount(String id) {
    state =
        state.map((post) {
          if (post.id == id) {
            return post.copyWith(lightCount: post.lightCount + 1);
          }
          return post;
        }).toList();
  }

  List<SupportPost> getPostsByCategory(SupportCategory category) {
    return state.where((post) => post.category == category).toList();
  }
}
