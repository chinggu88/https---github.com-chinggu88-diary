import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/calendar_controller.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return CalendarList.to.events.length != 0
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                  ),
                  Expanded(
                    child: Container(
                      child: TableCalendar(
                        rowHeight: Get.size.height / 8.3,
                        builders: CalendarBuilders(
                          dayBuilder: (context, date, events) {
                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontFamily: 'lottefont',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          },
                          selectedDayBuilder: (context, date, events) {
                            CalendarList.to.pickdate(date);
                            return Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  alignment: Alignment.topCenter,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontFamily: 'lottefont',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          todayDayBuilder: (context, date, events) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  alignment: Alignment.topCenter,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontFamily: 'lottefont',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          markersBuilder: (context, date, events, holidays) {
                            final children = <Widget>[];

                            if (events.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: SingleChildScrollView(
                                      child: _buildEventsMarker(date, events)),
                                ),
                              );
                            }

                            if (holidays.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  // child: _buildHolidaysMarker(),
                                ),
                              );
                            }

                            return children;
                          },
                        ),
                        calendarController: CalendarList.to.calendarController,
                        events: CalendarList.to.events,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                        ),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Get.dialog(AlertDialog(
                title: Image.asset(
                  'asset/loading/unnamed.gif',
                  scale: 0.5,
                ),
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
              ));
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
        onPressed: () {
          Get.bottomSheet(Container(
            child: Obx(() {
              return Container(
                height: Get.size.height * 0.6,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Container(
                        child: Text(
                          CalendarList.to.pickdate.toString().substring(0, 10),
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 30),
                          child: Text('메모내용!')),
                      Container(
                        width: Get.size.width * 0.8,
                        child: TextField(
                          controller: CalendarList.to.calendarttext,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.check),
                          iconSize: 50,
                          color: Colors.orangeAccent,
                          onPressed: () async {
                            CalendarList.to.saveschedule();
                            Get.back();
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                CalendarList.to.setColor(0);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CalendarList.to.bordercolor[0],
                                      width: 5),
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0) // POINT
                                      ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                CalendarList.to.setColor(1);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CalendarList.to.bordercolor[1],
                                      width: 5),
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0) // POINT
                                      ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                CalendarList.to.setColor(2);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CalendarList.to.bordercolor[2],
                                      width: 5),
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0) // POINT
                                      ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                CalendarList.to.setColor(3);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CalendarList.to.bordercolor[3],
                                      width: 5),
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0) // POINT
                                      ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                CalendarList.to.setColor(4);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CalendarList.to.bordercolor[4],
                                      width: 5),
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0) // POINT
                                      ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ));
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    // var textFields = <SizedBox>[];
    var textFields = <Widget>[];
    int cnt = 0;
    for (String i in events) {
      Color backcolor = Colors.orangeAccent;

      CalendarList.to.schedulereposit.forEach((e) {
        events.forEach((event) {
          if (e.text.toString() == event.toString()) {
            switch (e.calendarcolor) {
              case 'greenAccent':
                backcolor = Colors.greenAccent;
                // print(events.toString());
                break;
              case "blueAccent":
                backcolor = Colors.blueAccent;
                break;
              case "orangeAccent":
                backcolor = Colors.orangeAccent;
                break;
              case "pinkAccent":
                backcolor = Colors.pinkAccent;
                break;
              case "purpleAccent":
                backcolor = Colors.purpleAccent;
                break;
              default:
                backcolor = Colors.orangeAccent;
                break;
            }
          }
        });
      });

      textFields.add(new GestureDetector(
        onTap: () {
          Get.bottomSheet(Container(
            height: Get.size.height * 0.7,
            color: Colors.white,
            child: events != null
                ? ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (BuildContext _context, int i) {
                      Color backcolor = Colors.orangeAccent;
                      CalendarList.to.schedulereposit.forEach((e) {
                        if (e.text.toString() == events[i].toString()) {
                          switch (e.calendarcolor) {
                            case 'greenAccent':
                              backcolor = Colors.greenAccent;
                              // print(events.toString());
                              break;
                            case "blueAccent":
                              backcolor = Colors.blueAccent;
                              break;
                            case "orangeAccent":
                              backcolor = Colors.orangeAccent;
                              break;
                            case "pinkAccent":
                              backcolor = Colors.pinkAccent;
                              break;
                            case "purpleAccent":
                              backcolor = Colors.purpleAccent;
                              break;
                            default:
                              backcolor = Colors.orangeAccent;
                              break;
                          }
                        }
                      });
                      return Row(
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            height: 40,
                            width: 20,
                            color: backcolor,
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Expanded(child: Text(events[i])),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                CalendarList.to.pickdate(date);
                                CalendarList.to.deleteschedule(events[i]);
                                Get.back();
                              })
                        ],
                      );
                    })
                : Text("아무것도 없다"),
          ));
        },
        child: Container(
          width: 50,
          color: backcolor,
          child: Text(
            i,
            style: TextStyle(fontSize: 15, color: Colors.white),
            maxLines: 1,
          ),
        ),
      ));
      if (cnt < 3) {
        cnt++;
      } else {
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: textFields,
      ),
    );
  }
}
