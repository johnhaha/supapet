import 'package:flutter/material.dart';
import 'package:supapet/data/board_page_data.dart';
import 'package:supapet/handler/feedback.dart';
import 'package:supapet/view/pet_board.dart';

class PetBoardPage extends StatefulWidget {
  const PetBoardPage({
    super.key,
  });

  @override
  State<PetBoardPage> createState() => _PetBoardPageState();
}

class _PetBoardPageState extends State<PetBoardPage> {
  late BoardPageData _boardPageData;

  @override
  void initState() {
    super.initState();
    _boardPageData = BoardPageData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return PetBoard(pets: _boardPageData.pets);
  }

  Future _getData() async {
    try {
      FeedbackHandler.showLoading();
      await _boardPageData.getLikePet(
        findMore: false,
      );
      setState(() {});
      FeedbackHandler.hideLoading();
    } catch (e) {
      rethrow;
    }
  }
}
