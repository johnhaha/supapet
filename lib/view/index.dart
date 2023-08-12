import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/view/add_post.dart';
import 'package:supapet/view/pet_board_page.dart';
import 'package:supapet/view/post_page.dart';

class Index extends ConsumerStatefulWidget {
  const Index({super.key});

  @override
  ConsumerState<Index> createState() => _IndexState();
}

class _IndexState extends ConsumerState<Index> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const PostPage(), const PetBoardPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageColor,
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'SupaPet' : 'Rank'),
        backgroundColor: kPageColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: kFontColor,
          size: kTitleFontSize,
        ),
        onPressed: () {
          addPost(ref);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.equalizer),
          ),
        ],
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
