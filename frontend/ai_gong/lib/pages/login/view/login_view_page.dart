import 'package:ai_gong/pages/login/controller/login_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../common/common.dart';

class LoginViewPage extends StatelessWidget {
  const LoginViewPage({super.key});

  static const String url = '/login';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewController());
    return Material(
      child: Center(
          child: Column(children: <Widget>[
        TextButton(
            child: Text('로그인'),
            style: TextButton.styleFrom(
                fixedSize: const Size(400, 45),
                foregroundColor: Colors.black,
                backgroundColor: Color.fromARGB(70, 200, 200, 200),
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: ((context) {
                    return PanelComponent(
                      child: Center(
                          child: Column(children: <Widget>[
                        const SizedBox(
                          height: 100,
                        ),
                        const Text('간단하게 로그인 하고',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('메타버스 인큐베이터 예약하기',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          height: 150,
                        ),
                        const Text('애공은 가천 계정으로만 로그인 할 수 있어요!',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('ex) abcdefg.gachon.ac.kr',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        const SizedBox(
                          height: 100,
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: "   구글 계정으로 로그인",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ])),
                    );
                  }));
            }),
      ])),
    );
  }
}
