import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListIncubatorViewPage extends StatelessWidget {
  const ListIncubatorViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListIncubatorViewController());
    return Scaffold(
      body: Column(
        children: [
          const Text('인큐베이터 목록 페이지'),
          ElevatedButton(
              onPressed: () => {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: ((context) {
                          return PanelComponent(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('인큐베이터 선택 페이지'),
                              ],
                            ),
                          );
                        }))
                  },
              child: const Text(
                '인큐베이터 선택 페이지',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
