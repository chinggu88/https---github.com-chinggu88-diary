import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:meridasns/model/post.dart';
import 'package:http/http.dart' as https;
import 'package:multi_image_picker/multi_image_picker.dart';

class Photocreate extends GetxController {
  static Photocreate get to => Get.find();

  Statement common = Get.put(Statement());
  RxList<Post> photo = <Post>[].obs;
  ScrollController viewscroll = ScrollController();

  TextEditingController textEditingController = TextEditingController();

  RxList<Asset> images = List<Asset>().obs;
  ByteData byteData;
  List<int> imagedata;

  @override
  void onInit() {
    super.onInit();
  }

  //사진보여주기
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      // selectedAssets: images,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "#abcdef",
        actionBarTitle: "Example App",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
    images(resultList);
  }

  //사진올리기
  uploadiamge() async {
    var imagename = List(images.length);

    var base64Image = List(images.length);
    var filename = List(images.length);
    var url = Uri.parse(common.baseurl + "/image");

    for (int i = 0; i < images.length; i++) {
      byteData = await images[i].getByteData();
      imagedata = byteData.buffer.asUint8List();

      List<int> compressimage = await FlutterImageCompress.compressWithList(
        imagedata,
        quality: 30,
      );

      base64Image[i] = base64Encode(compressimage);
      filename[i] = images[i].name;
      imagename[i] = filename[i];
    }

    //이미지파일 저장
    await https.post(url, body: {
      "image": base64Image.toString(),
      "name": imagename.toString(),
      "user": common.commonuser.value.name,
      "text": textEditingController.text,
      "photourl": common.commonuser.value.profilephoto,
      "texterid": common.commonuser.value.id,
      "photopath": common.commonuser.value.couplename,
      "couplename": common.commonuser.value.couplename,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err11  $err');
    });
  }
}
