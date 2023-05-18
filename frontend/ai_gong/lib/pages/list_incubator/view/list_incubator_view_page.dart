import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:ai_gong/pages/list_incubator/view/component/incubator_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: prefer_const_constructors

class ListIncubatorViewPage extends StatelessWidget {
  const ListIncubatorViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListIncubatorViewController());
    const textstyle = TextStyle(fontSize: 20);
    const textstyle2 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    return SizedBox(
        width: Common.getWidth,
        child: Column(
          children: [
            Expanded(
                child: CustomScrollView(
              controller: controller.scrollcontroller.value,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 45, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('METAVERSE INCUBATOR',
                                style: textstyle2),
                            const SizedBox(
                              width: 7,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  '소희의실 예약하기',
                                  style: textstyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  //Dialog Main Title
                                  title: Center(
                                    child: Text("소회의실 이용안내",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  //
                                  content: Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            "\n운영 시간",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("공휴일을 제외한 평일(월-금) 09:00-17:00"),
                                          Text("\n장소",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("가천대학교 AI공학관 404호, 405호 "),
                                          Text("\n소회의실 예약 안내",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("예약 가능 인원 : 2-6명"),
                                          Text(
                                              "예약 가능 시간 : 30분 단위, 최대 2시간까지 예약 가능"),
                                          Text("배정인증은 소회의실 근처 와이파이 연결 여부로 가능"),
                                          Text(
                                              "예약시간 10분 후까지 배정인증이 완료되지 않으면 자동으로 예약 취소"),
                                          Text("\n이용수칙",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("1. 음료를 제외한 음식물 반입을 금지한다."),
                                          Text("2. 타 학우들의 면학환경을 위해 최대한 정숙한다."),
                                          Text("3. 장시간 자리 비움을 금지한다."),
                                          Text("4. 자리 정돈 후 퇴실힌다.\n"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("확인",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1.2,
                                            color: Colors.black87,
                                          )),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: TextButtonWithSubfixIconChild(
                          label: Text('소회의실 이용안내',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.2,
                                color: Colors.black87,
                              )),
                          icon: Icon(Icons.info_outline_rounded,
                              color: Colors.black87, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                    ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            if (index == 0) const SizedBox(height: 20),
                            IncubatorComponent(
                                model: controller.incubatorList.value[index]),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 15),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    childCount: controller.incubatorList.length,
                  )),
                )
              ],
            ))
          ],
        ));
  }
}

class TextButtonWithSubfixIconChild extends StatelessWidget {
  TextButtonWithSubfixIconChild({
    Key? key,
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(child: label),
        SizedBox(width: 4),
        icon,
      ],
    );
  }
}
