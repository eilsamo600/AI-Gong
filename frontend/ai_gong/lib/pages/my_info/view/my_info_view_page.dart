import 'package:ai_gong/pages/my_info/controller/my_info_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInfoViewPage extends StatelessWidget {
  const MyInfoViewPage({super.key});

  static const String url = '/info';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyInfoViewController());
    return Scaffold(
        appBar: AppBar(
            actions: [],
            title: Text("내 정보", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 241, 249, 255)),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            width: 600,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 600,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color.fromARGB(255, 241, 249, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "202123456",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "홍길동",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(Size(100, 40)),
                            ),
                            onPressed: () {},
                            child: Text(
                              '로그아웃',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 2, color: Color.fromARGB(255, 228, 228, 228)),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 600,
                        color: Color.fromARGB(255, 241, 249, 255),
                        child: Text(
                          "예약현황",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "배정정보가 없습니다.",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "인큐베이터 2 2:00~3:00",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 2, color: Color.fromARGB(255, 228, 228, 228)),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 600,
                        color: Color.fromARGB(255, 241, 249, 255),
                        child: Text(
                          "배정현황",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "아직 배정 인증이 되지 않았습니다.",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "배정 인증이 완료되었습니다.",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 241, 249, 255)),
                                minimumSize:
                                    MaterialStateProperty.all(Size(100, 50)),
                              ),
                              onPressed: () {},
                              child: Text(
                                '배정인증 하기',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
