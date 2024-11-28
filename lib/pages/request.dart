import 'package:flutter/material.dart';
// page
import 'package:tunetalk/pages/chatroom.dart';

class Request {
  final String profileImage;
  final String nickname;
  final String artistName;
  final String songTitle;

  Request({
    required this.profileImage,
    required this.nickname,
    required this.artistName,
    required this.songTitle,
  });
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  // 요청 목록을 리스트로 관리
  List<Request> reqs = [
    Request(
      profileImage: '',
      nickname: 'User1',
      artistName: 'Artist1',
      songTitle: 'Song1',
    ),
    Request(
      profileImage: '',
      nickname: 'User2',
      artistName: 'Artist2',
      songTitle: 'Song2',
    ),
  ];

  // 요청을 삭제하는 함수
  void _removeReq(int index) {
    setState(() {
      reqs.removeAt(index); // 리스트에서 해당 요청 제거
    });
  }

  // Accept 버튼 클릭 시 ChatRoomPage로 이동
  void _goToChatRoomPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatRoom(),
      ),
    );
  }

  // Playlist 버튼을 눌렀을 때 팝업 띄우기
  void _showPlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 배경 클릭으로 팝업 닫히지 않도록
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 400, // 팝업의 높이 설정
                child: ListView.builder(
                  itemCount: 15, // 15개 항목을 리스트로 보여주기
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Song ${index + 1}', // 동적으로 곡 제목 표시
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Artist ${index + 1}', // 동적으로 가수 이름 표시
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const Divider(), // 각 항목 사이에 구분선 추가
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // 팝업 닫기
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request')),
      body: ListView.builder(
        itemCount: reqs.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              UserRequestWidget(
                profileImage: reqs[index].profileImage,
                nickname: reqs[index].nickname,
                artistName: reqs[index].artistName,
                songTitle: reqs[index].songTitle,
                onReject: () => _removeReq(index), // Reject 클릭 시 요청 삭제
                onAccept: () =>
                    _goToChatRoomPage(context), // Accept 클릭 시 ChatRoomPage로 이동
                onPlaylist: () =>
                    _showPlaylistDialog(context), // Playlist 버튼 클릭 시 팝업
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

class UserRequestWidget extends StatelessWidget {
  final String profileImage;
  final String nickname;
  final String artistName;
  final String songTitle;
  final VoidCallback onReject;
  final VoidCallback onAccept;
  final VoidCallback onPlaylist;

  const UserRequestWidget({
    super.key,
    required this.profileImage,
    required this.nickname,
    required this.artistName,
    required this.songTitle,
    required this.onReject,
    required this.onAccept,
    required this.onPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(profileImage),
              ),
              const SizedBox(width: 10),
              Text(
                nickname,
                style: const TextStyle(
                  fontSize: 20, // 글씨 크기 키우기
                  fontWeight: FontWeight.bold, // 볼드체로 설정
                ),
              ),
              const Spacer(),
              Expanded(
                child: TextButton(
                  onPressed: onPlaylist, // Playlist 버튼 클릭 시 팝업
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, // 버튼 배경 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 둥근 모서리
                    ),
                  ),
                  child: const Text(
                    'Playlist', // 버튼 텍스트
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept, // Accept 버튼 클릭 시 ChatRoomPage로 이동
                  child: const Text('Accept'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onReject, // Reject 버튼 클릭 시 요청 삭제
                  child: const Text('Reject'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
