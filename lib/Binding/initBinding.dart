import 'package:get/get.dart';
import 'package:meridasns/Controller/calendar_controller.dart';
import 'package:meridasns/Controller/createphoto_controller.dart';
import 'package:meridasns/Controller/createprofile_controller.dart';
import 'package:meridasns/Controller/listview_controller.dart';
import 'package:meridasns/Controller/memo_controller.dart';
import 'package:meridasns/Controller/profile_controller.dart';
import 'package:meridasns/reposit/photo_reposit.dart';
import 'package:meridasns/Controller/navigation_controller.dart';
import 'package:meridasns/Controller/statement_controller.dart';

class InitBind extends Bindings {
  @override
  void dependencies() {
    //컨트롤러 등록
    Get.lazyPut(() => Statement());
    Get.lazyPut(() => SelectNavigator());
    Get.lazyPut(() => Connect_item());
  }
}

class Listview_Bind extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => PhotoList());
    Get.put(PhotoList());
  }
}

class Profile_Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Profile());
  }
}

class Calendar_Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarList());
    // Get.lazyPut(() => CalendarList());
  }
}

class Memo_Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Memolist());
  }
}

class Create_Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Photocreate());
  }
}

class Profilecreate_Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Profilecreate());
  }
}
