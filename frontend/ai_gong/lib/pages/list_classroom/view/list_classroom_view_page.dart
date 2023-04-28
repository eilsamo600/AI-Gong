import 'package:ai_gong/pages/list_classroom/controller/list_classroom_view_controller.dart';
import 'package:ai_gong/pages/list_classroom/view/classroom_component.dart';
import 'package:ai_gong/pages/list_classroom/view/filter_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListClassRoomViewPage extends StatelessWidget {
  const ListClassRoomViewPage({super.key});

  static const String url = '/list_classroom';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListClassRoomViewController());
    const textstyle = TextStyle(fontSize: 20);
    const textstyle2 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    return SizedBox(
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('오늘은', style: textstyle),
                      SizedBox(
                        width: 7,
                      ),
                      Text('월요일', style: textstyle2)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        '현재 시간은',
                        style: textstyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '오후 3시 50분',
                        style: textstyle2,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.onTapList.value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Column(
                        children: [
                          FilterComponent(
                            index: index,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.classRoomList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ClassRoomComponent(model: controller.classRoomList.value[index]),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20, top: 25),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                              ),
                            )
                          ],
                        );
                      }),
                ))
          ],
        ));
  }
}
