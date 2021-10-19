import 'dart:convert';

import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:http/http.dart' as https;
import 'package:meridasns/model/post.dart';

class Connect_item extends GetxController {
  static Connect_item get to => Get.find();
  Statement common = Get.put(Statement());

  //메인 리스트 목록 load
  Future<List<Post>> loadPhoto() async {
    var url = Uri.parse(common.baseurl + "/select");
    RxList<Post> post = [Post()].obs;

    var res = await https.post(url, body: {
      "couplename": "merida",
    });

    if (res.body != null) {
      final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
      jsonResult.forEach((e) {
        final store = Post.fromJSON(e);
        post.add(store);
      });
    }
    return post;
  }
  //
}
