import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/view/add_pet.dart';
import 'package:supapet/view/pet_avatar.dart';

import '../data/appdata.dart';
import '../model/pet.dart';

Future<Pet?> showChoosePetPop(
  BuildContext context, {
  required void Function(Pet pet) onChoose,
}) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: kPageColor,
    isScrollControlled: true,
    builder: (context) {
      return ChoosePet(
        onChoose: (pet) {
          Navigator.pop(context, pet);
          onChoose(pet);
        },
      );
    },
  );
}

class ChoosePet extends ConsumerWidget {
  const ChoosePet({
    super.key,
    required this.onChoose,
  });
  final void Function(Pet pet) onChoose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pets = ref.watch(appData).userPets;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kBasePadding * 2, vertical: kBasePadding * 4),
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pick Pet',
                  style: TextStyle(
                      fontSize: kFontSize, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      showAddPetPop(
                        context,
                        onAdd: (pet) {},
                      );
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kFontSize,
                          color: kPrimaryColor),
                    ))
              ],
            ),
            const SizedBox(
              height: kBasePadding,
            ),
            Row(
              children: List<Widget>.from(pets.map((e) => Padding(
                    padding: const EdgeInsets.only(right: kBasePadding),
                    child: GestureDetector(
                      onTap: () {
                        onChoose(e);
                      },
                      child: PetAvatar(pet: e),
                    ),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
