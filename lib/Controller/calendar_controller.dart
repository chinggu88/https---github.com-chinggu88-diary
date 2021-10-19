import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:meridasns/model/schedulelist.dart';
import 'package:http/http.dart' as https;
import 'package:table_calendar/table_calendar.dart';

class CalendarList extends GetxController {
  static CalendarList get to => Get.find();

  Statement common = Get.put(Statement());

  RxList<Schedulelist> schedulereposit = <Schedulelist>[].obs;
  CalendarController calendarController = CalendarController();
  RxMap<DateTime, List> events = <DateTime, List>{}.obs;
  Rx<DateTime> pickdate = DateTime.now().obs;
  TextEditingController calendarttext = TextEditingController();
  RxList<Color> bordercolor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ].obs;
  String colorname;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    viewschedule();
  }

  //스케줄 목록
  void viewschedule() async {
    schedulereposit.clear();
    var url = Uri.parse(common.baseurl + "/scheduleview");

    try {
      await https.post(url, body: {
        "couplename": 'merida',
      }).then((res) {
        var parsedResponse = jsonDecode(res.body)
            .map<Schedulelist>((json) => Schedulelist.fromJSON(json))
            .toList();

        schedulereposit.addAll(parsedResponse);

        setevent(schedulereposit);
      }).catchError((err) {
        print('err  $err');
      });
    } catch (e) {
      print('err $e');
    }

    var text = new List<String>();
    var color = new List<String>();
    text.clear();
    color.clear();

    for (int i = 0; i < schedulereposit.length; i++) {
      // eventscolor[schedulereposit[i].text] = schedulereposit[i].calendarcolor;
      var rescent = schedulereposit[i].date.toString().split('-');
      var today = DateTime(
          int.parse(rescent[0]), int.parse(rescent[1]), int.parse(rescent[2]));

      if (i == schedulereposit.length - 1) {
        text.add(schedulereposit[i].text.toString());
        events[today] = text.toList();
        text.clear();
      } else if (schedulereposit[i].date == schedulereposit[i + 1].date) {
        text.add(schedulereposit[i].text);
      } else {
        text.add(schedulereposit[i].text.toString());
        events[today] = text.toList();
        text.clear();
      }
    }
  }

  setColor(int index) {
    int i = 0;
    bordercolor.clear();
    bordercolor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ].obs;

    bordercolor[index] = Colors.black;
    bordercolor.forEach((element) {
      if (element == Colors.black) {
        switch (i) {
          case 0:
            colorname = "greenAccent";
            break;
          case 1:
            colorname = "blueAccent";
            break;
          case 2:
            colorname = "orangeAccent";
            break;
          case 3:
            colorname = "pinkAccent";
            break;
          case 4:
            colorname = "purpleAccent";
            break;
        }
      }
      i++;
    });
  }

  // 스케줄저장
  void saveschedule() async {
    var url = Uri.parse(common.baseurl + "/schedulesave");
    //스케줄 저장
    await https.post(url, body: {
      "date": pickdate.toString().substring(0, 10),
      "text": calendarttext.text.toString(),
      "writer": common.commonuser.value.id.toString(),
      "couplename": common.commonuser.value.couplename.toString(),
      "calendarcolor": colorname,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err  $err');
    });
    calendarttext.text = "";
    viewschedule();
  }

  // 스케줄삭제
  void deleteschedule(String text) async {
    var url = Uri.parse(common.baseurl + "/scheduledelete");
    //스케줄 저장
    await https.post(url, body: {
      "date": pickdate.toString().substring(0, 10),
      "text": text,
      "couplename": common.commonuser.value.couplename.toString(),
    }).then((res) {
      print('${res.statusCode}');
    }).catchError((err) {
      print('err  $err');
    });

    viewschedule();
  }

  Map<DateTime, List> setevent(List<Schedulelist> list) {
    events.clear();
    var text = new List<String>();
    var color = new List<String>();
    text.clear();
    color.clear();

    for (int i = 0; i < list.length; i++) {
      // eventscolor[_Schedulelist[i].text] = _Schedulelist[i].calendarcolor;
      var rescent = list[i].date.toString().split('-');
      var today = DateTime(
          int.parse(rescent[0]), int.parse(rescent[1]), int.parse(rescent[2]));

      if (i == list.length - 1) {
        text.add(list[i].text.toString());
        events[today] = text.toList();
        text.clear();
      } else if (list[i].date == list[i + 1].date) {
        text.add(list[i].text);
      } else {
        text.add(list[i].text.toString());
        events[today] = text.toList();
        text.clear();
      }
    }
    return events;
  }
}
