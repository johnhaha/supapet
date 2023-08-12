import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/data/appdata.dart';
import 'package:supapet/handler/feedback.dart';
import 'package:supapet/handler/image.dart';
import 'package:supapet/handler/post.dart';
import 'package:supapet/handler/store.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/model/post.dart';
import 'package:supapet/view/add_pet.dart';
import 'package:supapet/view/choose_pet.dart';
import 'package:supapet/view/login.dart';
import 'package:uuid/uuid.dart';

Future addPost(WidgetRef ref) async {
  if (!ref.read(appData).checkLogin()) {
    var res = await showLogin(ref.context);
    if (res == null || !res) {
      return;
    }
  }
  var image = await ImageHandler.pickImage();
  if (image != null) {
    var pets = ref.read(appData).userPets;
    Pet? pet;
    if (pets.isEmpty) {
      pet = await showAddPetPop(
        ref.context,
        onAdd: (pet) {},
      );
    }
    pet ??= await showChoosePetPop(
      ref.context,
      onChoose: (pet) {},
    );
    if (pet != null) {
      FeedbackHandler.showLoading();
      var path = await StoreHandler.storeFile(image);
      var post = Post(
        createdAt: DateTime.now(),
        postID: Uuid().v4(),
        userID: ref.read(appData).userID!,
        petID: pet.petID,
        content: path,
      );
      await PostHandler.insertPost(post);
      post.pet = pet;
      FeedbackHandler.hideLoading();
      ref.read(appData).addPostUpdate(post);
    }
  }
}
