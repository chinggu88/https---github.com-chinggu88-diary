import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/createprofile_controller.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Createprofile extends StatelessWidget {
  var kind = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(kind);
    return Scaffold(body: Obx(() {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Center(child: Text('사진을 선택하세요')),
          Profilecreate.to.images.length == 0
              ? IconButton(
                  icon: Icon(Icons.photo_album),
                  iconSize: 30,
                  onPressed: () async => Profilecreate.to.loadAssets())
              : Container(
                  child: Center(
                    child: Image.file(File(Profilecreate.to.images[0].path)),
                  ),
                ),
          IconButton(
              icon: Icon(Icons.check),
              iconSize: 50,
              color: Colors.orangeAccent,
              onPressed: () async {
                Get.dialog(AlertDialog(
                  title: Image.asset(
                    'asset/loading/unnamed.gif',
                    scale: 0.5,
                  ),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                ));
                await Profilecreate.to.uploadiamge(kind['kind'].toString());
                Get.offAllNamed('/Main');
              })
        ],
      );
    }));
  }
}
