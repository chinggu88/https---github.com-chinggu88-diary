import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:meridasns/model/memo.dart';

class Memolist extends GetxController {
  static Memolist get to => Get.find();

  TextEditingController memoController = new TextEditingController();
  Statement common = Get.put(Statement());
  RxList<Memo> memolist = <Memo>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPosts();
  }

  fetchPosts() async {
    var url = Uri.parse(common.baseurl + "/memoview");
    memolist.clear();
    await https.post(url).then((res) {
      final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
      jsonResult.forEach((e) {
        final store = Memo.fromJSON(e);
        memolist.add(store);
      });
    }).catchError((err) {
      print('err  $err');
    });
  }

  //메모저장
  savememo() async {
    String now = new DateTime.now().toString().substring(0, 10);

    var url = Uri.parse(common.baseurl + "/memosave");

    await https.post(url, body: {
      "date": now,
      "text": memoController.text,
      "writer": common.commonuser.value.id.toString(),
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err1  $err');
    });
  }

  //메모삭제
  deletememo(String text, String date) async {
    var url = Uri.parse(common.baseurl + "/memodelete");
    await https.post(url, body: {
      "text": text.toString(),
      "date": date.substring(0, 10),
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err  $err');
    });
  }
}
