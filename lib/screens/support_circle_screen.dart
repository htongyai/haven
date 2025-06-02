import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/support_post.dart';
import '../providers/support_posts_provider.dart';
import '../providers/user_provider.dart';

class SupportCircleScreen extends ConsumerStatefulWidget {
  const SupportCircleScreen({super.key});

  @override
  ConsumerState<SupportCircleScreen> createState() =>
      _SupportCircleScreenState();
}

class _SupportCircleScreenState extends ConsumerState<SupportCircleScreen> {
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_postController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write something')));
      return;
    }

    final post = SupportPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _postController.text,
      date: DateTime.now(),
      isAnonymous: true,
      category: SupportCategory.justWannaTalk,
    );

    ref.read(supportPostsProvider.notifier).addPost(post);
    _postController.clear();
    Navigator.pop(context);
  }

  void _toggleLike(SupportPost post) {
    ref.read(supportPostsProvider.notifier).incrementLightCount(post.id);
    ref
        .read(userProvider.notifier)
        .updateGlowScore((ref.read(userProvider)?.glowScore ?? 0) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(supportPostsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Support Circle',
          style: GoogleFonts.playfairDisplay(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNewPostDialog(context),
          ),
        ],
      ),
      body:
          posts.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.group,
                      size: MediaQuery.of(context).size.width * 0.15,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.5),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'No posts yet',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      'Be the first to share',
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.text,
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                post.formattedDate,
                                style: GoogleFonts.inter(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onBackground.withOpacity(0.6),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () => _toggleLike(post),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onBackground.withOpacity(0.6),
                                  ),
                                  Text(
                                    '${post.lightCount}',
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.035,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  void _showNewPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'New Post',
              style: GoogleFonts.playfairDisplay(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: TextField(
              controller: _postController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                hintStyle: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _submitPost();
                },
                child: Text(
                  'Post',
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
