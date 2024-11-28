import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// page
import 'package:tunetalk/api/auth.dart';
import 'package:tunetalk/login_page.dart';
import 'package:tunetalk/page_list.dart';
// 상태 관리 클래스
import 'package:tunetalk/user_provider.dart';
import 'package:tunetalk/api/user_api.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    bool isValid = await Auth.validateToken();

    Future.delayed(const Duration(seconds: 2), () async {
      if (isValid) {
        Map<String, dynamic> user = await UserApi.userInfo();
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUserId(user['id']);
        userProvider.setUserEmail(user['email']);
        userProvider.setUserNickname(user['nickname']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PageList()),
        );
      } else {
        Auth.clearToken();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text(
          'Tune Talk',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
