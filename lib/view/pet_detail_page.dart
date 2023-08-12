import 'package:flutter/material.dart';
import 'package:supapet/config.dart';
import 'package:supapet/data/pet_detail_data.dart';
import 'package:supapet/view/pet_avatar.dart';
import 'package:supapet/view/post_card.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({super.key, required this.petID});
  final String petID;

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  late PetDetailData _petDetailData;

  @override
  void initState() {
    super.initState();
    _petDetailData = PetDetailData(widget.petID);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageColor,
      appBar: AppBar(
        backgroundColor: kPageColor,
        title: const Text(
          'Pet',
          style: TextStyle(fontSize: kFontSize, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kBasePadding * 2,
            ),
            if (_petDetailData.pet != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kBasePadding * 2),
                child: Row(
                  children: [
                    PetAvatar(pet: _petDetailData.pet!),
                    SizedBox(
                      width: kBasePadding,
                    ),
                    Text(_petDetailData.pet!.name),
                  ],
                ),
              ),
            SizedBox(
              height: kBasePadding * 1,
            ),
            ..._petDetailData.posts.map((post) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kBasePadding * 2, vertical: kBasePadding),
                  child: PostCard(post: post),
                )),
          ],
        ),
      ),
    );
  }

  Future _getData() async {
    try {
      await _petDetailData.getPet();
      await _petDetailData.getPosts();
      setState(() {});
    } catch (e) {
      rethrow;
    }
  }
}
