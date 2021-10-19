import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/createphoto_controller.dart';
import 'package:meridasns/Controller/listview_controller.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Createview extends StatelessWidget {
  PhotoList controller = Get.put(PhotoList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Obx(() {
              return Column(
                children: [
                  Photocreate.to.images.length != 0
                      ? Container(
                          height: 300,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(
                                Photocreate.to.images.length, (i) {
                              Asset asset = Photocreate.to.images[i];
                              return AssetThumb(
                                asset: asset,
                                width: 300,
                                height: 300,
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: 100,
                          child: IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () {
                              Photocreate.to.loadAssets();
                            },
                          ),
                        ),
                  SingleChildScrollView(
                    child: Container(
                      height: 100,
                      child: TextField(
                        decoration: InputDecoration(hintText: '내용을 입력하세요'),
                        controller: Photocreate.to.textEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
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
                      await Photocreate.to.uploadiamge();
                      Get.offAllNamed('/Main');
                    },
                  ),
                ],
              );
            })));
  }
}
