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
        body: Align(
      alignment: Alignment.center,
      child: Container(
        width: 600,
        margin: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "홍길동님의 활동",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(103, 103, 103, 1)),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "찜 4개",
                        //textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontFamily: 'SuitEB'),
                      ),
                      SizedBox(width: 40),
                      Text(
                        "예약 2건",

                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SuitEB',
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                ],
              ),
            ),

            //Expanded(
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "예약현황",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SuitEB',
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  height: 1,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 75,
                    height: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 600,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 600,
                        // color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        //margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, //하나는 왼쪽 정렬, 하나는 오른쪽 정렬하게 만들어줌
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("소회의실 1",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(height: 3),
                                  Text(
                                    "AI공학관 404호",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text("2023.05.03 16:57",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 140, 140, 140))),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 3),
                                    Text("배정인증 완료",
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color.fromARGB(
                                                255, 0, 140, 255))),
                                    SizedBox(width: 3),
                                    Icon(Icons.check_circle_outline,
                                        color: Color.fromARGB(255, 0, 140,
                                            255)), //Icon(Icons.check_circle_outline_rounded),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                          height: 2, color: Color.fromARGB(255, 228, 228, 228)),
                      Container(
                        width: 600,
                        // color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        //margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, //하나는 왼쪽 정렬, 하나는 오른쪽 정렬하게 만들어줌
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("소회의실 1",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(height: 3),
                                  Text(
                                    "AI공학관 404호",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text("2023.05.03 16:57",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 140, 140, 140))),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 3),
                                        Text("배정인증하기",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Color.fromARGB(
                                                    255, 0, 140, 255))),
                                        //SizedBox(width: 2),
                                        InkWell(
                                          onTap: () {
                                            // 클릭 이벤트
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(
                                                Icons.chevron_right_sharp,
                                                color: Color.fromARGB(
                                                    255, 0, 140, 255)),
                                          ),
                                        )

                                        // IconButton(
                                        //     icon: Icon(
                                        //         Icons.chevron_right_sharp,
                                        //         color: Color.fromARGB(
                                        //             255, 0, 140, 255)),

                                        //     onPressed: () {}),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 3),
                                        Text("취소하기",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Color.fromARGB(
                                                    255, 0, 140, 255))),
                                        // SizedBox(width: 2),
                                        // Icon(Icons.chevron_right_sharp,
                                        //     color: Color.fromARGB(
                                        //         255, 0, 140, 255)),
                                        InkWell(
                                          onTap: () {
                                            // 클릭 이벤트
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(
                                                Icons.chevron_right_sharp,
                                                color: Color.fromARGB(
                                                    255, 0, 140, 255)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                          height: 2, color: Color.fromARGB(255, 228, 228, 228)),
                      Container(
                        width: 600,
                        // color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        //margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, //하나는 왼쪽 정렬, 하나는 오른쪽 정렬하게 만들어줌
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("소회의실 1",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(height: 3),
                                  Text(
                                    "AI공학관 404호",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text("2023.05.03 16:57",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 140, 140, 140))),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 3),
                                    Text("취소되었습니다.",
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color.fromARGB(
                                                255, 255, 44, 44))),
                                    SizedBox(width: 3),
                                    //Icon(Icons.check_circle_outline_rounded),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                          height: 2, color: Color.fromARGB(255, 228, 228, 228)),
                      Container(
                        width: 600,
                        // color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        //margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("예약 정보가 없습니다.",
                                style: TextStyle(
                                    color: Color.fromRGBO(103, 103, 103, 1),
                                    fontSize: 17)),
                            TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 0, 140, 255)),
                                minimumSize:
                                    MaterialStateProperty.all(Size(90, 40)),
                              ),
                              onPressed: () {},
                              child: Text(
                                '예약하기',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
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
            Container(
              child: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all(Size(100, 50)),
                      ),
                      onPressed: () {},
                      child: Text(
                        '로그아웃',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
