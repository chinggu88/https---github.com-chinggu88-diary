import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:meridasns/Controller/listview_controller.dart';
import 'package:meridasns/Controller/statement_controller.dart';

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.defaultDialog(
        title: "주의",
        content: Text("앱을 종료하시겠습니까?"),
        onConfirm: () =>
            SystemChannels.platform.invokeListMethod('SystemNavigator.pop'),
        onCancel: () => Get.back(),
      ),
      child: Scaffold(
        body: Obx(
          () {
            print(PhotoList.to.aplylist.length);
            return PhotoList.to.photo.length != 1
                ? ListView.builder(
                    controller: PhotoList.to.viewscroll,
                    itemCount: PhotoList.to.photo.length,
                    itemBuilder: (context, index) {
                      String temp =
                          PhotoList.to.photo[index].arr_imgname.toString();
                      temp = temp.replaceAll(' ', '');
                      List innerImage = temp.toString().split(',');
                      return SizedBox(
                        // width: 10,
                        child: Card(
                          elevation: 8.0,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: Get.size.width,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                      left: Get.size.width * 0.05,
                                      top: Get.size.width * 0.07,
                                      bottom: Get.size.width * 0.07,
                                    )),
                                    GestureDetector(
                                        onTap: () {
                                          Get.offNamed('/Profileview',
                                              arguments: PhotoList
                                                  .to.photo[index].texterid);
                                        },
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                Statement.to.baseurl +
                                                    '/profile/' +
                                                    PhotoList.to.photo[index]
                                                        .photourl),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                      left: Get.size.width * 0.05,
                                      top: Get.size.width * 0.07,
                                      bottom: Get.size.width * 0.07,
                                    )),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(PhotoList.to.photo[index].texter,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'lottefont',
                                                  fontSize: 20)),
                                          Padding(
                                              padding: EdgeInsets.only(
                                            bottom: 5,
                                          )),
                                          Text(
                                              PhotoList
                                                  .to.photo[index].insertdate
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'lottefont')),
                                        ],
                                      ),
                                    ),
                                    Statement.to.commonuser.value.id ==
                                            PhotoList.to.photo[index].texterid
                                        ? IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.grey,
                                            onPressed: () {
                                              //게시물삭제
                                              Get.defaultDialog(
                                                  title: "주의!",
                                                  middleText: "게시물을 삭제하시겠습니까?",
                                                  middleTextStyle:
                                                      TextStyle(fontSize: 20),
                                                  onConfirm: () async {
                                                    PhotoList.to
                                                        .deletePhotoitem(
                                                            PhotoList.to
                                                                .photo[index]);
                                                    Get.back();
                                                  },
                                                  textConfirm: "확인",
                                                  textCancel: "취소");
                                            })
                                        : Container()
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              PhotoList.to.photo[index].arr_imgname
                                          .toString() !=
                                      ''
                                  ? Container(
                                      padding: EdgeInsets.only(
                                        left: Get.size.width * 0.05,
                                        right: Get.size.width * 0.05,
                                      ),
                                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                                      height: 150.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: innerImage.length,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10)),
                                                SizedBox(
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        child: GestureDetector(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: Statement
                                                                    .to
                                                                    .baseurl +
                                                                '/diary/' +
                                                                PhotoList
                                                                    .to
                                                                    .photo[
                                                                        index]
                                                                    .filepath +
                                                                '/' +
                                                                innerImage[i],
                                                          ),
                                                          onTap: () {
                                                            Map<String, String>
                                                                detailimage = {
                                                              'filepath': 'diary/' +
                                                                  PhotoList
                                                                      .to
                                                                      .photo[
                                                                          index]
                                                                      .filepath,
                                                              'innerImage':
                                                                  innerImage
                                                                      .toString()
                                                            };
                                                            Get.toNamed(
                                                                '/Detailview',
                                                                arguments:
                                                                    detailimage);
                                                          },
                                                        ))),
                                              ],
                                            );
                                          }),
                                    )
                                  : Container(),
                              ListTile(
                                title: Text(PhotoList.to.photo[index].text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic)),
                              ),
                              Container(
                                width: Get.size.width * 0.9,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Statement.to.baseurl +
                                                '/profile/' +
                                                Statement.to.commonuser.value
                                                    .profilephoto),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                      left: Get.size.width * 0.02,
                                    )),
                                    Expanded(
                                      child: Container(
                                        width: Get.size.width * 0.7,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: '댓글을 입력하세요~'),
                                          controller: PhotoList.to
                                              .textEditingControllerList[index],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.play_arrow_rounded),
                                        iconSize: 30,
                                        color: Colors.orangeAccent,
                                        onPressed: () async {
                                          PhotoList.to.addreply(
                                              PhotoList.to.photo[index].seq,
                                              index);
                                        }),
                                  ],
                                ),
                              ),
                              (PhotoList.to.aplylist.where((e) =>
                                          e.image_seq ==
                                          PhotoList.to.photo[index].seq
                                              .toString())).length !=
                                      0
                                  ? Container(
                                      width: Get.size.width,
                                      height: PhotoList.to.aplylist
                                              .where((e) =>
                                                  e.image_seq ==
                                                  PhotoList.to.photo[index].seq
                                                      .toString())
                                              .length *
                                          45.0,
                                      child: Column(
                                          children: setaply(
                                              PhotoList.to.photo[index].seq)))
                                  : Container(
                                      color: Colors.black,
                                    )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Get.dialog(AlertDialog(
                    title: Image.asset(
                      'asset/loading/unnamed.gif',
                      scale: 0.5,
                    ),
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                  ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: Icon(Icons.create),
          onPressed: () {
            Get.offNamed('/Createview');
          },
        ),
      ),
    );
  }

  //댓글
  List<Widget> setaply(int seq) {
    List<Widget> aplylist = [];
    var temp =
        PhotoList.to.aplylist.where((e) => e.image_seq == seq.toString());
    temp.forEach((e) {
      aplylist.add(Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 5)),
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    Statement.to.baseurl + '/profile/' + e.profilephoto),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(
                child: Text(
              e.aply_text,
              maxLines: 2,
            )),
            Text(e.date.substring(11, 20)),
            Statement.to.commonuser.value.id == e.textid
                ? IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 20,
                    onPressed: () {
                      Get.defaultDialog(
                          title: "주의!",
                          middleText: "댓글을 삭제하시겠습니까?",
                          middleTextStyle: TextStyle(fontSize: 20),
                          onConfirm: () async {
                            PhotoList.to.deleteaply(e.seq);
                            Get.back();
                          },
                          textConfirm: "확인",
                          textCancel: "취소");
                    })
                : Container()
          ],
        ),
      ));
    });
    return aplylist;
  }
}
