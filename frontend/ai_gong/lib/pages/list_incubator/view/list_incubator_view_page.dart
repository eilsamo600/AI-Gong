import 'dart:ui';

import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ai_gong/common/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ListIncubatorViewPage extends StatelessWidget {
  const ListIncubatorViewPage({super.key});


  @override
  Widget build(BuildContext context) {

    List<Widget> buttons = [];
    final now = DateTime.now().toUtc();
    final firstTime = DateFormat('d').format(DateTime.utc(now.year, now.month, now.day - (now.weekday - 1)));
    final lastTime = DateFormat('d').format(DateTime.utc(now.year, now.month, now.day + (7 - now.weekday)));
    final monthText = DateFormat('M월').format(DateTime(now.month, 5));
  
    final controller = Get.put(ListIncubatorViewController());
    const textstyle = TextStyle(fontSize: 20);
    const textstyle2 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
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
                                children:[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    child: Row(children: [
                                      SizedBox(width: 15,),
                                      Text('소회의실 1',style: textstyle2),
                                    ]),
                                  ),
                                
                                SizedBox(height: 45, ),
                                Container(
                                  height: 55,
                                  child:Row(children: [
                                    SizedBox(width: 15,),
                                    Text(monthText, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 2.0)),
                                    
                                  ],)
                                ),
                               
                                Container(
                                  child: Row(children: [
                                    SizedBox(width: 25),
                                    Text("월"),
                                    SizedBox(width:60),
                                    Text("화"),
                                    SizedBox(width:55),
                                    Text("수"),
                                    SizedBox(width:60),
                                    Text("목"),
                                    SizedBox(width:55),
                                    Text("금"),
                                    SizedBox(width:55),
                                    Text("토",style: TextStyle(color: Color(0xffC7D0DB)),),
                                    SizedBox(width:60),
                                    Text("일",style: TextStyle(color: Color(0xffC7D0DB)),),
                                  ]),
                                ),
                                SizedBox(height: 20,),
                                
                                Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      for(var i=int.parse(firstTime),j=0;i<=int.parse(lastTime);i++,j++)
                                        Expanded(
                                          child: Column(
                                            children: [
                                                Text(i.toString()),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                 Container(
                                  width: 500,
                                  child: Divider(color: Colors.grey,height: 1,
                                   thickness: 0.6,)   
                                  ),
                                  Container(
                                    height: 100,
                                    child:Row(children: [
                                      SizedBox(height: 70,),
                                      SizedBox(width: 20,),
                                      Text('예약가능 시간',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),)
                                    ],)                                    
                                  ),
                                  Wrap(
                                    spacing: 40.0, // 각 버튼 사이의 가로 간격
                                    runSpacing: 30.0, // 각 버튼 사이의 세로 간격
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '9:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '9:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '10:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '10:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '11:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '11:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '12:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '12:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '13:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                       Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '13:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '14:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '14:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                       Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '15:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '15:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '16:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '16:30',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '17:00',
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      // 추가적인 버튼들은 여기에 추가
                                    ],
                                  ),

                                  // for(int i=0;i<16;i++){
                                  //   buttons.add(
                                  //     Container(
                                  //       width: 100,
                                  //       height: 50,
                                  //       child: OutlinedButton(
                                  //         onPressed: () {},
                                  //         child: Text('${9 + i~/2}:${i%2==0 ? '00' : '30'}', style:TextStyle(color: Colors.black, fontSize: 14),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   );
                                  // }

                                  // Container(
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: buttons,
                                  //   ),
                                  // ),
                                  // Container(
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       Container(
                                  //         width: 100,
                                  //         height: 50,
                                  //         child: OutlinedButton(
                                  //           onPressed: () {},
                                  //           child: Text('9:00',style:TextStyle(color: Colors.black, fontSize: 14),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         height: 50,
                                  //         child: OutlinedButton(
                                  //           onPressed: () {},
                                  //           child: Text('9:00',style:TextStyle(color: Colors.black, fontSize: 14),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         height: 50,
                                  //         child: OutlinedButton(
                                  //           onPressed: () {},
                                  //           child: Text('9:00',style:TextStyle(color: Colors.black, fontSize: 14),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         height: 50,
                                  //         child: ElevatedButton(
                                  //           onPressed: () {},
                                  //           child: Text('9:00',style:TextStyle(color: Colors.black, fontSize: 14),
                                  //           ),
                                  //         ),
                                  //       ),
                                       
                                        
                                  //     ],
                                  //   ),
                                  // ),

                                
                              
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

// class TableCalendarScreen extends StatelessWidget {
//   const TableCalendarScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: TableCalendar(
//         firstDay: DateTime.utc(2023, 5, 1),
//         lastDay: DateTime.utc(2023, 5, 7),
//         focusedDay: DateTime.now(),
//         locale: 'ko-KR',
//       ),
//     );
//   }
// }
// class reservationTime extends StatelessWidget{
//    const reservationTime({super.key});
//    List<Widget> buttons = [];
//     for(int i=9;i<=17;i++){
//                                    buttons.add(
//                                     OutlinedButton(
//                                       onPressed: () {},
//                                       child: Text('$i:00',style:TextStyle(color: Colors.black, fontSize: 14),
//                                     ),
//                                   );
//                                   buttons.add(
//                                     OutlinedButton(
//                                       onPressed: () {},
//                                       child: Text('$i:30',style:TextStyle(color: Colors.black, fontSize: 14),
//                                     ),
//                                   );
//                                   }

// }