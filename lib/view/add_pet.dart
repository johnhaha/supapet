import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/data/appdata.dart';
import 'package:supapet/handler/feedback.dart';
import 'package:supapet/handler/image.dart';
import 'package:supapet/handler/pet.dart';
import 'package:supapet/handler/store.dart';
import 'package:supapet/model/pet.dart';
import 'package:uuid/uuid.dart';

Future<Pet?> showAddPetPop(BuildContext context,
    {required void Function(Pet pet) onAdd}) async {
  return await showModalBottomSheet<Pet>(
    context: context,
    backgroundColor: kPageColor,
    isScrollControlled: true,
    builder: (context) {
      return AddPet(
        onAdd: (pet) {
          Navigator.pop(context, pet);
          onAdd(pet);
        },
      );
    },
  );
}

class AddPet extends ConsumerStatefulWidget {
  const AddPet({
    super.key,
    required this.onAdd,
  });
  final void Function(Pet pet) onAdd;

  @override
  ConsumerState<AddPet> createState() => _AddPetState();
}

class _AddPetState extends ConsumerState<AddPet> {
  File? _image;
  late TextEditingController _nameInput;

  @override
  void initState() {
    super.initState();
    _nameInput = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: kBasePadding * 2,
          ),
          GestureDetector(
            onTap: _getImage,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: _image != null
                    ? DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _image == null ? const Icon(Icons.add_a_photo) : null,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _nameInput,
              decoration: const InputDecoration(
                hintText: 'name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_checkInput()) {
                await _addPet();
              }
            },
            child: const Text('Create Pet'),
          ),
          SizedBox(
            height: kBasePadding * 2,
          ),
        ],
      ),
    );
  }

  bool _checkInput() {
    if (_image == null) {
      FeedbackHandler.showToast(msg: 'avatar is required');
      return false;
    }
    if (_nameInput.text.isEmpty) {
      FeedbackHandler.showToast(msg: 'name is required');
      return false;
    }
    return true;
  }

  Future _getImage() async {
    try {
      var res = await ImageHandler.pickImage();
      if (res != null) {
        setState(() {
          _image = res;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future _addPet() async {
    try {
      FeedbackHandler.showLoading();
      var path = await StoreHandler.storeFile(_image!);
      var pet = Pet(
        petID: Uuid().v4(),
        userID: ref.read(appData).userID!,
        avatar: path,
        name: _nameInput.text,
      );
      await PetHandler.insertPet(pet);
      ref.read(appData).addPetUpdate(pet);
      FeedbackHandler.hideLoading();
      widget.onAdd(pet);
    } catch (e) {
      rethrow;
    }
  }
}
