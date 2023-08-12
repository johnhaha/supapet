import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/data/appdata.dart';
import 'package:supapet/handler/feedback.dart';
import 'package:supapet/view/post_card.dart';

class PostPage extends ConsumerStatefulWidget {
  const PostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _getData(false);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData(true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var posts = ref.watch(appData).posts;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kBasePadding * 2, vertical: kBasePadding),
          child: PostCard(post: posts[index]),
        );
      },
      itemCount: posts.length,
    );
  }

  Future _getData(bool more) async {
    try {
      FeedbackHandler.showLoading();
      await ref.read(appData).getPost(more: more);
      FeedbackHandler.hideLoading();
    } catch (e) {
      rethrow;
    }
  }
}
