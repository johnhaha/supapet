import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/model/pet.dart';

class PetAvatar extends ConsumerWidget {
  const PetAvatar({super.key, required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context, ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kAvatarSize / 2),
      child: CachedNetworkImage(
        imageUrl: pet.avatarUrl,
        width: kAvatarSize,
        height: kAvatarSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
