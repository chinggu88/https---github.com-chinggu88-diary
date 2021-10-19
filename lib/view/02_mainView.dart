import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:meridasns/Controller/navigation_controller.dart';
import 'package:meridasns/view/03-2_detailview.dart';
import 'package:meridasns/view/03-1_listView.dart';
import 'package:meridasns/view/04-1_calendarView.dart';
import 'package:meridasns/view/05-1_MemoView.dart';

class MainView extends GetView<SelectNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (RouteName.values[controller.currentIndex.value]) {
          case RouteName.ItemListView:
            return ItemListView();
            break;
          case RouteName.CalendarView:
            return CalendarView();
            break;
          case RouteName.MemoView:
            return MemoView();
            break;
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey,
          onTap: controller.changeIndex,
          items: [
            BottomNavigationBarItem(label: '리스트', icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: '달력', icon: Icon(Icons.calendar_today)),
            BottomNavigationBarItem(label: '메모', icon: Icon(Icons.bookmark)),
          ],
        ),
      ),
    );
  }
}
