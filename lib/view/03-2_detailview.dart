import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:meridasns/Controller/statement_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Detailview extends StatelessWidget {
  var filepath = Get.arguments['filepath'];
  var imagelist = setinnerimage(Get.arguments['innerImage']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _setbody(),
    );
  }

  Widget _setbody() {
    return Stack(
      children: [
        Container(
            child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(Statement.to.baseurl +
                  '/' +
                  filepath +
                  '/' +
                  imagelist[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
              onTapUp: (context, details, controllerValue) {
                Get.defaultDialog(
                    title: "다운로드!",
                    middleText: "게시물을 다운로드하시겠습니까?",
                    middleTextStyle: TextStyle(fontSize: 20),
                    onConfirm: () async {
                      // GallerySaver.saveImage(Statement.to.baseurl +
                      //         '/' +
                      //         filepath +
                      //         '/' +
                      //         imagelist[index])
                      //     .then((value) => print('>>>> save value= $value'))
                      //     .catchError((err) {
                      //   print('error :( $err');
                      // });
                      print("클릭!");
                    },
                    textConfirm: "확인",
                    textCancel: "취소");
              },
              // heroAttributes: HeroAttributes(tag: imagelist[index]),
            );
          },
          itemCount: imagelist.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        )),
      ],
    );
  }
}

setinnerimage(String imagename) {
  var a = imagename.replaceAll('[', '');
  a = a.replaceAll(']', '');
  a = a.replaceAll(' ', '');
  return a.split(',');
}
