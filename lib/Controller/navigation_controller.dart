import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/view/04-1_calendarView.dart';

enum RouteName {
  ItemListView,
  CalendarView,
  MemoView,
}

class SelectNavigator extends GetxService {
  static SelectNavigator get to => Get.find();

  RxInt currentIndex;

  @override
  void onInit() {
    super.onInit();
    currentIndex = 0.obs;
  }

  void changeIndex(int index) {
    currentIndex(index);
  }
}
