import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:meridasns/model/post.dart';
import 'package:meridasns/model/aply.dart';
import 'package:http/http.dart' as https;
import 'package:multi_image_picker/multi_image_picker.dart';

class PhotoList extends GetxController {
  static PhotoList get to => Get.find();

  Statement common = Get.put(Statement());
  RxList<Post> photo = <Post>[].obs;
  RxList<Aply> aplylist = <Aply>[].obs;
  ScrollController viewscroll = ScrollController();
  RxInt startPage = 0.obs;
  //댓글 텍스트저장소
  RxList<TextEditingController> textEditingControllerList =
      List<TextEditingController>().obs;

  RxList<Asset> images = List<Asset>().obs;
  ByteData byteData;
  List<int> imagedata;

  @override
  void onInit() {
    super.onInit();
    loadphoto(startPage);
    event();
    loadaply();
  }

  event() {
    viewscroll.addListener(() {
      // print(viewscroll.position.pixels);
      if (viewscroll.position.maxScrollExtent == viewscroll.position.pixels) {
        loadphoto(startPage);
      }
    });
  }

  loadphoto(RxInt index) async {
    print(index);
    //댓글컨트롤러 추가
    if (textEditingControllerList.length == 0) {
      textEditingControllerList.clear();
    }

    //메인 리스트 목록 load
    var url = Uri.parse(common.baseurl + "/selecttest");

    try {
      await https.post(url, body: {
        "couplename": common.commonuser.value.couplename.toString(),
        "index": index.toString(),
      }).then((res) {
        final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
        if (index == 0) {
          photo.clear();
          textEditingControllerList.clear();
        }

        jsonResult.forEach((e) {
          final store = Post.fromJSON(e);
          photo.add(store);

          var test = new TextEditingController();
          //댓글컨트롤러 추가
          textEditingControllerList.add(test);
        });
      }).catchError((err) {
        print('listview err  $err');
      });

      startPage = startPage + 20;
    } catch (e) {
      print('listview err $e');
    }
  }

  deletePhotoitem(Post item) async {
    var url = Uri.parse(common.baseurl + "/delete");
    await https.post(url, body: {
      "seq": item.seq.toString(),
    }).then((res) {
      startPage(0);
      loadphoto(startPage);
    }).catchError((err) {
      print('err  $err');
    });
  }

  //댓글달기
  addreply(int seq, int controllerindex) async {
    var url = Uri.parse(common.baseurl + "/reply");
    await https.post(url, body: {
      "seq": seq.toString(),
      "name": common.commonuser.value.name.toString(),
      "text": textEditingControllerList[controllerindex].text,
      "profilephoto": common.commonuser.value.profilephoto.toString(),
      "texterid": common.commonuser.value.id.toString(),
      "couplename": common.commonuser.value.couplename.toString(),
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err11  $err');
    });

    var addreply = Aply(
      seq: aplylist.length,
      image_seq: seq.toString(),
      name: common.commonuser.value.name.toString(),
      aply_text: textEditingControllerList[controllerindex].text,
      profilephoto: common.commonuser.value.profilephoto.toString(),
      textid: common.commonuser.value.id.toString(),
      couplename: common.commonuser.value.couplename.toString(),
      date: DateTime.now().toString(),
    );
    aplylist.insert(0, addreply);
    textEditingControllerList[controllerindex].text = "";
  }

  //댓글보여주기
  loadaply() async {
    // print('reaerawerawer ${common.commonuser.value.couplename}');
    var url = Uri.parse(common.baseurl + "/replyview");
    try {
      await https.post(url, body: {
        "couplename": common.commonuser.value.couplename,
      }).then((res) {
        final jsonResult = jsonDecode(utf8.decode(res.bodyBytes));
        aplylist.clear();
        jsonResult.forEach((e) {
          final aplytemp = Aply.fromJSON(e);
          aplylist.add(aplytemp);
        });
      }).catchError((err) {
        print('aply err  $err');
      });
    } catch (e) {
      print('aply err $e');
    }
  }

  //댓글삭제
  deleteaply(int seq) async {
    var url = Uri.parse(common.baseurl + "/deletereply");

    try {
      await https
          .post(url, body: {
            "seq": seq.toString(),
          })
          .then((res) {})
          .catchError((err) {
            print('err  $err');
          });
    } catch (e) {
      print('err $e');
    }

    aplylist.removeWhere((e) => e.seq == seq);
  }
}
