import 'package:ai_gong/common/common.dart';
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
        width: Common.getWidth,
        child: Column(
          children: [
            Expanded(
                child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                        child: Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  const Text('오늘은', style: textstyle),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(Common.instance.getNowWeek(controller.now.value), style: textstyle2)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    '현재 시간은',
                                    style: textstyle,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Common.instance.getNowTime(controller.now.value),
                                    style: textstyle2,
                                  )
                                ],
                              )
                            ],
                          ),
                        ))),
                SliverPersistentHeader(pinned: true, floating: true, delegate: HeaderDelegate(controller)),
                Obx(
                  () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                    ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            if (index == 0) const SizedBox(height: 20),
                            ClassRoomComponent(model: controller.classRoomList.value[index]),
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
                    childCount: controller.classRoomList.length,
                  )),
                )
              ],
            ))
          ],
        ));
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final ListClassRoomViewController controller;
  HeaderDelegate(this.controller);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10),
      decoration: BoxDecoration(color: Colors.white, border: shrinkOffset > 0 ? const Border(bottom: BorderSide(color: Colors.black12)) : const Border()),
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
    );
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
