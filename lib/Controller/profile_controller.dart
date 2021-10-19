import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:meridasns/model/post.dart';
import 'package:meridasns/model/user.dart';
import 'package:http/http.dart' as https;

class Profile extends GetxController {
  static Profile get to => Get.find();

  Statement common = Get.put(Statement());

  RxList<Post> photoinprofile = <Post>[].obs;
  List<String> innerImage = <String>[].obs;
  RxInt imagelength = 0.obs;
  final profile = Users().obs;
  RxInt randomindext = 1.obs;
  RxString profilename = "".obs;
  RxBool editchk = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //프로필로드
  profile_load(String userid) async {
    var url = Uri.parse(common.baseurl + "/users");
    await https.post(url, body: {
      "id": userid,
    }).then((res) {
      print('resstatus ${res.statusCode}');
      final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
      jsonResult.forEach((e) {
        final store = Users.fromJSON(e);
        profile(store);
      });
    }).catchError((err) {
      print('err  $err');
    });

    if (userid.toString() == common.commonuser.value.id) {
      editchk(true);
    }
  }

  //
  void fetchPosts() async {
    var url = Uri.parse(common.baseurl + "/selectrandom");
    try {
      await https.post(url, body: {
        // print('${userid} // ${common.i}');
        "couplename": common.commonuser.value.couplename.toString(),
      }).then((res) {
        final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
        photoinprofile.clear();
        jsonResult.forEach((e) {
          final store = Post.fromJSON(e);
          photoinprofile.add(store);
        });
      }).catchError((err) {
        print('err1  $err');
      });
    } catch (e) {
      print('err2 $e');
    }
    setimage(photoinprofile);
  }

  setimage(RxList<Post> post) {
    var imagelist = post[0].arr_imgname;
    String temp = imagelist.replaceAll(' ', '');
    innerImage.clear();
    temp
      ..split(',').forEach((element) {
        innerImage.add(element);
      });
  }
}
