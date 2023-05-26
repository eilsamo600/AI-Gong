import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/list_classroom/view/component/classroom_component.dart';
import 'package:ai_gong/pages/search/controller/search_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewPage extends StatelessWidget {
  const SearchViewPage({super.key});

  static TextStyle get _hintStyle =>
      const TextStyle(color: Colors.black54, fontSize: 15);
  static TextStyle get _textStyle =>
      const TextStyle(color: Colors.black, fontSize: 15);
  static const String url = '/search';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchViewController());
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Common.getWidth,
          child: Column(children: [
            AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                '검색',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Colors.black.withOpacity(0.1))),
              ),
              padding: const EdgeInsets.only(bottom: 5),
              child: Theme(
                data: ThemeData(
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Colors.black87, //<-- SEE HERE
                  ),
                ),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  onChanged: (value) {
                    controller.searchClassRoomList(value);
                  },
                  onSubmitted: (value) {
                    controller.searchClassRoomList(value);
                  },
                  backgroundColor: Colors.transparent,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 23,
                  ),
                  suffixIcon: const Icon(
                    Icons.clear_outlined,
                    color: Colors.black54,
                    size: 20,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  placeholderStyle:
                      const TextStyle(color: Colors.black54, fontSize: 15),
                  placeholder: '찾고 싶은 강의실을 검색해보세요.',
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Obx(
                () => controller.classRoomList.isEmpty
                    ? Column(
                        children: const [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            '찾고 싶은 강의실, 교수, 수업을\n검색해 보세요.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 17,
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                if (index == 0) const SizedBox(height: 20),
                                ClassRoomComponent(
                                    model:
                                        controller.classRoomList.value[index]),
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
                        },
                        itemCount: controller.classRoomList.length),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
