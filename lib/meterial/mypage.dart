import 'package:flutter/material.dart';
import 'edit_profile.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 임시 데이터
  String profilePictureUrl = ''; // 프로필 사진 URL
  String email = 'user@example.com'; // 이메일
  String nickname = 'Nickname'; // 닉네임

  // 친구 임시 데이터
  final List<Map<String, String>> friends = [
    {'nickname': 'Drew', 'email': 'friend1@example.com'},
    {'nickname': 'young인', 'email': 'friend2@example.com'},
    {'nickname': '쩡25', 'email': 'friend3@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
    {'nickname': '석규**', 'email': 'friend4@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 여백 설정
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50, // 원형의 반지름
                  backgroundImage:
                      NetworkImage(profilePictureUrl), // 네트워크 URL을 사용하여 이미지 로드
                ),
                const SizedBox(width: 20),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        nickname,
                        style: const TextStyle(
                          fontSize: 30, // 폰트 크기
                          fontWeight: FontWeight.bold, // 볼드체
                        ),
                      ),
                      const SizedBox(height: 10), // 닉네임과 이메일 사이 여백
                      // 이메일
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 20, // 폰트 크기
                          color: Colors.grey, // 이메일 텍스트 색상
                        ),
                      ),
                    ]),
                const Spacer(), // 남은 공간 밀기
                // 수정 버튼
                IconButton(
                  alignment: const Alignment(0, 0),
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20), // 프로필과 친구 리스트 사이 여백
            // 친구 리스트
            Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(friend['nickname']!),
                      subtitle: Text(friend['email']!),
                      leading: const Icon(Icons.person),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
