import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';

class Profilecreate extends GetxController {
  static Profilecreate get to => Get.find();

  Statement common = Get.put(Statement());

  TextEditingController textEditingController = TextEditingController();
  RxList<PickedFile> images = List<PickedFile>().obs;
  ByteData byteData;
  List<int> imagedata;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  //사진보여주기
  Future<void> loadAssets() async {
    final image = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      images.add(image);
    }
  }

  //사진올리기
  uploadiamge(String kind) async {
    var url = Uri.parse(common.baseurl + "/profile");
    if (images == null) return;
    String fileName = images[0].path.split("/").last;
    var byteData = await images[0].readAsBytes();
    imagedata = byteData.buffer.asUint8List();
    List<int> compressimage = await FlutterImageCompress.compressWithList(
      imagedata,
      quality: 30,
    );

    var base64Image = base64Encode(compressimage);
    print(fileName);

    //이미지파일 저장
    https.post(url, body: {
      "image": base64Image.toString(),
      "id": common.commonuser.value.id.toString(),
      "filename": fileName,
      "kind": kind,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print('err  $err');
    });
    print("success profile!!");
  }
}
