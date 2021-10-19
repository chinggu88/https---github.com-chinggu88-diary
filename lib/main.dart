import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Binding/initBinding.dart';
import 'package:meridasns/Controller/listview_controller.dart';
import 'package:meridasns/Controller/statement_controller.dart';

import 'package:meridasns/view/01_login.dart';
import 'package:meridasns/view/02_mainView.dart';
import 'package:meridasns/view/03-2_detailview.dart';
import 'package:meridasns/view/03-1_listView.dart';
import 'package:meridasns/view/03-3_createview.dart';
import 'package:meridasns/view/03-4_profileView.dart';
import 'package:meridasns/view/03-5_createProfilView.dart';
import 'package:meridasns/view/04-1_calendarView.dart';
import 'package:meridasns/view/05-1_MemoView.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/Login",
    initialBinding: InitBind(),
    getPages: [
      GetPage(name: '/Login', page: () => LoginView()),
      GetPage(
        name: '/Main',
        page: () => MainView(),
        bindings: [
          Listview_Bind(),
          Memo_Bind(),
          Calendar_Bind(),
        ],
      ),
      GetPage(
        name: '/Detailview',
        page: () => Detailview(),
      ),
      GetPage(
        name: '/Createview',
        page: () => Createview(),
        bindings: [Create_Bind()],
      ),
      GetPage(
        name: '/Profileview',
        page: () => Profileview(),
        bindings: [Profile_Bind()],
      ),
      GetPage(
        name: '/Createprofile',
        page: () => Createprofile(),
        bindings: [Profilecreate_Bind()],
      ),
    ],
  ));
}
