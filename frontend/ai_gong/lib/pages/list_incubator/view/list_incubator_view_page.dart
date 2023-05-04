import 'dart:ui';

import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ai_gong/common/common.dart';
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
    const textstyle2 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
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
                                      for(var i=int.parse(firstTime),j=1;i<=int.parse(lastTime);i++,j++)
                                        Expanded(
                                          child: Column(
                                            children: [
                                                Text(i.toString(),style: TextStyle(
                                                  color: (j == 6 || j == 7) ? Color(0xffC7D0DB) : Colors.black,
                                                  decoration: (j==6 || j==7)? TextDecoration.lineThrough:null)),
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
                                      Text('예약가능 시간',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),)
                                    ],)                                    
                                  ),
                                Center(
                                  child: Wrap(
                                    spacing: 50.0, // 각 버튼 사이의 가로 간격
                                    runSpacing: 40.0, // 버튼 사이 세로 간격
                                    children: [
                                      for(double i=9.0,j=1.0;i<=17.0;i+=0.5,j++)
                                        Container(
                                          width: 110,
                                          height: 55,
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            child: Text(
                                              '${i.toInt()}:${(i % 1 == 0.5) ? "30" : "00"}',
                                              style: TextStyle(color: Colors.black, fontSize: 15),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                  SizedBox(height: 40,),
                                   Container(
                                    height: 60,
                                    child:Row(children: [
                                      SizedBox(height: 10,),
                                      SizedBox(width: 20,),
                                      Text('인원',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),),
                                      SizedBox(width: 230,),
                                      CounterWidget(),
                                    ],)                                    
                                  ),
                             
                                  SizedBox(height: 60,),
                                  Center(
                                    child: Wrap(children: [
                                      Container(
                                        width: 450,
                                        height: 55,
                                        
                                        child: OutlinedButton(
                                          
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    SizedBox(height: 20,),
                                                    Text('예약이 완료 되었습니다.',style: TextStyle(fontSize: 15),),
                                                    SizedBox(height: 8),
                                                    Text('예약시간까지 배정인증을 해주세요.',style: TextStyle(fontSize: 15)),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('확인',style: TextStyle(color: Colors.blue),),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => ListIncubatorViewPage()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                              },);},
                                          child: 
                                          Text(
                                            '예약하기',
                                            style: TextStyle(color: Colors.black, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  SizedBox(height: 20,),
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



class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if(_counter==0){
      setState(() {
        _counter=0;
      });
    }
      setState(() {
      _counter--;
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: <Widget>[

        SizedBox(width: 10,),
       
         Container(
          width: 60,
          height: 40,
          child: ElevatedButton(
          onPressed: _decrementCounter,
          child: Text('-',style: TextStyle(color: Colors.black,fontSize: 26,),),
        ),
        ),
        SizedBox(width: 20),
        Text(
          '$_counter',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 20),
         Container(
          width: 60,
          height: 40,
          child: ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('+',style: TextStyle(color: Colors.black,fontSize:23),),
        ),
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}