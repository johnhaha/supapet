import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supapet/config.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/view/pet_board_card.dart';

class PetBoard extends StatelessWidget {
  const PetBoard({super.key, required this.pets});
  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              context.push('/pet/${pets[index].petID}');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kBasePadding * 2, vertical: kBasePadding),
              child: PetBoardCard(pet: pets[index], index: index + 1),
            ));
      },
      itemCount: pets.length,
    );
  }
}
