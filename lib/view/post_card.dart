import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supapet/config.dart';
import 'package:supapet/data/appdata.dart';
import 'package:supapet/model/post.dart';
import 'package:supapet/view/login.dart';
import 'package:supapet/view/pet_avatar.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context, ref) {
    var w = MediaQuery.of(context).size.width;
    var liked = ref.watch(appData).checkLikePost(post.postID);
    return Column(
      children: [
        if (post.pet != null) ...[
          GestureDetector(
            onTap: () {
              context.push('/pet/${post.pet!.petID}');
            },
            child: Row(
              children: [
                PetAvatar(pet: post.pet!),
                SizedBox(
                  width: kBasePadding,
                ),
                Text(post.pet!.name),
                const Spacer(),
                Text(DateFormat('yyyy-MM-dd').format(post.createdAt)),
              ],
            ),
          ),
          SizedBox(
            height: kBasePadding,
          )
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(kBaseRadius),
          child: CachedNetworkImage(
            imageUrl: post.contentUrl,
            width: w - kBasePadding * 2,
            height: w - kBasePadding * 2,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: () {
                if (ref.read(appData).checkLogin()) {
                  if (liked) {
                    ref.read(appData).cancelLikePost(post);
                  } else {
                    ref.read(appData).likePost(post);
                  }
                } else {
                  showLogin(context);
                }
              },
              icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
              color: kPrimaryColor,
            ),
          ],
        )
      ],
    );
  }
}
