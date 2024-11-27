import 'package:flutter/material.dart';
// page
import 'package:tunetalk/meterial/mypage.dart';
import 'package:tunetalk/meterial/club.dart';
import 'package:tunetalk/meterial/like.dart';
import 'package:tunetalk/meterial/playlist.dart';
import 'package:tunetalk/meterial/talk.dart';

class MeterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Meterial());
  }
}

class Meterial extends StatefulWidget {
  @override
  _MeterialState createState() => _MeterialState();
}

class _MeterialState extends State<Meterial> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MyPage(),
    Playlist(),
    Talk(),
    Club(),
    Like()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎵TuneTalk')),
      body: _pages[_currentIndex], // 현재 선택된 페이지를 보여줌
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 7, 19, 254),
        unselectedItemColor: const Color.fromARGB(255, 106, 106, 106),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'My Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Talk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.family_restroom_outlined),
            label: 'Club',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Like',
          ),
        ],
      ),
    );
  }
}
