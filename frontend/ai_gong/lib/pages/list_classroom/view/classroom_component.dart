import 'package:flutter/material.dart';

class ClassRoomComponent extends StatelessWidget {
  const ClassRoomComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 13),
            width: 11,
            height: 11,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '304호',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '소프트웨어 전공',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      '3층, 수용 인원 50명',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: const [
                        Text(
                          '대형 강의실 | ',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text('사용 가능', style: TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              '다음 수업이 없습니다.',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
