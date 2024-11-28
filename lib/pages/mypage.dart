import 'package:flutter/material.dart';
// page
import 'package:tunetalk/api/user_api.dart';
import 'package:tunetalk/pages/edit_profile.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 임시 데이터
  String profilePictureUrl = ''; // 프로필 사진 URL
  String email = ''; // 이메일
  String nickname = ''; // 닉네임

  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      Map<String, dynamic> user = await UserApi.userInfo();

      setState(() {
        email = user['email'];
        nickname = user['nickname'];
      });
    } catch (e) {
      print("Error loading user info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 여백 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.edit_note),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
              ),
            ),
            Center(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 80, // 원형의 반지름
                  backgroundImage:
                      NetworkImage(profilePictureUrl), // 네트워크 URL을 사용하여 이미지 로드
                ),
                const SizedBox(height: 20),
                Text(
                  nickname,
                  style: const TextStyle(
                    fontSize: 35, // 폰트 크기
                    fontWeight: FontWeight.bold, // 볼드체
                  ),
                ),
                const SizedBox(height: 5), // 닉네임과 이메일 사이 여백
                // 이메일
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 18, // 폰트 크기
                    color: Colors.grey, // 이메일 텍스트 색상
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
