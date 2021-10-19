import 'dart:convert';

import 'package:get/get.dart';
import 'package:meridasns/model/user.dart';
import 'package:http/http.dart' as https;

class Statement extends GetxService {
  static Statement get to => Get.find();

  //자동로그인 여부
  RxBool autoLogin = false.obs;
  //서버 url
  RxString baseurl = "".obs;
  //로그인아이디

  // var commonuser = Users.fromJSON({
  //   'seq': 1,
  //   'id': 'chinggu88@gmail.com',
  //   'name': '이강훈',
  //   'age': '880609',
  //   'sexuality': 'M',
  //   'couplename': 'merida',
  //   'photourl': 'merida',
  //   'backgroundphoto': 'chinggu88@gmail.com/2021/2021-04-07/image_picker.jpg',
  //   'profilephoto': 'chinggu88@gmail.com/2021/2021-04-07/image_picker.jpg'
  // }).obs;
  var commonuser = Users().obs;

  @override
  void onInit() {
    super.onInit();
    autoLogin = false.obs;

    // baseurl = "http://3.34.45.152:3001".obs;
    baseurl = "http://222.108.135.234:3001".obs;
    login('chinggu88@gmail.com');
    // login('119eugene@gmail.com');
    //test usert setting
  }

  login(String id) async {
    autoLogin(true);
    print("로그인");
    var url = Uri.parse(baseurl + "/users");
    await https.post(url, body: {
      "id": id,
    }).then((res) {
      print(res.statusCode);
      final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));

      jsonResult.forEach((e) {
        final store = Users.fromJSON(e);
        commonuser(store);
      });
    }).catchError((err) {
      print('err11  $err');
    });

    print(commonuser.value.toJson());
    if (commonuser.value != null) {
      Get.offNamed('/Main');
    }
  }
}
