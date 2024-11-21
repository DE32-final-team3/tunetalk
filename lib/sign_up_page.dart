import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  // 이미 사용 중인 이메일 및 닉네임 목록 (예시)
  //final List<String> _existingEmails = [
  //  'test@example.com',
  //  'user@example.com',
  //  'admin@example.com'
  //];
  //final List<String> _existingNicknames = ['user1', 'admin', 'example_user'];

  // 이메일 유효성 검사
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요.';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '유효한 이메일 형식을 입력해주세요.';
    }
    //if (_existingEmails.contains(value)) {
    //  return '이미 사용 중인 이메일입니다.';
    //}
    return null;
  }

  // 비밀번호 유효성 검사
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    if (value.length < 8 || value.length > 16) {
      return '비밀번호는 8자 이상 16자 이하이어야 합니다';
    }

    // 정규식으로 각 조건 확인
    bool hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value); // 영문자 포함 여부
    bool hasDigit = RegExp(r'\d').hasMatch(value); // 숫자 포함 여부
    bool hasSpecial =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value); // 특수문자 포함 여부

    // 최소 2가지 조건 만족 여부
    int conditionsMet =
        (hasLetter ? 1 : 0) + (hasDigit ? 1 : 0) + (hasSpecial ? 1 : 0);
    if (conditionsMet < 2) {
      return '비밀번호는 영문, 숫자, 특수문자 중 최소 2가지를 포함해야 합니다';
    }

    return null; // 검증 통과
  }

  // 닉네임 유효성 검사
  String? _validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.trim().isEmpty) {
      return '닉네임에 공백만 입력할 수 없습니다.';
    }
    //if (_existingNicknames.contains(value.trim())) {
    //  return '이미 사용 중인 닉네임입니다.';
    //}
    return null;
  }

  // 회원가입 처리 함수
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      //final email = _emailController.text;
      //final nickname = _nicknameController.text;

      // 성공적으로 회원가입 처리 완료
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입 성공')),
      );

      // 모든 입력 필드 초기화
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _nicknameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이메일 입력
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              // 닉네임 입력
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: _validateNickname,
              ),
              const SizedBox(height: 16),
              // 비밀번호 입력
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: _validatePassword, //(value) {
                //   if (value == null || value.isEmpty) {
                //     return '비밀번호를 입력해주세요.';
                //   }
                //   if (value.length < 6) {
                //     return '비밀번호는 최소 6자 이상이어야 합니다.';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 16),
              // 비밀번호 확인 입력
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.check),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  }
                  if (value != _passwordController.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 회원가입 버튼
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // 버튼의 크기 설정
                ),
                child: const Text('회원가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
