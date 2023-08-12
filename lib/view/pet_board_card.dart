import 'package:flutter/material.dart';
import 'package:supapet/config.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/view/pet_avatar.dart';

class PetBoardCard extends StatelessWidget {
  const PetBoardCard({
    super.key,
    required this.pet,
    required this.index,
  });
  final Pet pet;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PetAvatar(pet: pet),
        SizedBox(
          width: kBasePadding,
        ),
        Text(pet.name),
        const Spacer(),
        Text(index.toString()),
      ],
    );
  }
}
